#!/bin/sh

if curl -sS https://am.i.mullvad.net/json | jq | grep OpenVPN ; then
  echo "🔒"
fi