---
title: "Hybrid"
date: 2021-03-01T00:00:00+00:00
icon: "fa-solid fa-box"
description: "A hybrid deployment with kapp-controller"
type: "docs"
weight: 3403
draft: false
---

## Summary

- Each cluster has a dedicated `kapp-controller` installed.
- Each cluster synchronised to a centralised git repository for `core-services`.
- Application owners can have their own git repository for their applications.

### Pros

- Centralised config
- Minimum operations overhead

### Cons

- Lack of separation of configuration.
- Blast radius risks

### Mitigations

- Use extensive pre-merge checks in CI
- Use lifecycle promotion of core-services

## Diagram

{{< image src="drawio/carvel/kapp-hybrid.drawio.png" class="h-auto" alt="image" zoomable="true" width="800px" height="600px">}}
