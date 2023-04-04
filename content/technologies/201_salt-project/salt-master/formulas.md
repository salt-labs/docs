---
title: Formulas
date: 2016-04-14T00:00:00+00:00
icon: "fa-solid fa-user"
description: "Salt Formulas notes."
type: "docs"
weight: 400
draft: true
---

## Overview

Salt Formulas a pre-written states.

The official documentation is available [here](ttps://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html)

## How to configure

Salt Formulas are configured as individual Git repositories using GitFS or can be configured manually.

The naming convention is:

```yaml
$NAME-formula
```

- Using GitFS

```yaml
gitfs_remotes:
  - https://gitlab.com/mahdtech/saltstack/monit-formula
  - https://gitlab.com/mahdtech/saltstack/haproxy-formula
  - https://github.com/saltstack-formulas/memcached-formula
```

- Manually

```yaml
file_roots:
  base:
    - /srv/salt
    - /src/formulas
```

## Usage

Using HAProxy as an example

```yaml
include:
  - HAProxy

Configure HAProxy:
  pkg.installed:
    - name: haproxy
    - require:
        - pkg: HAProxy
```

## Examples

There are a number of places to find good examples of Salt Formulas including:

### Official Formulas

- [EPEL](https://github.com/saltstack-formulas/epel-formula)
- [Dans-Guardian](https://github.com/saltstack-formulas/dansguardian-formula)
- [SSH](https://github.com/saltstack-formulas/ssh-formula)
- [DocuWiki](https://github.com/saltstack-formulas/dokuwiki-formula)
- [Packer-1](https://github.com/saltstack-formulas/packer-formula)
- [PIP](https://github.com/saltstack-formulas/pip-formula)
- [LetsEncrypt](https://github.com/saltstack-formulas/letsencrypt-formula)
- [SmokePing](https://github.com/saltstack-formulas/smokeping-formula)
- [CockroachDB](https://github.com/saltstack-formulas/cockroachdb-formula)
- [AWS](https://github.com/saltstack-formulas/aws-formula)
- [RSyslog](https://github.com/saltstack-formulas/rsyslog-formula)
- [Golang](https://github.com/saltstack-formulas/golang-formula)
- [CollectD](https://github.com/saltstack-formulas/collectd-formula)
- [SQLPlus](https://github.com/saltstack-formulas/sqlplus-formula)
- [Monit](https://github.com/saltstack-formulas/monit-formula)
- [HAProxy](https://github.com/saltstack-formulas/haproxy-formula)

### 3rd Party Formulas

- [Packer](https://github.com/salt-formulas/salt-formula-packer)
- [Linux](https://github.com/salt-formulas/salt-formula-linux)
- [OpenVPN](https://github.com/salt-formulas/salt-formula-openvpn)
- [Docker](https://github.com/salt-formulas/salt-formula-docker)
- [Docker](https://github.com/salt-formulas/docker-salt)
- [Scripts](https://github.com/salt-formulas/salt-formulas-scripts)
- [DevOpsPortal](https://github.com/salt-formulas/salt-formula-devops-portal)
- [Grafana](https://github.com/salt-formulas/salt-formula-grafana)
- [Kibana](https://github.com/salt-formulas/salt-formula-kibana)
- [Git](https://github.com/salt-formulas/salt-formula-git)
- [Jupyter](https://github.com/salt-formulas/salt-formula-jupyter)
- [Jenkins](https://github.com/salt-formulas/salt-formula-jenkins)
- [Aptly](https://github.com/salt-formulas/salt-formula-aptly)
- [ElasticSearch](https://github.com/salt-formulas/salt-formula-elasticsearch)
- [Kubernetes](https://github.com/salt-formulas/salt-formula-kubernetes)
- [NTP](https://github.com/salt-formulas/salt-formula-ntp)
- [Prometheus](https://github.com/salt-formulas/salt-formula-prometheus)
- [TinyProxy](https://github.com/salt-formulas/salt-formula-tinyproxy)
- [SyncThing](https://github.com/salt-formulas/salt-formula-syncthing)
- [InfluxDB](https://github.com/salt-formulas/salt-formula-influxdb)
- [Telegraf](https://github.com/salt-formulas/salt-formula-telegraf)
- [RSync](https://github.com/salt-formulas/salt-formula-rsync)
- [GitLab](https://github.com/salt-formulas/salt-formula-gitlab)
- [LogRotate](https://github.com/salt-formulas/salt-formula-logrotate)
- [FreeIPA](https://github.com/salt-formulas/salt-formula-freeipa)
- [Chrony](https://github.com/salt-formulas/salt-formula-chrony)
- [Network](https://github.com/salt-formulas/salt-formula-network)
- [Mayan-OCR](https://github.com/salt-formulas/salt-formula-mayan)
- [GateOne](https://github.com/salt-formulas/salt-formula-gateone)
- [TFTPD](https://github.com/salt-formulas/salt-formula-tftpd-hpa)
- [FFMpeg](https://github.com/salt-formulas/salt-formula-ffmpeg)
- [Vault-1](https://github.com/saltstack-formulas/salt-formula)
- [Vault-2](https://github.com/mitodl/vault-formula)

## Related Links

- [Bechtoldk-Salt-Formulas](https://github.com/bechtoldt/formula-docs "Bechtoldk Salt Formulas Best Practices")
