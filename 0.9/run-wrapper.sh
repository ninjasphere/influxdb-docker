#!/bin/bash

CONFIG_TEMPLATE="/config/config.toml.sh"
CONFIG_FILE="/config/config.toml"

(. ${CONFIG_TEMPLATE}) > ${CONFIG_FILE}
$(dirname "$0")/run.sh

exec /opt/influxdb/influxd -config=${CONFIG_FILE}
