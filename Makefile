default: setup run-manager run-agents

run: setup run-manager run-agents 

purge: clean remove

setup:
	@echo "Setting file permissions and creating Docker network"
	chmod -X ./scripts/setup-manager.sh ./scripts/agents.sh
	docker network create zabbix-net

run-manager:
	@echo "Running Zabbix manager..."
	sh ./scripts/setup-manager.sh

run-agents:
	@echo "Running 3 agents..."
	sh ./scripts/agents.sh 3

clean:
	docker ps -a | cut -c-12 | tail -n +2 |xargs docker rm -f
	docker network remove zabbix-net

add-agent:
	sh ./scripts/add-agent.sh $(($(docker ps --format "{{.Names}}" | sort | head -n -1 | tail -1 | tail -c 2)+1))

remove:
	@echo "Cleaning Docker env"
	docker image ls -aq | cut -c-12 | xargs docker image rm -f

