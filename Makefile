IMAGE=ninjasphere/influxdb
SHA1 := $(shell git rev-parse --short HEAD)

build:
	godep restore
	cd $(GOPATH)/src/github.com/influxdb/influxdb && ./build-docker.sh
	docker build -t $(IMAGE):$(SHA1) .
	docker tag -f $(IMAGE):$(SHA1) $(IMAGE):latest
	@echo built...$(IMAGE):$(SHA1)

push: build
	docker push $(IMAGE):$(SHA1)

push-latest:
	docker push $(IMAGE):latest

