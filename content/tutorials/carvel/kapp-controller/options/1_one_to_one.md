---
title: "One to One"
date: 2021-03-01T00:00:00+00:00
icon: "fa-solid fa-box"
description: "One to One deployment with kapp-controller"
type: "docs"
weight: 3401
draft: false
---

## Summary

- Each cluster has a dedicated `kapp-controller` installed.
- Each cluster synchronised to their own git repository.
- All images are pulled from a centralised container registry.

### Pros

- Minimum blast radius.
- Separation of configuration.

### Cons

- Operational overhead.

### Mitigations

- Larger team
- Dedicated time for maintenance

## Diagram

{{< image src="drawio/carvel/kapp-one-to-one.drawio.png" class="h-auto" alt="image" zoomable="true" >}}
