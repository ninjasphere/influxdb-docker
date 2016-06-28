IMAGE=ninjasphere/influxdb
SHA1 := $(shell git rev-parse --short HEAD)
INFLUXDB_SHA1=stable-20160628

build:
	cd $(GOPATH)/src/github.com/influxdata/influxdb && \
	 git fetch origin --tags && \
	 git checkout $(INFLUXDB_SHA1)^0 && \
	 gdm restore && \
	 GO_VER=1.6 ./build-docker.sh
	docker build -t $(IMAGE):$(SHA1) .
	@echo built...$(IMAGE):$(SHA1)

push: build
	docker push $(IMAGE):$(SHA1)
