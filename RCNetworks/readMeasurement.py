## -*- coding: utf-8 -*-
#"""
#
#"""
# import from future to make Python2 behave like Python3
from __future__ import absolute_import
from __future__ import division
from __future__ import print_function
from __future__ import unicode_literals
from future import standard_library
standard_library.install_aliases()
from builtins import *
from io import open
# end of from future import

from buildingspy.io.outputfile import Reader
import pandas as pd
import datetime as dt
import scipy.interpolate as interpolate
import matplotlib.pyplot as plt
import numpy as np

mea = Reader('HighThermalMassWall.mat','dymola')

# Inputs
t, T_int = mea['wal.T_int']
t, T_ext = mea['wal.T_ext']
t, q_int = mea['wal.q_int']
t, q_ext = mea['wal.q_ext']

# Outputs
Ts_int = mea['wal.Ts_int']
Ts_ext = mea['wal.Ts_ext']

res = df.DataFrame({'T_int':T_int,
					'T_ext':T_ext,
					'q_int':q_int,
					'q_ext':q_ext,
					'Ts_int':Ts_int,
					'Ts_ext':Ts_ext}, index=t)
					
res.to_csv('measure.csv')