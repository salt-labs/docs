---
title: "Packages"
date: 2021-03-01T00:00:00+00:00
icon: "fa-solid fa-box"
description: "Working with Carvel packages"
type: "docs"
weight: 3308
draft: false
---

## Overview

Once you know about the individual tools, it's time to look at how to combine them.

The carvel toolchain has a clear separation between the `Package Author` and `Package Consumer` personas.

- `Package Authors` create and publish Carvel packages.
- `Package Consumers` deploy and update Carvel packages is running clusters.

Depending on your team size and responsibilities you might wear both hats 🤠

### Package Author

Tutorials for the Carvel `Package Author`.

|            Name             | Description                                                       |
| :-------------------------: | :---------------------------------------------------------------- |
| [The hard way](author/hard) | Learn how the sausage is made building a Carvel package manually. |
| [The easy way](author/easy) | Take the easy way out with the awesome `kctrl` utility.           |

### Package Consumer

Tutorials for the Carvel `Package Consumer`.

|             Name              | Description                             |
| :---------------------------: | :-------------------------------------- |
| [The easy way](consumer/easy) | The consumer only has the _easy_ way 😄 |
