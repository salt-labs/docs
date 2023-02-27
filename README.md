# Docs

This repository contains the source files for the Salt Labs [docs](https://docs.saltlabs.tech) website.

## Overview

In the spirit of open collaboration, we're sharing some non-sensitive _Cloud Native Engineering_ resources that we found useful here at Salt Labs.

## Content

So what can and can't we put here?

|                    Example                     | YES / NO |
| :--------------------------------------------: | :------- |
|              Customer information              | NO ❌    |
|              Project information               | NO ❌    |
|                 Internet Links                 | YES ✅   |
| Publicly available information with references | YES ✅   |

Do you have good resources to share?

_Contributions are welcome!_

![Contributions](/static/meme/contributions.png)

## Usage

Local development instructions for working with this repository.

-   Ensure the submodules are up-to-date

```bash
# First time setup
git submodule update --init --recursive

# Future updates
git submodule update --recursive --remote
```

-   Run your own local instance using [hugo](https://gohugo.io)

```bash
hugo server \
    --verbose \
    --disableFastRender \
    --ignoreCache \
    --environment development
```

-   Browse to the site running on `localhost`

```bash
open http://localhost:1313/
```

### CI

#### GitHub Actions

There is an included workflow for Cloudflare Workers that will deploy the site.
