# Introduction


# How to Install
There are multiple ways to install JModelica on local computers. 

For Mac OS, because binary distribution is not available now, users have to building JModleica from its source codes. To avoid the trivial process of building a software program from scratch, here we will use Docker as a distribution medium. A Docker container that has JModelica installed can be easily transferred between different computers.  

For Windows OS, there are a binary distribution here. Users can download the \*.exe installer and install directly. Windows' users can also install JModelica through Docker as illustrated in MacOS.

# Mac OS
For Mac OS, follow the steps below to install Docker and JModelica

## Install Docker

Docker desktop can be downloaded [here](https://www.docker.com/products/docker-desktop). 
You need sign up to get directed to the download page.

After downloading the installer (\*.exe or \*.mkg), you can click and install Docker.

After installing Docker, you can open Docker, and leave it running.

More tutorials about Docker can be found [here](https://docs.docker.com/get-started/).

## Install JModelica
### Get latest installation codes
Update RCNetworks package by downloading the latest master branch in [here](https://github.com/YangyangFu/rcnetworks).

Note: **avoid having space in the directory names.**

### Build JModelica Containers 

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
	
	A successful execution will generate serveral files, including a *\*.mat* file and a *\*.eps/png* file. The \*.mat is the simulation results of Modelica models, and the \*.eps/png file is the plotted results defined in *simulate_fmu.py*.
	

## Run Optimization Example
1. Go to optimization example folder. Type in the terminal:

	<code>cd Optimization</code>
	
2. Run optimization examples. Type:

	<code>bash optimize.sh</code>
	
	If permission denied, try:
	
	<code>sudo bash optimize.sh</code>


# Windows OS
The easiest way in Windows is to intall the JModelica binary distribution provided by JModelica team.

## Install JModelica
The JModelica binary installer for Windows OS is provided [here](https://jmodelica.org/downloads/JModelica.org-2.10.exe). Download, click and install the installer (e.g., JModelica.org-2.10.exe) on your local computer.

Just follow the steps to install. When you choose the installation directory, avoid using space in the folder names. For example, instead of using "/jmodelica installation", we can use "/jmodelica-installation".

## Run JModelica Examples

1. Set up `MODELICAPATH`.

	In this class, we will use two libraries: Modelica Standard Library (MSL) and RCNetworks. We need first make sure these two libraries are on `MODELICAPATH`.
	
	
	- Put MSL on `MODELICAPATH`.
	  
	 The MSL is located at `your/installation/folder/JModelica-org-2.4/install/ThirdParty/MSL`.
	 
	 Set the above path to `MODELICAPATH`. On Windows 7, system environment variables can be set in `Control Panel -> System and Security -> System -> Advanced System Settings -> Environment Variables`. Enter in the `Variable` column `MODELICAPATH` and enter in the Value column your MSL directory, e.g., `your/installation/folder/JModelica-org-2.4/install/ThirdParty/MSL`.		  
	
	- Put RCNetworks on `MODELICAPATH`.
	The easiest way is to copy RCNetworks into MSL. The resulting MSL folder will have the following structure:
	
		-- Modelica
		
		-- Modelica Service
		
		-- RCNetworks
		
	
2. Open JModelica. 
	
	Direct to the jmodelica: `start menu -> Jmodelica.org-2.4 -> Ipython`.
	
	Open the `Ipython` terminal. 
	
	Congrats. You just activated JModelica.
	
3. Install necessary python packages for post-processing
	
	In the opened Ipython terminal, direct to the folder `rcnetworks-master` by typing:
	
	`cd /your/downloaded/rcnetwork-master`
	
	Then, run the requirement script provided by `install_requirements_win.py` by typing:
	
	`run install_requirements_win.py`
	
	So far, the environment for this class should be all set.
	
	
4. To test the environment, we can try to compile and simulate an example as provided in this folder.

	First, compile a Modelica model in JModleica. Type:
	
	`run compile_fmu.py`
	
	Then, simulate the Modelica model compiled by JModelica. Type:
	
	`run simulate_fmu.py`
	
5. Now if the compilation and simulation works, we can move to optimization.

	First direct to the optimization folder:
	
	`cd Optimization`
	
	Then, start the optimization by typing:
	
	`run optimize.py`
	
	A successful execution will generate serveral files, including a *\*.mat* file, a *\*.eps/png* file and a *\*.txt* file. The *\*.mat* is the simulation results of Modelica models, and the *\*.eps/png* file is the plotted results defined in *optimize.py*. The *\*.txt* file is the optimization results that contain optimal `R`s and `C`s for a given order `n`.
Users can change any settings they see fit in the *optimize.py*.
	