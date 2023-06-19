---
title: "X"
date: 2021-03-01T00:00:00+00:00
icon: "fa-solid fa-box"
description: "X"
type: "docs"
weight: 200
draft: false
---

## Overview

`ytt` is a template and patching tool for Kubernetes. Making use of `starlark`, ytt combines the best of Helm go templates and Kustomize patching in one cohesive tool.

## Theory

{{< collapse "Outcomes" >}}

- [ ] Know what _ytt_ is and how it fits into the `Carvel` toolchain.

{{</ collapse >}}

- `ytt` vs X

{{< button label="Review documentation (15min)" link="https://carvel.dev/ytt/docs/latest/ytt-vs-x/" >}}

- Review the `ytt` documentation

{{< button label="Review documentation (45min)" link="https://carvel.dev/ytt/docs/latest/" >}}

- An introduction to `ytt` on TGI Kubernetes.

{{< button label="TGI Kubernetes (1hr 30min)" link="https://www.youtube.com/watch?v=CSglwNTQiYg" >}}

- YAML templating with `ytt`

{{< button label="Read article (15min)" link="https://developer.ibm.com/blogs/yaml-templating-tool-to-simplify-complex-configuration-management/" >}}

## Practical

{{< collapse "Outcomes" >}}

- [ ] Know how to use _ytt_ for overlays.
- [ ] Know how to use _ytt_ for templating.

{{</ collapse >}}

### Pre-requisites

If you intend on completing the tutorial section there are some pre-requisites.

- [ ] Linux environment with admin permissions

if using a Windows Laptop, the suggestion is to have either WSL installed or have available a Hyper-V Linux VM.

### Tutorial

The best way to learn about how to use `ytt` is to mess around in the [playground](https://www.get-ytt.io/).

If you're looking for some inspiration, try completing some of the following scenarios.

#### Follow along

- Primer on ytt overlays

{{< button label="Blog Post (15min)" link="https://carvel.dev/blog/primer-on-ytt-overlays/" >}}

- Parameterize project configuration

{{< button label="Blog Post (30min)" link="https://carvel.dev/blog/parameterizing-project-config-with-ytt/" >}}

- vendir and ytt, better together

{{< button label="Blog Post (30min)" link="https://carvel.dev/blog/tanzu-tuesdays-vendir-ytt/" >}}

#### Go you own way

Now try creating your own using these common examples.

- [ ] Overlay a Namespace into a Helm Chart
- [ ] Overlay Firewall rules into a Helm Chart
- [ ] Template a MinIO Operator instance using data values.
