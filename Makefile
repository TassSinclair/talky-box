IMAGE_NAME=talky-box
VOLUME_MOUNTS=-v `pwd`/data:/data
build:
		docker build -t ${IMAGE_NAME} .
run:
		docker run ${VOLUME_MOUNTS} --device /dev/snd -it --rm --name ${IMAGE_NAME} --privileged ${IMAGE_NAME}
debug:
		docker run ${VOLUME_MOUNTS} -e DEBUG=true --device /dev/snd -it --rm --name ${IMAGE_NAME} --privileged ${IMAGE_NAME} /bin/bash
