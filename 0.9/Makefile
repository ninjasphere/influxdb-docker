build: binary
	docker build -t ninjasphere/influxdb:$$(git rev-parse --short HEAD) .

push: build
	docker push ninjasphere/influxdb:$$(git rev-parse --short HEAD)

binary:
	go get -d github.com/influxdb/influxdb
	cd $(GOPATH)/src/github.com/influxdb/influxdb && GOOS=linux GOARCH=amd64 go install ./...
	cp $(GOPATH)/bin/linux_amd64/influxd influxd
