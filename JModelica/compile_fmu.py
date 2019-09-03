# -*- coding: utf-8 -*-
"""
This module compiles the defined test case model into an FMU using the
overwrite block parser.

The following libraries must be on the MODELICAPATH:

- Modelica IBPSA
- Modelica Buildings

"""

from pymodelica import compile_fmu
# DEFINE MODEL
# ------------
# library path
mopath = 'RCNetworks'; 
# model path
modelpath = 'RCNetworks.Examples.HighThermalMassWall'
# ------------

# COMPILE FMU: set JVM maximum leap to 1G to avoid memory issues
# -----------
#fmupath = parser.export_fmu(modelpath, [mopath])
fmupath = compile_fmu(modelpath,[mopath], jvm_args='-Xmx1g')
# -----------



