---
title: 'Homelab status check: Terraform, Proxmox, and OpenBao'
description: 'Where the homelab stands — provisioning Proxmox with Terraform, OpenBao for secrets management, and Ansible for configuration.'
pubDate: 2026-06-12
tags: ['homelab', 'terraform', 'openbao']
---

Hey! Here's my first official blog post; a status update on my homelab.
I have the homelab managed through Infrastructure as Code — Terraform provisions 
VMs and LXC containers on Proxmox, OpenBao handles secrets management, 
and I have been experimenting with Ansible as the configuration layer.
The code is in the [homelab-infra repo](https://github.com/dskretta/homelab-infra).

## Starting point

I have a homelab built from an old gaming PC, which has served as its hardware
for a while now. If you've used Proxmox before, you know it can be a lot of clicking through different menus to spin up various services. I've used Terraform with cloud providers before, and heard of peers who integrated it into their Proxmox workflow. I wanted to provision VMs on Proxmox in a more easily documented, and defined way so I decided to integrate Terraform. This also allows me to practice DevOps more by keeping the homelab reproducible and version controlled.

While I was initially setting up the Proxmox API token and other credentials, I was
wondering how to handle these tokens securely. Hardcoding these credentials or 
allowing them to be stored in the .tfstate file felt inherently wrong, so I included
a secrets management layer to integrate in with Terraform before provisioning anything.

## The stack

- **Proxmox** — my hypervisor, running on my homelab hardware.
- **OpenBao** — I realized if I was going to use Terraform to provision
  infrastructure in Proxmox, I should set up proper secrets management and
  learn it. I picked OpenBao instead of Vault because of the BSL license
  change — still navigating which HashiCorp tools I should use vs their open
  sourced forks. This runs on an LXC container I set up within Proxmox.
- **Terraform** — my tool for infrastructure provisioning, with the
  **bpg/proxmox** provider (I found it was more complete than Telmate) and
  the **hashicorp/vault** provider, which is fully compatible with OpenBao.
- **Ansible** — I'm experimenting with Ansible as configuration management
  for infrastructure I provision. Terraform creates the container, Ansible
  configures it. Ansible is agentless so it doesn't install anything on the targets.

The network it lives in: my workstation sits on the home network and is
allowlisted through pfSense into the lab LAN where Proxmox runs.

<img class="theme-dark-only" src="/images/homelab/topology-dark.svg" alt="Network topology: workstation allowlisted through pfSense into the lab LAN, where Proxmox hosts the OpenBao LXC and application VMs" />
<img class="theme-light-only" src="/images/homelab/topology-light.svg" alt="Network topology: workstation allowlisted through pfSense into the lab LAN, where Proxmox hosts the OpenBao LXC and application VMs" />

## Secrets management

I deployed OpenBao as an LXC container on Proxmox and stored the Proxmox API
token in a KV v2 secrets engine. Storing the token there raised my next
question though, how could I have Terraform authenticate to OpenBao without me
exporting another credential (the exact scenario I was trying to avoid).

I read through some of HashiCorp's
[articles](https://developer.hashicorp.com/vault/tutorials/auth-methods/approle-best-practices)
and [documentation](https://developer.hashicorp.com/vault/docs/auth/approle)
on AppRole authentication and decided to implement it, rather than
authenticating Terraform to OpenBao with a static token. The flow ended up in three phases:

<img class="theme-dark-only" src="/images/homelab/authflow-dark.svg" alt="Sequence diagram: wrapped Secret ID handoff, AppRole login, then ephemeral credential fetch and provisioning" />
<img class="theme-light-only" src="/images/homelab/authflow-light.svg" alt="Sequence diagram: wrapped Secret ID handoff, AppRole login, then ephemeral credential fetch and provisioning" />

The remaining problem was how to handle the AppRole Secret ID itself. The
article I read suggested using OpenBao's
[response wrapping](https://openbao.org/docs/concepts/response-wrapping/). A bootstrap token
(scoped only to generate Secret IDs) requests a wrapped, single-use token at
runtime with a 120 second TTL. That token is unwrapped in memory by
`pipeline.sh` and passed to Terraform via environment variables.

The AppRole is bound to a policy that only permits reading
`proxmox/data/terraform`. Nothing else in OpenBao is accessible to Terraform
so, even if the credentials were compromised, the "blast radius" is limited
to that single secret path.

One thing I didn't initially realize: the Terraform Vault provider deprecated
`vault_kv_secret_v2` as a data source in favor of an
[ephemeral resource](https://developer.hashicorp.com/terraform/language/resources/ephemeral)
(Terraform >= 1.10). I swapped that to keep credentials from ever being written to state.

All infrastructure-specific values (Bao address, Proxmox endpoint, bootstrap
token, Role ID) live in a gitignored `.env` file and are injected via
`TF_VAR_*` environment variables. Nothing sensitive is committed to any
repository.


## Roadmap

- **Consul for service discovery** — I want to deploy Consul so that
  internal services like OpenBao and Proxmox register themselves by name
  rather than IP. This means Terraform resolves services dynamically, and
  infrastructure changes don't cascade into broken configs across multiple
  tools. Consul also integrates natively with OpenBao, meaning I can learn
  how to use it as a storage backend for OpenBao too.
- **CI/CD** — I tried Jenkins first, but it felt as though it created more
  frustrations within my workflow than it added. I'm looking into GitHub
  Actions or ArgoCD instead, since I eventually want to learn Kubernetes.
- **Cloud integration** — I'd like to deploy the Game of Active Directory
  (GOAD) to a cloud environment as a cloud infrastructure project,
  provisioned via Terraform to extend this into a hybrid setup.
- **Kubernetes** — the end goal is to build a hybrid environment and
  workflows that I can recreate in Kubernetes. If I like it a lot, I'll
  migrate this workload from Proxmox to Kubernetes, with ArgoCD for GitOps
  style deployments.

The [repo](https://github.com/dskretta/homelab-infra) has the full setup,
including what was required to stand everything up.
