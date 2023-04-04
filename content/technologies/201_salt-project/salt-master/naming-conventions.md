---
title: Naming Conventions
date: 2016-04-14T00:00:00+00:00
icon: "fa-solid fa-user"
description: "Salt Naming Convention notes."
type: "docs"
weight: 400
draft: true
---

## Overview

This section includes notes on the naming conventions used for Salt states. The naming conventions are based on the Microsoft Naming Conventions for PowerShell using `verb-noun` format.

All Salt states need to be unique across the salt configuration.

To make this simpler, a naming convention should be used and each state should perform the bare minimum so that it may be included in other states.

The convention is:

```yaml
Verb Noun:
```

The Verb should be from the approved list to make it easier to find and the Noun can be any descriptive name for what you are doing.

Examples:

```yaml
Install Vim:
Configure HAProxy:
Add User Bob:
Remove User Helen:
```

### Approved Verbs

The list of approved Verbs is as follows:

- Common Verbs

|   Verb    | Description                                      |
| :-------: | :----------------------------------------------- |
|  Install  | Verb used when installing a package or product   |
| Configure | Verb used when configuring a package or product  |
|    Add    | Verb used when adding a resource                 |
|  Remove   | Verb used when adding a resource                 |
|   Copy    | Verb used when copying a resource to a minion    |
|  Delete   | Verb used when deleting a resource from a minion |
|  Create   | Verb used when creating a resource on a minion   |

- Connection Verbs

|    Verb    | Description                             |
| :--------: | :-------------------------------------- |
|  Connect   | Verb used when connecting to a resource |
| Disconnect | Verb used to disconnect from a resource |
|    Read    | Verb used when reading from a resource  |
|   Write    | Verb used when writing to a resource    |

- Data Verbs

|    Verb     | Description                        |
| :---------: | :--------------------------------- |
|   Backup    | Verb used when backing up data     |
|   Restore   | Verb used when restoring a backup  |
|   Convert   | Verb used to convert a resource    |
| ConvertFrom | Verb used to convert from a format |
|  ConvertTo  | Verb used to convert to a format   |
|    Edit     | Verb used to edit data             |
|   Export    | Verb used to export data           |
|   Import    | Verb used to import data           |

- Where possible, jinja variables should be included in the name to ensure that the state is unique.

```yaml
Install package {{ package_name }}:
```
