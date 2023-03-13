---
title: Salt Check
date: 2016-04-14T00:00:00+00:00
icon: "fa-solid fa-user"
description: "Salt Check notes and resources."
type: "docs"
weight: 204
draft: true
---

## Overview

salt-check is a module to run tests on your States and confirm they applied successfully.

## Layout

```bash
  STATENAME/
    /init.sls
      /saltcheck-tests/
        /STATENAME.tst
```

## CLI

- Run a single test from the Master

```bash
salt '*' saltcheck.run_state_tests MyState
```

- Run all tests from the Master

```bash
salt '*' saltcheck.run_highstate_tests
```

- Run a single test from a Minion

```bash
salt-call saltcheck.run_state_tests MyState
```

- Run all tests from the Minion

```bash
salt-call saltcheck.run_highstate_tests
```

## Tests

- An example for testing users

```yaml
{% for user in pillar.get('users', {}) %}

Test {{ user.account }}:
  module_and_function: user.list_users
  args:
  kwargs:
  pillar-data:
  assertion:  assertIn
  expect-return: {{ user.account }}

{% endfor %}
```
