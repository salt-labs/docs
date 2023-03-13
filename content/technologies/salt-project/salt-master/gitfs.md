---
title: GitFS
date: 2016-04-14T00:00:00+00:00
icon: "fa-solid fa-user"
description: "Salt Master gitfs configuration notes."
type: "docs"
weight: 400
draft: true
---

## Overview

The Salt Master can be configured to use GitFS as a backend for the Salt fileserver. This allows for the use of Git repositories as a source for Salt states and pillars.

- Example configuration

```yaml
# GitFS root location
gitfs_root: salt

# Global GitFS defaults for environments
gitfs_saltenv:

  # Base Environment
  - base:
    - ref: master                                   # The Git Branch

  # Production Environment
  - prod:
    - ref: prod                                     # The Git Branch
    - mountpoint: salt://environments/prod          # Location of the files

  # QA Environment
  - qa:
    - ref: qa                                       # The Git Branch
    - mountpoint: salt://environments/qa            # Location of the files

  # Development Environment
  - dev:
    - ref: develop                                  # The Git Branch
    - mountpoint: salt://environments/dev           # Location of the files

# Repository specific settings
gitfs_remotes:

    # The base environment (top.sls)
    - https://gitlab.com/SaltWorks/Salt:
        - saltenv:
            - base

    # HAProxy Formula
    - https://gitlab.com/SaltWorks/Salt-Formulas/HAProxy-Formula:
        - saltenv:
            - dev:
                - mountpoint: salt://environments/dev/formulas/
```
