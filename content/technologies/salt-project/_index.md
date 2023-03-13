---
title: Salt Project
date: 2017-11-11T00:00:00+00:00
icon: "fa-solid fa-user"
description: "Salt Project notes and resources."
type: "docs"
weight: 100
draft: true
---

## Table of Contents

<!-- TOC -->

- [Table of Contents](#table-of-contents)
- [Overview](#overview)
- [Terminology](#terminology)
  - [Salt Master](#salt-master)
  - [Salt Minion](#salt-minion)
  - [Salt Execution Modules](#salt-execution-modules)
  - [Salt Runners](#salt-runners)
  - [Salt States](#salt-states)
  - [Salt Reactor](#salt-reactor)
  - [Salt Thorium Complex Reactor](#salt-thorium-complex-reactor)
  - [Salt Orchestrator](#salt-orchestrator)
  - [Salt SSH](#salt-ssh)
  - [Salt Masterless](#salt-masterless)
  - [Salt Mine](#salt-mine)
  - [Salt Cloud](#salt-cloud)
  - [Salt Pillar](#salt-pillar)

<!-- /TOC -->

## Overview

This section contains notes and resources related to SaltStack.

## Terminology

There are a few different tools and terminologies within SaltStack ecosystem as show below.

### Salt Master

The Salt Master is the central manager for the Salt Minions and by default uses 0mq but can also use a custom UDP based protocol RAET.

### Salt Minion

The Salt Minion is an agent installed on the hosts that connects to the Salt Master waiting for instructions.

### Salt Execution Modules

Salt Execution Modules are pre-defined commands to run on remote hosts.

One example is `test.ping` which returns `True` if the Salt Minion is responding.

Example usage

```bash
salt '*' test.ping
```

### Salt Runners

Salt Runners, invoked from `salt-run` are similar to Salt Execution modules except they run on the Salt Master instead of the Salt Minion.

### Salt States

Salt States describe the desired state of a specific part of a targeted system. For example the following state ensure that a file is present on the system

```bash
Ensure hosts file present:
  file.present:
    - name: /etc/hosts
    - source: files/hosts
```

### Salt Reactor

Enables the ability to fire off events based on data processed on the 0mq bus. This might include, restarting a server of failure or triggering a re-deployment.

This reactor is based on the premise of "listening" for events.

### Salt Thorium Complex Reactor

An Experimental engine added in `2016.3.0`, The Throrium Reactor is designed to be able to react based on aggregated data or multiple events.

Thorium uses an in-memory register to keep track of events.

### Salt Orchestrator

Executing States is done in parallel on all Minions. The Orchestrator is for when you want to run states sequentially, ie drain stop a server behind a load balancer, upgrade the server, and add the server back to the load balance pool.

### Salt SSH

The ability to apply states and modules over SSH instead of the Master/Minion deployment. This is much slower than the 0mq version. This can be compared with the Ansible method.

### Salt Masterless

A Minion which does not require a master to operate. The State tree is processed locally by the `salt-call` utility.

### Salt Mine

A facility to collect data from Minions and store it on the Master. This data is then available for use by other Minions.

### Salt Cloud

Salt-Cloud is for provisioning systems on Cloud Hosts and Hypervisors

### Salt Pillar

A key-value DB stored encrypted on each Minion, and only available to that Minion. This is where passwords and configuration for the Minion is stored.
