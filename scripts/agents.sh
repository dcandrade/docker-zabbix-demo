for i in `seq 1 $1`;
do
	docker run \
	  --name=zabbix-agente-$i \
	  --network zabbix-net \
	  --privileged \
	  -v /:/rootfs \
	  -v /var/run:/var/run \
	  --restart unless-stopped \
	  -e "ZA_Server=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' zabbix)" \
	  -e "ZA_ServerActive=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' zabbix)" \
	  --volumes-from zabbix-ext-all-templates \
	  -d monitoringartist/dockbix-agent-xxl-limited:latest
done 
