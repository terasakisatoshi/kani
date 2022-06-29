.PHONY: all, build

IMAGE="kani"

all: build
	docker build -t ${IMAGE} .
