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
name = "RCNetworks_Examples_M3R2C.fmu"
fmu = load_fmu(name)
# Get input names
input_names = fmu.get_model_variables(causality = 2).keys();
print input_names
print('Inputs: {0}'.format(input_names))



# simulate setup
startTime = 0*24*3600
endTime = 1*4*3600

# input

# simulate
opts = fmu.simulate_options()
opts['CVode_options']['atol']=1e-6
res = fmu.simulate(start_time = startTime, final_time=endTime, options=opts)

# read output
t = res['time']
q= res['m2R1C.Q_flow']

print t
print q

plt.figure()
plt.subplot()
plt.plot(t,q)
plt.ylabel('Heat flow (W)')
plt.xlabel('Time (s)')
plt.savefig('q.eps')

