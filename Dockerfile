FROM influxdb
MAINTAINER Jon Seymour "<jon@ninjablocks.com>"
ENV GOGC=800
ENV GODEBUG=gctrace=1