FROM  alpine:latest

RUN apk update
RUN apk upgrade
RUN apk add nginx 


#nginx
RUN mkdir /run/nginx
COPY srcs/nginx.conf /etc/nginx/sites-available/default

COPY ./srcs/start.sh /tmp/start.sh
RUN chmod 777 /tmp
RUN chmod 777 /tmp/start.sh

EXPOSE 80 443
CMD ["/tmp/start.sh"]