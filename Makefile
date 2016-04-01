IMAGE=ninjasphere/influxdb
SHA1 := $(shell git rev-parse --short HEAD)
INFLUXDB_SHA1=stable-20160401

build:
	cd $(GOPATH)/src/github.com/influxdb/influxdb && git checkout $(INFLUXDB_SHA1) && git pull --ff-only && godep restore && ./build-docker.sh
	docker build -t $(IMAGE):$(SHA1) .
	docker tag -f $(IMAGE):$(SHA1) $(IMAGE):latest
	@echo built...$(IMAGE):$(SHA1)

push: build
	docker push $(IMAGE):$(SHA1)

push-latest:
	docker push $(IMAGE):latest

