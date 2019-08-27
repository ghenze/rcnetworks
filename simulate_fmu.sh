  exec docker run \
 	  --name bes_control \
          --user=root \
	  --detach=false \
	  -e DISPLAY=${DISPLAY} \
	  -v /tmp/.X11-unix:/tmp/.X11-unix\
	  --rm \
	  -v `pwd`:/mnt/shared \
	  -i \
          -t \
	  jmodelica /bin/bash -c "cd /mnt/shared && python /mnt/shared/simulate_fmu.py"
	exec docker attach bes_control  
    exit $
