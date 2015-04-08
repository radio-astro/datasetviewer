DOCKER_REPO=radioastro/notebook

.PHONY: build clean run force-build

all: build run 

build:
		docker build -t ${DOCKER_REPO} .

force-build:
	docker build -t ${DOCKER_REPO} --no-cache --pull .

clean:
	docker rmi ${DOCKER_REPO}

run:
	docker run -it -p 8888:8888 \
		-v $(realpath notebooks):/notebooks:rw \
		-v $(realpath data):/data:ro \
		${DOCKER_REPO}
