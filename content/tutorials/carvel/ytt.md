---
title: "ytt"
type: 'docs'
weight: 100
bookFlatSection: false
bookCollapseSection: true
bookHidden: false
bookToc: true
bookComments: false
bookSearchExclude: false
---

## Overview

`ytt` is a template and patching tool for Kubernetes. Making use of `starlark`, ytt combines the best of Helm go templates and Kustomize patching in one cohesive tool.

## ytt

{{< details "Theory" closed >}}

{{< notice warning >}}
**OUTCOMES**

- [x] Know what _ytt_ is and how it fits into the `Carvel` toolchain.

{{< /notice >}}

- `ytt` vs X

{{< button href="https://carvel.dev/ytt/docs/latest/ytt-vs-x/" >}}Review documentation (15min){{< /button >}}

- Review the `ytt` documentation

{{< button href="https://carvel.dev/ytt/docs/latest/" >}}Review documentation (45min){{< /button >}}

- An introduction to `ytt` on TGI Kubernetes.

{{< button href="https://www.youtube.com/watch?v=CSglwNTQiYg" >}}TGI Kubernetes (1hr 30min){{< /button >}}

- YAML templating with `ytt`

{{< button href="https://developer.ibm.com/blogs/yaml-templating-tool-to-simplify-complex-configuration-management/" >}}Read article (15min){{< /button >}}

{{< /details >}}

{{< details "Practical" closed >}}

{{< notice warning >}}
**OUTCOMES**

- [x] Know how to use _ytt_ for overlays.
- [x] Know how to use _ytt_ for templating.

{{< /notice >}}

### Pre-requisites

If you intend on completing the tutorial section there are some pre-requisites.

- [x] DXC corporate credentials
- [x] Linux environment with admin permissions

if using a DXC corporate Windows Laptop, the suggestion is to have either WSL installed or have available a Hyper-V Linux VM.

### Tutorial

The best way to learn about how to use `ytt` is to mess around in the [playground](https://www.get-ytt.io/).

If you're looking for some inspiration, try some of the following scenarios.

#### Follow along

- Primer on ytt overlays

https://carvel.dev/blog/primer-on-ytt-overlays/

- Parameterize project configuration

https://carvel.dev/blog/parameterizing-project-config-with-ytt/

- vendir and ytt, better togethor

https://carvel.dev/blog/tanzu-tuesdays-vendir-ytt/

#### Go you own way

1. Overlay a Namespace into a Helm Chart
1. Overlay Firewall rules into a Helm Chart
1. Template a MinIO Operator instance using data values.

{{< /details >}}
