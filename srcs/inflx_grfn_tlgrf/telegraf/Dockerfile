FROM    alpine:3.12
RUN     apk update && apk add openrc
ADD     https://dl.influxdata.com/telegraf/releases/telegraf-1.17.3_linux_amd64.tar.gz /etc/
RUN     tar -xzf /etc/telegraf-1.17.3_linux_amd64.tar.gz -C /etc/ ; \
        rm -rf /etc/telegraf-1.17.3_linux_amd64.tar.gz
RUN     mv /etc/telegraf-1.17.3 /telegraf
RUN     cp -r telegraf/* ./
RUN     rm -rf /telegraf
RUN     wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.28-r0/glibc-2.28-r0.apk
RUN     apk add glibc-2.28-r0.apk --allow-untrusted
RUN     telegraf -sample-config telegraf.conf --input-filter cpu:mem --output-filter influxdb > telegraf.conf
COPY    telegraf.conf /etc/telegraf/
CMD     telegraf