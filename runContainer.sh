  exec docker run \
 	  --name jmodelica \
          --user=root \
	  --detach=false \
	  -e DISPLAY=${DISPLAY} \
	  -v /tmp/.X11-unix:/tmp/.X11-unix\
	  --rm \
	  -v `pwd`:/mnt/shared \
	  -i \
          -t \
	  bes_control /bin/bash -c "cd /mnt/shared && python /mnt/shared/test.py"

    exit $
