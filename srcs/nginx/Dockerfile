FROM  alpine:3.12

RUN apk update && apk upgrade
RUN apk add nginx openssl openssh-server supervisor
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -subj '/CN=localhost' -keyout /etc/ssl/localhost.key -out /etc/ssl/localhost.crt
RUN mkdir /run/nginx;

  
COPY nginx.conf /etc/nginx/nginx.conf


RUN adduser -D -g 'www' www
RUN mkdir /www;
RUN chown -R www:www /var/lib/nginx
RUN chown -R www:www /www

RUN echo -e "<!DOCTYPE html>                 \n\
<html lang=\"en\">                           \n\
<head>                                       \n\
    <meta charset=\"utf-8\" />               \n\
    <title>HTML5</title>                     \n\
</head>                                      \n\
<body>                                       \n\
    hellow!                                  \n\
</body>                                      \n\
</html>" > /www/index.html;

#supervisor
RUN echo -e "\
[supervisord]                                \n\
nodaemon=true                                \n\
[program:nginx]                              \n\
command=sh -c \"nginx -g 'daemon off;' &&\
kill -s SIGSTREM \$(cat supervisord.pid)\"   \n\
[program:sshd]                               \n\
command=sh -c \"/usr/sbin/sshd -D &&\
kill -s SIGSTREM \$(cat supervisord.pid)\"   \n\
stdout_logfile=/home/nginx.log               \n\
stderr_logfile=/home/nginxerr.log            \n\
" > /etc/supervisord.conf

# create SSH key ssh
RUN sed -i s/#PermitRootLogin.*/PermitRootLogin\ yes/ /etc/ssh/sshd_config \
  && echo "root:root" | chpasswd \
  && /usr/bin/ssh-keygen -A \
  && ssh-keygen -t rsa -b 4096 -f  /etc/ssh/ssh_host_key
  
EXPOSE 80 443 22
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]