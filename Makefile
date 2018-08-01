default: setup run-manager run-agents

run: setup run-manager run-agents

purge: clean remove

setup:
	@echo "Setting file permissions and creating Docker network"
	chmod -X scripts/setup-docker-env.sh agents.sh
	docker network create zabbix-net

run-manager:
	@echo "Running Zabbix manager..."
	sh scripts/setup-manager.sh

run-agents:
	@echo "Running $N agents..."
	sh scripts/agents.sh $N

clean:
	docker ps -a | cut -c-12 | tail -n +2 |xargs docker rm -f

add-agent:
	sh scripts/add-agent.sh $(($(docker ps --format "{{.Names}}" | sort | head -n -1 | tail -1 | tail -c 2)+1))

remove:
	@echo "Cleaning Docker env"
	docker image ls -aq | cut -c-12 | xargs docker image rm -f
	docker network remove zabbix-net

