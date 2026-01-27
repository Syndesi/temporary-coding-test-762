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

