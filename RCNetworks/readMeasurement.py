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

ts = 0
te = 1200

# Inputs
t1, T_int = mea.values('wal.T_int')
t2, T_ext = mea.values('wal.T_ext')
t3, q_int = mea.values('wal.q_int')
t4, q_ext = mea.values('wal.q_ext')

# Outputs
t5, Ts_int = mea.values('wal.Ts_int')
t6, Ts_ext = mea.values('wal.Ts_ext')

tim = np.arange(ts,te+1,10)

intp = interpolate.interp1d(t1,T_int,kind = 'linear')
T_int = intp(tim)
intp = interpolate.interp1d(t2,T_ext,kind = 'linear')
T_ext = intp(tim)
intp = interpolate.interp1d(t3,q_int,kind = 'linear')
q_int = intp(tim)
intp = interpolate.interp1d(t4,q_ext,kind = 'linear')
q_ext = intp(tim)
intp = interpolate.interp1d(t5,Ts_int,kind = 'linear')
Ts_int = intp(tim)
intp = interpolate.interp1d(t6,Ts_ext,kind = 'linear')
Ts_ext = intp(tim)


res = pd.DataFrame({'T_int':T_int,
					'T_ext':T_ext,
					'q_int':q_int,
					'q_ext':q_ext,
					'Ts_int':Ts_int,
					'Ts_ext':Ts_ext}, index = tim)
					
res.to_csv('measure.csv')