# Zabbix demonstration on Docker containers

### Usage:
0. Install docker (https://docs.docker.com/install/)
1. Clone this repository `git clone git@github.com:dcandrade/docker-zabbix-demo.git`
2. Run `make` to build the Docker environment
3. Done! Zabbix is available at localhost (w/ login: Admin, pass:zabbix). Activate Zabbix automatic host discovery on tab *Configuration*

Extra: Run `make add-agent` to add one more agent

### Removing
Run `make purge` to remove all Docker containers and images
