docker run \
   -d \
   --name zabbix-db \
   -v /etc/localtime:/etc/localtime:ro \
   --network zabbix-net \
   --env="MARIADB_USER=zabbix" \
   --env="MARIADB_PASS=my_password" \
   monitoringartist/zabbix-db-mariadb

docker run \
   -d \
   --name zabbix-ext-all-templates \
   --network zabbix-net \
   monitoringartist/zabbix-ext-all-templates:latest


docker run \
   -d \
   --name zabbix \
   -p 80:80 \
   -p 10051:10051 \
   -v /etc/localtime:/etc/localtime:ro \
   --network zabbix-net \
   --volumes-from zabbix-ext-all-templates \
   --link zabbix-db:zabbix.db \
   --env="ZS_DBHost=zabbix.db" \
   --env="ZS_DBUser=zabbix" \
   --env="ZS_DBPassword=my_password" \
   --env="XXL_zapix=true" \
   --env="XXL_grapher=true" \
   --env="XXL_apiuser=Admin" \
   --env="XXL_apipass=zabbix" \
   monitoringartist/dockbix-xxl:latest
