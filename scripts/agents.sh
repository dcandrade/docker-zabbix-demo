for i in `seq 1 $1`;
do
	docker run \
	  --name=zabbix-agente-$i \
	  --network zabbix-net \
	  --privileged \
	  -v /:/rootfs \
	  -v /var/run:/var/run \
	  --restart unless-stopped \
	  -e "ZA_Server=172.17.0.3" \
	  -e "ZA_ServerActive=172.17.0.3" \
	  --volumes-from zabbix-ext-all-templates \
	  -d monitoringartist/dockbix-agent-xxl-limited:latest
done 
