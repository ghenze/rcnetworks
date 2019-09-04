# Introduction
This is a simple package of RC networks in Modelica for teaching purposes.

The following files are contained in this folder:

- *Dockerfile*: this is a dockerfile that helps build a local docker container. It first pulls existing cloud JModelica image, then install necessary python packges for this class, and finally copy RCNetworks package into MODELICAPATH.
- *makefile*: this file is used to compile a local JModelica container from source codes in the Dockerfile.
- *compile_fmu.py*: a Python script that compiles \*.mo file into \*.fmu file using JModelica.
- *compile_fmu.sh*: a Bash script that calls JModelica environment installed in a docker container and executes *compile_fmu.py*.
- *simulate_fmu.py*: a Python script that simulates the compiled \*.fmu file using JModelica.
- *simulate_fmu.sh*: a Bash script that calls JModelica environment installed in a docker container and executes *simulate_fmu.py*.
- *readMeasurement.py*: a Python script that can read simulation data \*.mat file generated from OpenModelica and Dymola.
- *Optimization*: this folder contains example codes and data to perform optimization of the model order reduction problem in Modelica.
- *RCNetworks*: this folder contains basic thermal RC components.
- *Tutorial*: this folder contains tutorials for OpenModelica and JModelica.


# Installation
This package has been tested in OpenModelica, Dymola and JModelica. 
To run this package in the local computers, we need follow the following steps:

## Install Modelica Environment
### Install OpenModelica
The first open-source Modelica complier introduced here is [OpenModelica](https://openmodelica.org/). 
Users can directly download and install the binary distribution in [windows OS](https://build.openmodelica.org/omc/builds/windows/releases/1.13/2/), [mac OS](https://build.openmodelica.org/omc/builds/mac/binaries/) ("latest-stable.mpkg") and [Linux](https://openmodelica.org/download/download-linux).

### Install JModelica
See `Tutorials/JModelica`.

## Install RCNetworks Package
This package can be directly downloaded from the github homepage [here](https://github.com/YangyangFu/rcnetworks). 

# Run Models
## OpenModelica
The graphic interface for OpenModelica is called "OpenModelica Connection Editor (OMEdit)". 
Tutorials on how to start OpenModelica can be found [here](https://openmodelica.org/doc/OpenModelicaUsersGuide/latest/omedit.html).

Once users get familiar with OpenModelica interface, they can open the RCNetwork package to start the modeling of thermal RC network by clicking the "package.mo" file located in your/package/path/rcnetworks/RCNetworks/.

## JModelica
See `Tutorials/JModelica`.

# Contact
Yangyang Fu

yangyang.fu@colorado.edu
