FROM <ServerName>.azurecr.io/ubuntu

ENV DBHost mssql-server
ENV DBUser wpadmin
ENV DBPass <Password>
ADD ./Deploy-Nami.sh /tmp
RUN /bin/sh /tmp/Deploy-Nami.sh
CMD service php7.0-fpm start && nginx -g "daemon off;"

EXPOSE 80

