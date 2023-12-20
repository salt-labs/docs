# Docs

This repository contains the source files for the Salt Labs [docs](https://docs.saltlabs.tech) website.

## Overview

In the spirit of open collaboration, we're sharing some non-sensitive _Cloud Native Engineering_ resources that we found useful here at Salt Labs in our travels.

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

![Contributions](/assets/images/meme/contributions.png)

## Usage

Local development instructions for working with this repository.

- Ensure the submodules are up-to-date

```bash
# First time setup
git submodule update --init --recursive

# Future updates
git submodule update --recursive --remote
```

- Run your own local instance using [hugo](https://gohugo.io)

```bash
npm install

hugo server --environment development
```

- Browse to the site running on `localhost`

```bash
open http://localhost:1313/
```

- To update dependencies

```bash
# Update development dependencies
npm update --save-dev

# Update production dependencies
npm update --save-prod
```

### CI

#### GitHub Actions

There is an included workflow for Cloudflare Workers that will deploy the site.

### Theme

The official documentation for this theme (GoDocs) can be found at [gethugothemes](https://docs.gethugothemes.com/godocs/)

#### Weights

The weights are used to determine the order of the pages in the menu. The lower the weight, the higher the page will appear in the menu.

It can get a little confusing, so here's a table to track the weights.

|  Page Name   |  Weight   |
| :----------: | :-------: |
|  Changelog   |     1     |
|   Contact    |     1     |
|     FAQ      |     1     |
| Introduction |     1     |
|    Search    |     1     |
|  Frameworks  | 1000-1999 |
| Technologies | 2000-2999 |
|    Guides    | 3000-3999 |
