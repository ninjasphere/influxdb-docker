IMAGE=ninjasphere/influxdb
INFLUX_COMMIT=b8bb32ecad9808ef00219e7d2469514890a0987a
SHA1 := $(shell git rev-parse --short HEAD)

build: binary
	docker build -t $(IMAGE):$(SHA1) .
	docker tag -f $(IMAGE):$(SHA1) $(IMAGE):latest
	@echo built...$(IMAGE):$(SHA1)

push: build
	docker push $(IMAGE):$(SHA1)

push-latest:
	docker push $(IMAGE):latest

binary:
	go get -d github.com/influxdb/influxdb
	cd $(GOPATH)/src/github.com/influxdb/influxdb && \
	git checkout ${INFLUX_COMMIT} && \
	./build.sh
	cp $(GOPATH)/src/github.com/influxdb/influxdb/build/influxd influxd
