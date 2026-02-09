# Notes

## YML vs YAML

From a technical standpoint there is no relevant difference between the file extensions `.yml` and `.yaml`, as long as a
single one is used within the whole project (consistency).  
However it should be mentioned, that Ansible's own documentation uses `.yaml`.

Within this code example I am using `.yml`, simply because I like it more, and because I am unaware of SENEC's actual
code style and its conventions.

## Sudoers Security

The following command is to be executed on new nodes (see README.md):

```bash
install -m 0440 /dev/stdin /etc/sudoers.d/ansible <<'EOF'
ansible ALL=(ALL) NOPASSWD: ALL
EOF
```

This was required due to the following error messages, which appeared during local testing on Ubuntu 25.10:

```txt
sudo-rs: interactive authentication is required
```

```txt
Task failed: Timeout (12s) waiting for privilege escalation prompt:
```

However `NOPASSWD` seems like a **very bad idea for real production environments**. Needs to be investigated with more
time, or a real production auth tool should be used in the first place.

## Order of IP Addresses

Within the file `tasks/database.yml` I generate the list of IP addresses within the current group, which satisfy the
`deploy_database == true` filter:

```txt
groups[
  group_names | reject('equalto', 'all') | list | first
]
| map('extract', hostvars)
| selectattr('deploy_database', 'equalto', true)
| map(attribute='ip_internal')
| list
| sort
```

It has the following advantages:

- It works.
- The resulting list is sorted, i.e. is always identical.

However, the IP addresses are sorted as a string, such that `10.0.0.19` comes before `10.0.0.2`. While this is mostly a
cosmetic issue, this should be optimized at a later date.

## DNS

The provided DNS record is a great start for WordPress itself, however sub-records like <tool>.wordpress-sk.senecops.com
would have been helpful. Specifically tools like Traefik and MaxScale provide their own web interfaces, which would make
debugging and exploring this project more enjoyable.

I plan on using personal DNS records in order to advertise these additional services - very likely with some sort of
HTTP Basic Auth protection by Traefik itself as well.

## Code Style

The content of the YAML files should be formatted identically, i.e. use single quotes everywhere, no inline text without
quotes, spacing, newlines at the end of files etc.
