---
title: "Hybrid"
date: 2021-03-01T00:00:00+00:00
icon: "fa-solid fa-box"
description: "A hybrid deployment with kapp-controller"
type: "docs"
weight: 3404
draft: false
---

## Summary

- Each cluster has a dedicated `kapp-controller` installed.
- Each cluster synchronised to a centralised git repository for `core-services`.
- Application owners can have their own git repository for their applications.

### Pros

- Flexibility 😕

### Cons

- Flexibility 😕

### Mitigations

- Careful planning

## Diagram

{{< image src="drawio/carvel/kapp-hybrid.drawio.png" class="h-auto" alt="image" zoomable="true" >}}
