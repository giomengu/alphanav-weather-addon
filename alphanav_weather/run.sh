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
# Both IPv4 and IPv6 where the machine allows it: homeassistant.local answers on IPv6 first, and Docker passes
# that on to an address nothing would be listening on. If it cannot, IPv4 still serves.
if [ "${WEATHER_HOST:-}" != "127.0.0.1" ] && [ "$(cat /proc/sys/net/ipv6/conf/all/disable_ipv6 2>/dev/null)" = "0" ]; then
	WEATHER_HOST=:: /app/WeatherServer || echo "Could not listen on IPv6: IPv4 only." >&2
fi
exec /app/WeatherServer
