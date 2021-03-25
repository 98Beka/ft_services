FROM alpine:3.12
RUN apk update && apk upgrade && apk add wget
RUN apk --update --no-cache add influxdb --repository\
 http://dl-2.alpinelinux.org/alpine/edge/community/

COPY	./influxdb.conf /etc/influxdb.conf
RUN echo -e "\
#!/bin/sh                                   \n\
/usr/sbin/influxd & sleep 3                 \n\
influx -execute \"CREATE DATABASE telegraf\"\n\
influx -execute \"CREATE USER admin WITH PASSWORD 'admin'\"\n\
# influx -execute \"GRANT ALL ON telegraf TO admin\"\n\
tail -f /dev/null                           \n\
" > /run.sh                               
RUN chmod +x run.sh
EXPOSE 8086
CMD /run.sh