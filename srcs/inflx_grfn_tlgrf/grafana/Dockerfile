FROM alpine:3.12

RUN	apk update
RUN	apk add grafana --repository http://dl-cdn.alpinelinux.org/alpine/edge/community/ --allow-untrusted

COPY datasources.yaml /usr/share/grafana/conf/provisioning/datasources/influxdb.yaml
COPY dashboards.yaml /usr/share/grafana/conf/provisioning/dashboards/dashboards.yaml
COPY grafana.db /usr/share/grafana/data/grafana.db

EXPOSE 3000

CMD /usr/sbin/grafana-server --homepath=/usr/share/grafana