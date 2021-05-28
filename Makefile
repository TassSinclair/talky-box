IMAGE_NAME=talky-box
MOUNTS=-v `pwd`/data:/data --network=host --device /dev/snd
build-festival:
	docker build -t ${IMAGE_NAME}:festival --file festival.Dockerfile .
run-festival:
	docker run ${MOUNTS} -it --rm --name ${IMAGE_NAME}-festival --privileged ${IMAGE_NAME}:festival
debug-festival:
	docker run ${MOUNTS} -it --rm --name ${IMAGE_NAME}-festival --privileged ${IMAGE_NAME}:festival /bin/bash
		
build-flite:
	docker build -t ${IMAGE_NAME}:flite --file flite.Dockerfile .
run-flite:
	docker run ${MOUNTS} -it --rm --name ${IMAGE_NAME}-flite --privileged ${IMAGE_NAME}:flite
debug-flite:
	docker run ${MOUNTS} -it --rm --name ${IMAGE_NAME}-flite --privileged ${IMAGE_NAME}:flite /bin/bash