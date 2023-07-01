---
title: "spec.cluster"
date: 2021-03-01T00:00:00+00:00
icon: "fa-solid fa-box"
description: "spec.cluster deployment with kapp-controller"
type: "docs"
weight: 3403
draft: false
---

## Summary

- A single dedicated `mgmt` cluster has the `kapp-controller` installed.
- Each `mgmt` cluster synchronised to their own git repository or shared repository (folders).
- All images are pulled from a centralised container registry.

### Pros

- Centralised config
- Minimum operations overhead

### Cons

- Lack of separation of configuration.
- Blast radius risks

### Mitigations

- Use extensive pre-merge checks in CI

## Diagram

{{< image src="drawio/carvel/kapp-spec_dot_cluster.drawio.png" class="h-auto" alt="image" zoomable="true" width="800px" height="600px">}}
