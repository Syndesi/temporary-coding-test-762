# SENEC coding example

## Limitations

- Replication itself does not yet work.  
  Alternatives include:
  - Starting nodes from a "scratch" backup, which is included in the git-repository, however embedded credentials need
    to be handled separately / other aspects become more convoluted.
  - Coordinating replication across nodes with SQL queries - requires orchestration outside of Ansible.
- Load balancer is not yet implemented.  
  While comparatively easy to implement, it is not as important as replication, therefore it was one of the last tasks
  started.
- File synchronization of WordPress volume is yet to be decided. While some S3-compatible WordPress plugins exists, they
  would shift the issue to another "magical" S3 node outside of this sketch.
- Implementation of secure passwords - as this notebook is still under local development (virtual machines), flexibility
  is currently more important than absolute security. Templates to replace insecure passwords already exist, and some
  comments containing "todo" are also present.
- Notebook has not yet been executed against the production infrastructure - as it is still being under development.

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
