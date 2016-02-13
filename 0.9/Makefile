IMAGE=ninjasphere/influxdb
INFLUX_COMMIT=782a283e22df745eedcd1c2bd253dcc73d2ae99b
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
	cp $(GOPATH)/src/github.com/influxdb/influxdb/build/influx_tsm influx_tsm
	cp $(GOPATH)/src/github.com/influxdb/influxdb/build/influxd influxd
	cp $(GOPATH)/src/github.com/influxdb/influxdb/build/influx influx

install: binary
	sudo cp influx /usr/local/bin
	sudo cp influxd /usr/local/bin
	sudo cp influx_tsm /usr/local/bin
	sudo cp influx_inspect /usr/local/bin