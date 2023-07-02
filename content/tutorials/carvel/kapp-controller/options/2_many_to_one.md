---
title: "Many to One"
date: 2021-03-01T00:00:00+00:00
icon: "fa-solid fa-box"
description: "Many to One deployment with kapp-controller"
type: "docs"
weight: 3402
draft: false
---

## Summary

- Each cluster has a dedicated `kapp-controller` installed.
- Each cluster synchronised to a shared repository (folders)
- All images are pulled from a centralised container registry.

### Pros

- Less operational overhead
- Centralised repository for all clusters.

### Cons

- Blast radius risks
- Overlay mistakes
- Lack of separation of configuration.

### Mitigations

- Use extensive pre-merge checks in CI

## Diagram

{{< image src="drawio/carvel/kapp-many-to-one.drawio.png" class="h-auto" alt="image" zoomable="true" >}}
