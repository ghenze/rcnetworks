# -*- coding: utf-8 -*-
"""
This module compiles the defined test case model into an FMU using the
overwrite block parser.

The following libraries must be on the MODELICAPATH:

- RCNetworks
- intepolation 
- output surface temperaure for CSV
- RMSE in the results

"""
# import numerical package
import numpy as np
import pandas as pd
import matplotlib
matplotlib.use('agg')
import matplotlib.pyplot as plt
# import buildingspy
from buildingspy.io.outputfile import Reader


import os
from collections import OrderedDict
from scipy.io.matlab.mio import loadmat
import numpy as N
from pymodelica import compile_fmu
from pyfmi import load_fmu
from pyjmi import transfer_optimization_problem
from pyjmi.optimization.casadi_collocation import ExternalData
from sklearn.metrics import r2_score
import json
import scipy.interpolate as interpolate

# Compile and load FMU, which is used for simulation
model = load_fmu(compile_fmu('OrderReduction.RCOrderReduction', "OrderReduction.mop"))
# Transfer problem to CasADi Interface, which is used for estimation
op = transfer_optimization_problem("OrderReduction.reduceOrder",
 "OrderReduction.mop")
# get the model order
n = int(model.get('n'))
print(n)
#model.set_integer('n', n)


## experiment time
startTime = 0
finalTime = 172800

## Load measurement data from file
meas = pd.read_csv('measure.csv', index_col=[0])

# Extract data series
t_mea = meas.index
T_ext_mea = meas['T_ext']
T_int_mea = meas['T_int']
q_ext_mea = meas['q_ext']
q_int_mea = meas['q_int']
Ts_ext_mea = meas['Ts_ext']
Ts_int_mea = meas['Ts_int']

# plot measurement
plt.close(2)
plt.figure(2)
plt.subplot(211)
plt.plot(t_mea, Ts_int_mea-273.15, 'b', label = 'Measurement')
plt.ylabel('Temperature [$^\circ$C]')
plt.title('$T_{s,int}$')
plt.grid(True)
plt.hold(True)
plt.subplot(212)
plt.plot(t_mea, Ts_ext_mea-273.15, 'b',label = 'Measurement')
plt.ylabel('Temperature [$^\circ$C]')
plt.xlabel('Time [s]')
plt.title('$T_{s,ext}$')
plt.grid(True)
plt.hold(True)
plt.show()

# Set initial states in model, which are stored in the optimization problem
x_0_names = ['T_start', 'Ts_ext_start', 'Ts_int_start']
x_0_values = op.get(x_0_names)
print(x_0_values)
x_0_values[0] = 273.15 + 20
x_0_values[1] = Ts_ext_mea[0]
x_0_values[2] = Ts_int_mea[0]
print(x_0_values)
model.set(x_0_names, x_0_values)

# Inputs for the optimization model
u = N.transpose(N.vstack([t_mea, T_int_mea, T_ext_mea, q_int_mea, q_ext_mea]))

# Now let's simulate the model with default parameters: before simulation
res_sim = model.simulate(input=(['T_int', 'T_ext', 'q_int', 'q_ext'], u), start_time=startTime, final_time=finalTime)

# Load simulation results
t_sim = res_sim['time']
Ts_ext_sim = res_sim['Ts_ext']
Ts_int_sim = res_sim['Ts_int']

# Plot simulation results
plt.figure(2)
plt.subplot(211)
plt.plot(t_sim, Ts_int_sim-273.15, 'r',label = 'Simulation')
plt.subplot(212)
plt.plot(t_sim, Ts_ext_sim-273.15, 'r',label = 'Simulation')
plt.hold(True)
plt.show()

'''Clearly, there is a mismatch in the response, which is
why we need calibration by tuning some parameters.
'''

# Create external data object for optimization
Q = N.diag([1., 1.])
data_x1 = N.vstack([t_mea, Ts_ext_mea])
data_x2 = N.vstack([t_mea, Ts_int_mea])
quad_pen = OrderedDict()
quad_pen['Ts_ext'] = data_x1
quad_pen['Ts_int'] = data_x2
external_data = ExternalData(Q=Q, quad_pen=quad_pen)

# Set optimization options and optimize
opts = op.optimize_options()
opts['n_e'] = 60 # Number of collocation elements
opts['external_data'] = external_data
opts['init_traj'] = res_sim
opts['nominal_traj'] = res_sim
res = op.optimize(options=opts) # Solve estimation problem

# Extract estimated values of parameters
r_opt=N.zeros([n+1,1])
c_opt=N.zeros([n,1])
for i in range(0,n):
	r_opt[i] = res.initial('r['+str(i+1)+']')
	c_opt[i] = res.initial('c['+str(i+1)+']')
r_opt[n] = res.initial('r['+str(n+1)+']')

# print optimal variables
print('Optimal r is: ' + str(r_opt))
print('Optimal c is: ' + str(c_opt))

### Plot the optimization case
Ts_ext_opt = res['Ts_ext']
Ts_ext_opt[0] = Ts_ext_mea[0] # temporary solution for popping out the first crazy element. Need debug the model.
Ts_int_opt = res['Ts_int']
Ts_int_opt[0] = Ts_int_mea[0]
t_opt = res['time']


#
intp = interpolate.interp1d(t_opt,Ts_ext_opt, kind='linear')
Ts_ext_opt_intp = intp(t_mea)
intp = interpolate.interp1d(t_opt,Ts_int_opt, kind='linear')
Ts_int_opt_intp = intp(t_mea)

# Plot calibrated results
plt.figure(2)
plt.subplot(211)
plt.plot(t_mea, Ts_int_opt_intp-273.15, 'go',markersize=2,label = 'Calibration')
plt.subplot(212)
plt.plot(t_mea, Ts_ext_opt_intp-273.15, 'go',markersize=2,label = 'Calibration')
plt.legend()
plt.savefig('result_cal_order'+str(n)+'.eps')
plt.show()



# Calculate RMSE and CVRSE
def RMSE(y_true,y_predict):
    # numpy array
    rmse = np.sqrt(N.sum(N.square(y_true-y_predict))/len(y_true))
    return rmse

def CVRMSE(y_true,y_predict):
    # numpy array
    rmse = RMSE(y_true,y_predict)
    m = N.mean(y_true)
    return rmse/max(0.00001,abs(m))

y_true=N.append(Ts_ext_mea.array, Ts_int_mea.array)


y_predict = N.append(Ts_ext_opt_intp, Ts_int_opt_intp)
print(y_true.shape)
print(y_predict.shape)
## Ouput calibrated data as csv
Ts_opt=pd.DataFrame({'Ts_ext':Ts_ext_opt_intp,'Ts_int':Ts_int_opt_intp}, index=t_mea)
Ts_opt.to_csv('Calibrated-results.csv')

# calculate metrics
rmse = RMSE(y_true,y_predict)
cvrmse = CVRMSE(y_true,y_predict)
r2 = r2_score(y_true,y_predict)

results = {'r2':r2,'cvrmse':cvrmse,'rmse':rmse,'n':n, 'r_opt':r_opt.tolist(), 'c_opt':c_opt.tolist()}
with open('results'+'_order'+str(n)+'.txt','w') as outputfile:
    json.dump(results,outputfile)
