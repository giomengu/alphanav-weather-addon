#!/bin/sh
# The add-on's settings, when Home Assistant gave any. Its ingress comes from one address, which nothing
# else on its network can use, and has already signed the person in.
set -eu
option() {
	sed -n "s/.*\"$1\"[[:space:]]*:[[:space:]]*\([0-9][0-9]*\).*/\1/p" /data/options.json 2>/dev/null | head -n 1
}
minutes="$(option check_minutes)"
days="$(option keep_days)"
export WEATHER_TICK_SECONDS="$(( ${minutes:-15} * 60 ))"
export WEATHER_KEEP_HOURS="$(( ${days:-7} * 24 ))"
if [ -n "${SUPERVISOR_TOKEN:-}" ]; then
	export WEATHER_INGRESS_PEER=172.30.32.2
fi
# Both IPv4 and IPv6 where the machine has it: homeassistant.local answers on IPv6 first, and Docker passes
# that on to an address nothing would be listening on.
if [ -s /proc/net/if_inet6 ]; then
	export WEATHER_HOST=::
fi
exec /app/WeatherServer
