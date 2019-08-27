# -*- coding: utf-8 -*-
"""
This module compiles the defined test case model into an FMU using the
overwrite block parser.

The following libraries must be on the MODELICAPATH:

- Modelica IBPSA
- Modelica Buildings

"""
# import numerical package
import numpy as np
import matplotlib
matplotlib.use('agg')
import matplotlib.pyplot as plt
# import fmu package
from pyfmi import load_fmu
# import buildingspy
from buildingspy.io.outputfile import Reader


## load fmu
name = "RCNetworks_Examples_HighThermalMassWall.fmu"
fmu = load_fmu(name)
# Get input names
input_names = fmu.get_model_variables(causality = 2).keys();
print input_names
print('Inputs: {0}'.format(input_names))



## simulation setup: 
# start time: 0s
startTime = 0
# endtime: 1200 s
endTime = 1200

# input: this fmu doesn't require external inputs for co-simulation, therefore left for blank.

# get the simulation options
opts = fmu.simulate_options()
# change the solver tolerance
opts['CVode_options']['atol']=1e-6


## simulate the fmu
res = fmu.simulate(start_time = startTime, final_time=endTime, options=opts)

## read output after successful simulation
# time index
t = res['time']
# outdoor temperature
T_ext = res['wal.T_ext'] - 273.15 # in degC
# indoor temperature
T_int = res['wal.T_int'] - 273.15 # in degC
# surface temperature at exterior wall
Ts_ext = res['wal.Ts_ext'] - 273.15 # in degC
# surface temperature at interior wall
Ts_int = res['wal.Ts_int'] - 273.15 # in degC
# heat flux: positive - from outdoor to indoor; negative - from indoor to outdoor 
q = res['wal.E0.port_a.Q_flow'] # in W/m2

print t
print q

plt.figure()
plt.subplot(211)
plt.plot(t,T_ext)
plt.plot(t,T_int)
plt.plot(t,Ts_ext)
plt.plot(t,Ts_int)
plt.ylabel(u'Temperature (\circ^C)')
plt.xlabel(u'Time (s)')
plt.legend(['T_ext', 'T_int','Ts_ext', 'Ts_int'])
plt.grid(True)

plt.subplot(212)
plt.plot(t,q)
plt.ylabel(u'Heat Flow (W/m2)')
plt.xlabel(u'Time (s)')
plt.grid(True)
plt.savefig('plot-results.png')
plt.show(True)

