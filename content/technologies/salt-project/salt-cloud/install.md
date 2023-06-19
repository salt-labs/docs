---
title: Install
date: 2016-04-14T00:00:00+00:00
icon: "fa-solid fa-user"
description: "Salt Cloud installation notes."
type: "docs"
weight: 401
draft: false
---

## Provider specific

### Azure ARM

#### Debian

Install the dependencies

```bash
sudo apt-get install build-essential libssl-dev libffi-dev python-dev
```

Install the Azure CLI

```bash
pip install azure-cli
```

#### Red Hat

Install the dependencies

```bash
sudo yum install gcc libffi-devel python-devel openssl-devel
```

Install the Azure CLI

```bash
pip install azure-cli
```

### AWS EC2

The dependencies are:

- Boto3
- requests

### Google Compute Engine

The dependencies are:

- LibCloud

### Joyent Cloud

The dependencies are:

- requests

### VMware

The dependencies are:

- pyVmomi
