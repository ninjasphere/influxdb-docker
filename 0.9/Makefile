IMAGE=ninjasphere/influxdb
INFLUX_COMMIT=a7bf1e90773603152de569e2e5b768a765416c5e
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
	cd $(GOPATH)/src/github.com/influxdb/influxdb && git checkout ${INFLUX_COMMIT} && GOOS=linux GOARCH=amd64 go install ./...
	cp $(GOPATH)/bin/influxd influxd
