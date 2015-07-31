#!/bin/bash

cat <<EOF
bind-address = "0.0.0.0"
port = 8086
reporting-disabled = false

[meta]
  dir = "/data/meta"

[initialization]
  join-urls = ""

[authentication]
  enabled = ${INFLUX_AUTHENTICATION_ENABLED:-false}

[http]
  auth-enabled = ${INFLUX_AUTHENTICATION_ENABLED:-false}

[admin]
  enabled = true
  port = 8083
  assets = "/opt/influxdb/current/admin"

[api]
  bind-address = "0.0.0.0"
  port = 8086

[collectd]
  enabled = false

[opentsdb]
  enabled = false

[udp]
  enabled = false

[broker]
  dir = "/data/broker"
  enabled = true
  election-timeout = "0"

[data]
  dir = "/data/db"
  enabled = true
  retention-auto-create = true
  retention-check-enabled = true
  retention-check-period = "10m0s"
  retention-create-period = "45m0s"

[snapshot]
  enabled = false

[logging]
  write-tracing = false
  raft-tracing = false
  level  = "info"
  file   = "/data/log/influxdb.log"

[monitoring]
  enabled = false

[debugging]
  pprof-enabled = false

[continuous_queries]
  recompute-previous-n = 2
  recompute-no-older-than = "10m0s"
  compute-runs-per-interval = 10
  compute-no-more-than = "2m0s"
  disabled = false

[hinted-handoff]
  enabled = true
  dir = "/data/hh"
EOF