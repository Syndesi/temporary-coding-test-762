# SENEC coding example

## Getting started

Requirements:

- [Docker](https://docs.docker.com/engine/install/)
- [Docker Compose](https://docs.docker.com/compose/install/)

**IMPORTANT**: The Ansible container within `docker-compose.yml` requires some sort of SSH keys being mounted as a
readonly volume to location `/ssh-volume`. The user's default SSH key folder at `$HOME/.ssh` is explicitly NOT enabled
by default. **Enable or replace this volume mount with care.**

```bash
docker compose build
docker compose up -d
```

## Executing Ansible

All following commands in this section require to be run inside the Ansible container. In order to exec into the
container, execute the following command:

```bash
# host
docker compose exec -it ansible bash
```

### Install Ansible dependencies

```bash
# container
ansible-galaxy collection install -r requirements.yml -p ./galaxy/collections
ansible-galaxy role install -r requirements.yml -p ./galaxy/roles
```

### List Inventory

```bash
# container
ansible-inventory --list
```

### Execute Ansible

```bash
# container
ansible-playbook playbook.yml -l production
ansible-playbook playbook.yml -l local               # todo remove
```

## Adding New Nodes

Execute the following commands on the new host:

```bash
# root user, host
apt update
apt upgrade
# note: the following command can likely be improved, made more secure etc
install -m 0440 /dev/stdin /etc/sudoers.d/ansible <<'EOF'
ansible ALL=(ALL) NOPASSWD: ALL
EOF
```
