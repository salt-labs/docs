---
title: "kapp-controller"
date: 2021-03-01T00:00:00+00:00
icon: "fa-solid fa-box"
description: "kapp-controller"
type: "docs"
weight: 3306
draft: false
---

## Overview

`kapp-controller` is a Kubernetes controller that manages the lifecycle of `kapps` and `carvel packages` allowing for continuous delivery and package management of kubernetes applications.

## Theory

{{< collapse "Outcomes" >}}

- [ ] Know what _kapp-controller_ is and how it fits into the `Carvel` toolchain.

{{</ collapse >}}

- Review the `kapp-controller` documentation

{{< button label="Review documentation (45min)" link="https://carvel.dev/kapp-controller/docs/latest/" >}}
<br/>

- Complete the `kapp-controller` katacoda scenario

{{< button label="Complete Scenario (15min)" link="https://katacoda.com/carvel/scenarios/kapp-controller-package-management" >}}
<br/>

### Custom Resources

A visual on the relationship between the custom resources.

{{< image src="images/carvel/CRDs.png" class="h-auto" alt="image" zoomable="true" >}}

## Practical

{{< collapse "Outcomes" >}}

- [ ] Know how to use _kapp-controller_ for deploying `packages`.

{{</ collapse >}}

For a longer form tutorial check out how `kapp-controller` fits into a _carvel package_ [the hard way](../tutorial)
