# The add-on fetches its already built hub from this repository's releases, so that it installs in a minute.
FROM ubuntu:22.04
ARG BUILD_ARCH
ARG BUILD_VERSION
RUN apt-get update && apt-get install -y --no-install-recommends bzip2 ca-certificates curl gzip libcurl4 libxml2 tzdata \
	&& mkdir -p /app \
	&& curl -fsSL -o /tmp/hub.tar.gz "https://github.com/giomengu/alphanav-weather-addon/releases/download/v${BUILD_VERSION}/alphanav-weather-${BUILD_ARCH}.tar.gz" \
	&& curl -fsSL -o /tmp/hub.sha256 "https://github.com/giomengu/alphanav-weather-addon/releases/download/v${BUILD_VERSION}/alphanav-weather-${BUILD_ARCH}.tar.gz.sha256" \
	&& (cd /tmp && echo "$(cat hub.sha256)  hub.tar.gz" | sha256sum -c -) \
	&& tar -xzf /tmp/hub.tar.gz -C /app \
	&& rm -rf /tmp/hub.* /var/lib/apt/lists \
	&& apt-get purge -y curl && apt-get autoremove -y
COPY run.sh /app/run.sh
ENV WEATHER_HOME=/data WEATHER_SOURCES=/app/catalog WEATHER_UI=/app/ui WEATHER_MODE=boat WEATHER_HOST=0.0.0.0 WEATHER_PORT=3010
EXPOSE 3010
CMD ["sh", "/app/run.sh"]
