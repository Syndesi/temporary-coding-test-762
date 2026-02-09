# Considered Tools

## Terraform

One of the two technologies listed as basic requirements for colleagues:

> Document the module in a way that someone who is passingly familiar with **terraform** or ansible is able to understand and use it.

Terraform seems to be mostly an orchestration tool for infrastructure as code, which already is fully provided, so it can only be used in secondary roles, e.g. as a task orchestration tool.

## Ansible

One of the two technologies listed as basic requirements for colleagues:

> Document the module in a way that someone who is passingly familiar with terraform or **ansible** is able to understand and use it.

Ansible seems to be a better fit for the required task, as it can interact with the existing machines in an interactive way.

## Packer

Recommended in [Hashicorp’s documentation](https://developer.hashicorp.com/terraform/language/provisioners#build-configuration-into-machine-images) in regard to Terraform’s provisioning capabilities:

> You can use [HashiCorp Packer](https://developer.hashicorp.com/packer) or similar systems to build system configuration steps into custom images.

In this task unusable, as the relevant machines are already created and can not be replaced.

Another more exotic Packer use-case would be to create VM images with required dependencies (Docker, WordPress, MariaDB etc.), and to deploy those to the existing machines in the form of VMs.
However, this variant introduces additional complexities without any clear advantage over other variants.

## Bash-Scripts

Bash scripts are likely to be part of the final solution. However, they will not be the sole technology used, as both Terraform and Ansible are specifically mentioned.

**Notes**:

- Bash scripts will behave differently in other shell environments (sh, **bash**, zsh, …).
- Shell scripts should include the following header to improve early termination during runtime errors:
  ```bash
  #!/bin/bash
  set -euxo pipefail      # see https://gist.github.com/mohanpedala/1e2ff5661761d3abd0385e8223e16425 for details
  ```

# Tool Overview

| Tool | Primary tool? | Secondary tool? |
|----|----|----|
| Terraform | 🟢 | 🔴 |
| Ansible | 🟢 | 🟡 |
| Packer | 🔴 | 🔴 |
| Bash-Scripts | 🟡 | 🟢 |

# Tool Decision

Considering all requirements, Ansible is very likely the best fit for the specified task.

If the specification had included some credentials for creating the infrastructure in the first place, then Terraform would have been a necessary part of the solution, likely in combination with Ansible.
