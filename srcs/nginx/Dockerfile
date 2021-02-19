FROM  alpine:latest

RUN apk update
RUN apk upgrade
RUN apk add nginx 


#nginx
RUN mkdir /run/nginx
COPY srcs/nginx.conf /etc/nginx/sites-available/default

COPY ./srcs/start.sh ./start.sh
RUN chmod +x /start.sh
CMD ./start.sh

EXPOSE 80 443
