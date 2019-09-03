# Introduction


# How to Install
There are multiple ways to install JModelica in local computers. 
For teaching purposes, to avoid massive documentation for different OSs, here we will use a compact way that utilizes Docker as a distribution medium.
This installation method works for windows, macOS, and Linux.


## Install Docker

Docker can be downloaded [here](https://www.docker.com/products/docker-desktop). 

## Install Bash

## Install JModelica
### Get latest installation codes
Update RCNetworks package by downloading the latest master branch in [here](https://github.com/YangyangFu/rcnetworks).

### Build JModelica Container

The JModelica image is hosted in [here](https://cloud.docker.com/u/yangyangfu/repository/docker/yangyangfu/fncs). We need to pull it into our local computers to build a local JModleica container. 

1. Open a terminal, and change the working directory to the foler where the *Dockerfile* is at. For example, in my computer, the *Dockerfile* is located at /home/github/rcnetworks.  I need to type the following commands in the opened terminal:

	<code>cd /home/github/rcnetworks</code>

2. Build a local JModelica container. Type:

	<code>make build</code>
	
	If there is permission error, type
	
	<code>sudo make build</code> 
	
	The terminal will show a message at the bottom that if the build is successful.

## Run JModelica Examples

Two examples are contained in the working directory to test if the environment is sucessfully installed: *compile_fmu.sh* and *simulate_fmu.sh*.
	
1. run *compile_fmu.sh*. Type:
	
	<code>bash compile_fmu.sh</code>
	
	If permission denied, try:
	
	<code>sudo bash compile_fmu.sh</code>
	
	A successful execution will generate serveral files, including a *.fmu file. This is the Modelica model being compiled in the JModleica environment.
	
2. run *simulate_fmu.sh*. Type:
	
	<code>bash simulate_fmu.sh</code>
	
	If permission denied, try:
	
	<code>sudo bash simulate_fmu.sh</code>
	
	A successful execution will generate serveral files, including a \*.mat file and a \*.eps/png file. The \*.mat is the simulation results of Modelica models, and the \*.eps/png file is the plotted results defined in *simulate_fmu.py*.
	

## Run Optimization Example
1. Go to optimization example folder. Type in the terminal:

	<code>cd ./Optimization</code>
	
2. Run optimization examples. Type:

	<code>bash optimize.sh</code>
	
	If permission denied, try:
	
	<code>sudo bash optimize.sh</code>
