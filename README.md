# Ansilbe Terraform Demo

> **Warning**: Please keep in mind that this is just a proof of concept. 

In this repository I have combined the functionality of [Ansible](https://www.ansible.com/) and [Terraform](https://www.terraform.io/). Ansible is being used to generate Terraform plans, Terraform will execute those plans and generate a state file. This state file is being used as the inventory for Ansible. 

In the `resources.yaml` file, you can define providers. Each provider has a type. Currently only `digitalocean`, `hetzner`, `linode` and `proxmox` are supported provider types. Each provider must have an unique name and resources. Resources are products on the specific provider. For example on DigitalOcean, they have `droplets`, which is how they call virtual machines. Every resources has a `count` variable and `groups` variable. The `count` indicates how many of the specific resources you want. For example setting `count` to `4` on a droplet resource on DigitalOcean will create `4` droplets of that specific resource type. The `groups` variable defines to which Ansible groups that resource belongs to. These groups can be used in Ansible playbooks.

There is also a ssh config being generated. This config can be copied to your ssh config folder. Then you can connect to your created virtual machines by using their hostname and without knowing their IP address.

## Demo video
In this video I will show you how to deloy a simple Kubernetes cluster (K3S) on Hetzner, and use the same Ansible playbook to deploy a simple Kubernetes cluster across DigitalOcean, Hetzner, Linode and Proxmox. [Click here to watch the video on YouTube.](https://www.youtube.com/watch?v=tlIYUs_EeiE)

[![Watch the video](https://img.youtube.com/vi/tlIYUs_EeiE/maxresdefault.jpg)](https://www.youtube.com/watch?v=tlIYUs_EeiE)

_Please note: when I showed the ping example the command asked if I expected to delete resources. This has now removed since running just a Ansible playbook won't touch the resources so it cannot delete any resource anyway._

## Commands

To make it easier to run the commands. I have created a menu script. It works as follows:

### Build the Docker container

```bash
./menu build
```

### Debug the Docker container

This will enter to the container using a shell:

```bash
./menu debug
```

### Encrypt Terraform directory

Since the Terraform directory contains sentive files. Please encrypt it when sharing.

```bash
./menu encrypt
```

### Decrypt Terraform directory

```bash
./menu decrypt
```

### Update SSH config

To manually generate the ssh config run:

```bash
./menu update-ssh-config
```

### Update resources on single provider and run playbook

This will run the `site.yaml` playbook. Other arguments are also passthrough `ansible-playbook`.

```bash
./menu update site.yaml
```

### Update resources on all providers and run playbook

This will run the `site.yaml` playbook. Other arguments are also passthrough `ansible-playbook`.

```bash
./menu update-all site.yaml
```

### Update resources on single provider 

```bash
./menu update-resources
```

### Update resources on all providers

```bash
./menu update-resources-all
```

### Run playbook on specific provider

This will run the `site.yaml` playbook. Other arguments are also passthrough `ansible-playbook`.

```bash
./menu playbook site.yaml
```

### Run playbook on all providers

This will run the `site.yaml` playbook. Other arguments are also passthrough `ansible-playbook`.

```bash
./menu playbook-all site.yaml
```