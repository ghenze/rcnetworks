# folder structure
-*baseline*: this is a folder, which contains baseline data for calibration of model order reduction problem. 

-*.mo: a basic Modelica RC model. The order of the RC model needs to be optimized.

-*\*.fmu*: FMU model compiled from Modleica model *\*.mo*. 

-*compile_fmu.py*: a Python script that compiles \*.mo file into \*.fmu file in a JModelica environment.

-*compile_fmu.sh*: a Bash script that calls JModelica environment installed in a docker container and executes *compile_fmu.py*.



