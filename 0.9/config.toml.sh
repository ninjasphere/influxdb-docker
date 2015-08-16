#!/bin/bash

cat <<EOF
### Welcome to the InfluxDB configuration file.

# Once every 24 hours InfluxDB will report anonymous data to m.influxdb.com
# The data includes raft id (random 8 bytes), os, arch, version, and metadata.
# We don't track ip addresses of servers reporting. This is only used
# to track the number of instances running and the versions, which
# is very helpful for us.
# Change this option to true to disable reporting.
reporting-disabled = false

###
### [meta]
###
### Controls the parameters for the Raft consensus group that stores metadata
### about the InfluxDB cluster.
###

[meta]
  dir = "/data/meta"
  hostname = "localhost"
  bind-address = ":8088"
  retention-autocreate = true
  election-timeout = "1s"
  heartbeat-timeout = "1s"
  leader-lease-timeout = "500ms"
  commit-timeout = "50ms"

###
### [data]
###
### Controls where the actual shard data for InfluxDB lives and how it is
### flushed from the WAL. "dir" may need to be changed to a suitable place
### for your system, but the WAL settings are an advanced configuration. The
### defaults should work for most systems.
###

[data]
  dir = "/data/db"
  max-wal-size = 104857600 # Maximum size the WAL can reach before a flush. Defaults to 100MB.
  wal-flush-interval = "10m0s" # Maximum time data can sit in WAL before a flush.
  wal-partition-flush-delay = "2s" # The delay time between each WAL partition being flushed.

###
### [cluster]
###
### Controls non-Raft cluster behavior, which generally includes how data is
### shared across shards.
###
[cluster]
  write-timeout = "5s" # The time within which a write operation must complete on the cluster.
  shard-writer-timeout = "5s" # The time within which a shard must respond to write.

###
### [retention]
###
### Controls the enforcement of retention policies for evicting old data.
###
[retention]
  enabled = true
  check-interval = "10m0s"

###
### [admin]
###
### Controls the availability of the built-in, web-based admin interface. If HTTPS is
### enabled for the admin interface, HTTPS must also be enabled on the [http] service.
###
[admin]
  enabled = true
  bind-address = ":8083"
  https-enabled = false
  https-certificate = "/etc/ssl/influxdb.pem"

###
### [http]
###
### Controls how the HTTP endpoints are configured. These are the primary
### mechanism for getting data into and out of InfluxDB.
###
[http]
  enabled = true
  bind-address = ":8086"
  auth-enabled = ${INFLUX_AUTHENTICATION_ENABLED:-false}
  log-enabled = true
  write-tracing = false
  pprof-enabled = false
  https-enabled = false
  https-certificate = "/etc/ssl/influxdb.pem"

###
### [[graphite]]
###
### Controls one or many listeners for Graphite data.
###
[[graphite]]
  enabled = false
  bind-address = ":2003"
  protocol = "tcp"
  consistency-level = "one"
  separator = "."
  database = "graphitedb"
  # These next lines control how batching works. You should have this enabled
  # otherwise you could get dropped metrics or poor performance. Batching
  # will buffer points in memory if you have many coming in.

  # batch-size = 1000 # will flush if this many points get buffered
  # batch-timeout = "1s" # will flush at least this often even if we haven't hit buffer limit
  batch-size = 1000
  batch-timeout = "1s"
  templates = [
     # filter + template
     #"*.app env.service.resource.measurement",

     # filter + template + extra tag
     #"stats.* .host.measurement* region=us-west,agent=sensu",

     # default template. Ignore the first graphite component "servers"
     "instance.profile.measurement*"
 ]

###
### [collectd]
###
### Controls the listener for collectd data.
###
[collectd]
  enabled = false
  # bind-address = ":25826"
  # database = "collectd"
  # retention-policy = ""
  # typesdb = "/usr/share/collectd/types.db"

  # These next lines control how batching works. You should have this enabled
  # otherwise you could get dropped metrics or poor performance. Batching
  # will buffer points in memory if you have many coming in.

  # batch-size = 1000 # will flush if this many points get buffered
  # batch-timeout = "1s" # will flush at least this often even if we haven't hit buffer limit

###
### [opentsdb]
###
### Controls the listener for OpenTSDB data.
###
[opentsdb]
  enabled = false
  # bind-address = ":4242"
  # database = "opentsdb"
  # retention-policy = ""
  # consistency-level = "one"

###
### [udp]
###
### Controls the listener for InfluxDB line protocol data via UDP.
###

[udp]
  enabled = false
  bind-address = ":4444"
  database = "udpdb"

  # These next lines control how batching works. You should have this enabled
  # otherwise you could get dropped metrics or poor performance. Batching
  # will buffer points in memory if you have many coming in.

  # batch-size = 1000 # will flush if this many points get buffered
  # batch-timeout = "1s" # will flush at least this often even if we haven't hit buffer limit

###
### [monitoring]
### Send anonymous usage statistics to m.influxdb.com?
[monitoring]
  enabled = false
  write-interval = "24h"

###
### [continuous_queries]
###
### Controls how continuous queries are run within InfluxDB.
###

[continuous_queries]
  log-enabled = true
  enabled = true
  recompute-previous-n = 2
  recompute-no-older-than = "10m0s"
  compute-runs-per-interval = 10
  compute-no-more-than = "2m0s"

###
### [hinted-handoff]
###
### Controls the hinted handoff feature, which allows nodes to temporarily
### store queued data when one node of a cluster is down for a short period
### of time.
###

[hinted-handoff]
  enabled = true
  dir = "/data/hh"
  max-size = 1073741824
  max-age = "168h"
  retry-rate-limit = 0
  retry-interval = "1s"

EOF
