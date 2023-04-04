---
title: Hints
date: 2016-04-14T00:00:00+00:00
icon: "fa-solid fa-user"
description: "Salt Cloud hints."
type: "docs"
weight: 402
draft: true
---

- Download the latest version of the salt-bootstrap script

**NOTE:** Run this from cron periodically

```bash
salt-cloud --update-bootstrap
```

- Tell Salt-Cloud to crash hard on error

```bash
salt-cloud --hard-crash
```

- Deploy 2 nodes from a profile in parallel

```bash
salt-cloud --parallel --profile=$PROFILE_NAME $NODE_1 $NODE_2
```

- Destroy a single instance

```bash
salt-cloud --destroy $NODE_NAME
```

- Destroy all the instances NOT defined in the map file

**NOTE:** BE CAREFUL!!!

```bash
salt-cloud --destroy --map=
```

- Gather basic information about instances

```bash
salt-cloud --query
```

- Gather full information about instances

```bash
salt-cloud --full-query
```

- Execute a selective query (once configured in query.conf)

```bash
salt-cloud --select-query
```

- Apply an action to an instance

**NOTE:** Supported actions are:

- show_instance
- stop
- start

```bash
salt-cloud -a $ACTION $NODE
```
