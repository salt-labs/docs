---
title: Tips and Tricks
date: 2016-04-14T00:00:00+00:00
icon: "fa-solid fa-user"
description: "Salt Tips and Tricks."
type: "docs"
weight: 200
draft: false
---

## Table of Contents

<!-- TOC -->

- [Table of Contents](#table-of-contents)
- [Overview](#overview)
- [Execution Modules and Python](#execution-modules-and-python)
- [Salt CLI](#salt-cli)
  - [Gathering information](#gathering-information)
  - [Salt Utilities](#salt-utilities)
  - [Top file](#top-file)
  - [File Server](#file-server)
  - [Grains](#grains)
  - [Pillars](#pillars)
  - [Network](#network)
  - [Services](#services)
  - [Files](#files)
  - [Command Module](#command-module)
- [Jinja](#jinja)
- [Peer Publishing](#peer-publishing)
- [Subset](#subset)
- [Batchsize](#batchsize)
- [Fail Hard](#fail-hard)
- [Blackout Mode](#blackout-mode)
- [Using Salt in Shell scripts](#using-salt-in-shell-scripts)
- [Salt State file structure migrations](#salt-state-file-structure-migrations)

<!-- /TOC -->

## Overview

An unsorted list of tips and tricks for SaltStack.

## Execution Modules and Python

A salt execution module is just a python function.

e.g. execution module `test.ping` is the ping function inside the test module

This makes it easy to go to the SaltStack repo and find the function you are looking for.

[Salt-Open Repo](https://github.com/saltstack/salt "Salt-Open Repo")

## Salt CLI

### Gathering information

- List all available modules on a minion target

```bash
salt '*' sys.list_modules
```

- List the documentation for a module

```bash
salt '*' sys.doc MODULENAME
```

- List all the arguments available for an execution module

```bash
salt '*' sys.argspec test.ping
```

- List the results in groups based on differential

```bash
salt-run survey.diff '*' pkg.version kernel
salt-call sys.runner_doc survey.diff
```

### Salt Utilities

- Show all the Jobs that are running

```bash
salt '*' saltutil.running
```

- Terminate all running jobs on a minion

```bash
salt '*' saltutil.term_all_jobs
```

- Kill all running jobs on a minion

```bash
salt '*' saltutil.kill_all_jobs
```

- Restart the Minion from the master

```bash
salt '*' cmd.run_bg 'salt-call --local service.restart salt-minion'
```

### Top file

- Run a highstate

```bash
# New
salt '*' state.apply

# Legacy
salt '*' state.highstate
```

- See what the top file matches are for the environment

```bash
salt '*' state.show_top
```

### File Server

- List all the files being served by Salt

```bash
salt '*' cp.list_master
```

- List all the directories being served by Salt

```bash
salt '*' cp.list_master_dirs
```

- List all of the available state files in an environment

```bash
salt '*' cp.list_states
```

- List all of the files cached on the minion

```bash
salt '*' cp.list_minion
```

- Copy a file from the master to a Minion

```bash
salt '*' cp.get_file salt://files/metadata.py "/usr/lib/python2.7/site-packages/salt/grains/metadata.py"
```

### Grains

- List all available grains (key only)

```bash
salt '*' grains.ls
```

- List all available grains

```bash
salt '*' grains.items
```

- List a specific grain

```bash
salt '*' grains.item $NAME
```

- List multiple specific grains

```bash
salt '*' grains.item $NAME1 $NAME2
```

### Pillars

- Refresh Pillar data to the minions

```bash
salt '*' saltutil.pillar_refresh
```

- List all pillars (key only)

```bash
salt '*' pillar.ls
```

- List all pillars (re-generate)

```bash
salt '*' pillar.items
```

- List all pillars (from memory)

```bash
salt '*' pillar.raw
```

- List a specific pillar (from memory)

```bash
salt '*' pillar.item  $PILLAR
```

- List a specific nested pillar

```bash
salt '*' pillar.item $LEVEL1:$LEVEL2:$PILLAR
```

- Render the pillar top.sls

```bash
salt '*' state.show_top
```

### Network

- Verify network access from a minion to another location

```bash
salt '*' network.connect somedomain.com 443
```

- List all the network address for a minion

```bash
salt '*' network.ipaddrs
```

- Show all active TCP connections on a minion

```bash
salt '*' network.active_tcp
```

- Perform a DNS dig on a minion

```bash
salt '*' network.dig somedomain.com
```

- Perform a HTTP/S URL and get a return (curl)

```bash
salt '*' http.query http://localhost/health-check
```

- Wait for a successful HTTP/S query before continuing

```bash
# NOTE: handy to verify that a service is up before returning to service.
salt '*' http.wait_for_successful_query http://localhost/health-check wait_for=60
```

### Services

- Get the status of a service

```bash
salt '*' service.status SERVICE-NAME
```

- Reload a service

```bash
salt '*' service.reload SERVICE-NAME
```

- Restart a service

```bash
salt '*' service.restart SERVICE-NAME
```

- Get all services

```bash
salt '*' service.get_all
```

### Files

- Grep a file (shows content)

```bash
salt '*' file.grep /path/file patter
```

- Sed a file (replaces content)

```bash
salt '*' file.replace /path/file pattern="string" repl="#string" append_if_not_found=True

salt '*' file.replace /etc/salt/minion pattern='cloud_ec2_grains.*$' repl='cloud_ec2_grains: True' append_if_not_found=True
```

- Search a file (Return True/false)

```bash
salt '*' file.search /path/file pattern
```

- Show how much space a file is using

```bash
salt '*' file.diskusage /path/file
```

- Find a file

```bash
salt '*' file.find '/usr' iname=\*.log
```

### Command Module

- Run a command

```bash
salt '*' cmd.run 'echo "This is an example"'
```

- Execute some code

```bash
salt '*' cmd.exec python3 'print("Hello World!")'
```

- Does a minion have an executable name

```bash
salt '*' cmd.has_exec EXECUTABLE-NAME
```

- Which

```bash
salt '*' cmd.which EXECUTABLE-NAME
```

- Run a script on a Minion

```bash
salt '*' cmd.script salt://scripts/my_script.sh 'argument1"
```

## Jinja

- Test a jinja template by filling in variables (On the Master)

```bash
salt-run salt.cmd slsutil.renderer /srv/salt/top.sls
```

- Test a jinja template by filling in variables (On a Minion, from the Master)

```bash
salt '*' slsutil.renderer salt://top.sls 'jinja'
```

- Parse a jinja template and store it on the minion for review

```bash
salt '*' cp.get_template salt://top.sls /tmp/salt.sls template=jinja
```

## Peer Publishing

Salt can allow a Minion to run a command on another Minion

- Example: Allow a Web server to run the haproxy module on a Proxy

```bash
  # Master configuration
  peer:
    'web*':
      'haproxy*':
          - haproxy.*
```

- Example publish command

```bash
salt web1 publish.publish haproxy1 haproxy.disable_server arg="['id', 'backend']"
```

## Subset

- Salt can only show a return from a Subset of the matched minions

```bash
salt --subset=1 -G 'roles:web' cmd.run 'cat /etc/nginx'
```

## Batchsize

- Salt execute commands one host at a time

```bash
salt -b1 -G 'roles:web' service.restart haproxy
```

## Fail Hard

- Stop processing if a state fails (handy for batch operations)

```bash
salt --failhard -b1 -G 'roles:web' service.restart nginx
```

## Blackout Mode

Salt supports minion blackouts. During a blackout, the minion will reject all commands except saltutil.refresh_pillar

- Set the following pillar value

```yaml
minion_blackout: True
```

- You can also whitelist functions that will still be allowed during a blackout.

```yaml
minion_blackout_whitelist:
  - test.ping
  - pillar.get
```

## Using Salt in Shell scripts

- Example: Restart a service on a clustered server and wait for something to be true

```bash
# Get a list of servers
SERVERS=($(salt -G 'roles:app' test.ping --output=text | sort | grep -Po '.*(?=: True)'))

for server in ${SERVERS[@]};
do

    salt $server service.restart DaonIdentityXSRP
    while [ ! salt $server cmd.run "curl 127.0.0.1:XXXX/Health_Check" ];
    then

        sleep 300

    done

done
```

- Example: Recycle Bad Minions

```bash
BADMINIONS=($(salt -G 'roles:proxy' test.ping --output=text | grep -Po '.*(?=: Minion did not return)'))

for minion in ${BADMINIONS[@]};
do

    salt $minion service.restart salt-minion;

done
```

## Salt State file structure migrations

{{< image src="/images/salt-project/salt-master/roles-profile-formula.png" class="h-auto" alt="image" zoomable="true" width="800px" height="600px">}}

```yaml
# Set the ServerRealm

{% set structure = salt['grains.get']}('structure', 'v1') %}

{% if structure == 'v1' %}

    ...

{% endif %}

{% if structure == 'v2' %}

    {% set role = salt['grains.get']('role', 'None') %}
    'G@role:{{ role }}':
      - match: compound
      - 'role.{{ role }}'

{% endif %}
```
