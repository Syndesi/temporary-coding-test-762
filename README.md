# SENEC coding example

## Limitations

- Load balancer is not yet implemented.  
  While comparatively easy to implement, it is not as important as replication, therefore it was one of the last tasks
  started.
- File synchronization of WordPress volume is yet to be decided. While some S3-compatible WordPress plugins exists, they
  would shift the issue to another "magical" S3 node outside of this sketch.
- Notebook has not yet been executed against the production infrastructure - as it is still being under development.

## Getting started

Requirements:

- [Docker](https://docs.docker.com/engine/install/)
- [Docker Compose](https://docs.docker.com/compose/install/)

**IMPORTANT**: The Ansible container within `docker-compose.yml` requires some sort of SSH keys being mounted as a
readonly volume to location `/ssh-volume`. The user's default SSH key folder at `$HOME/.ssh` is explicitly NOT enabled
by default. **Enable or replace this volume mount with care.**

**IMPORTANT**: todo: describe how production secrets must be replaced

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

## MaxScale

MaxScale is an optional companion software for MariaDB deployments, which handles advanced features like load balancing
and automatic fail over. See [official documentation](https://mariadb.com/docs/maxscale/) for more details.

**Important**: MaxScale does support [cooperative monitoring](https://mariadb.com/resources/blog/mariadb-maxscale-2-5-cooperative-monitoring/)
(activated), which can be seen as its "cluster" feature. It does work, and has basic "cluster" capabilities, but it
should be seen more as a group of individual MaxScale instances, which will not block themselves.  
One of the implications is, that MaxScale's web interface is unaware of its peers.  
As the underlying MariaDB cluster is the same for all MaxScale instances, the displayed information is also identical.

### Login

MaxScale's web interface can be reached on `ip:8989`, e.g. http://10.0.0.3:8989/ (web1, internal IP).

The default credentials are:

```txt
username:    admin
password:    mariadb
```

**Note**: The default credentials are not easily replaceable. For production deployments this should be resolved.

![](./notes/assets/maxscale_login.png)

### Dashboard

![](./notes/assets/maxscale_dashboard.png)

### Visualization

![](./notes/assets/maxscale_visualization.png)
