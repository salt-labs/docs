---
title: Environments
date: 2016-04-14T00:00:00+00:00
icon: "fa-solid fa-user"
description: "Salt environment notes."
type: "docs"
weight: 400
draft: false
---

## Overview

- Example configuration (master.conf)

```yaml
# For each environment:
#   * apply the top.sls
#   * if top.sls doesn't exist, apply the base top.sls
top_file_merging_strategy: same

# Each Environment will:
#   * Check the associated environment directory first
#   * If a file is not found, DO NOT default to the base
file_roots:
  # Base Environment
  base:
    - /srv/salt/base

  # Development Environment
  dev:
    - /srv/salt/dev

  # Staging Environment
  qa:
    - /srv/salt/qa

  # Production Environment
  prod:
    - /srv/salt/prod
```

- Example configuration (top.sls)

```yaml
##############################################################
# NOTES:
#
# The states that will apply to a minion can be shown by:
# salt "minion" state.show_top
#
# To apply a specific environment directly to a minion:
# salt "minion" state.apply saltenv=prod
#
###############################################################

# Base Environment
base:
  "*":
    - ALL

# Development Environment
dev:
  "Role:HAProxy":
    - match: pillar
    - HAProxy
  "Role:CockroachDB":
    - CockroachDB

# Staging Environment
qa:
  "Role:HAProxy":
    - match: pillar
    - HAProxy
  "Role:CockroachDB":
    - CockroachDB

# Production Environment
prod:
  "Role:HAProxy":
    - match: pillar
    - HAProxy
  "Role:CockroachDB":
    - CockroachDB
```
