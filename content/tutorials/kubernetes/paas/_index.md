---
title: "PaaS"
date: 2020-10-20T15:00:00+10:00
icon: "fab fa-kubernetes"
description: "Building a Platform as a Service with Kubernetes."
type: "docs"
weight: 3202
draft: false
---

## Overview

Building a Platform as a Service with Kubernetes.

Kubernetes has been described as many things, one of which is a _Platform for building Platforms_. By itself, Kubernetes is a powerful orchestration engine for containers, but when combined with an ecosystem of harmoniously integrated tools, it can be used to offer a complete Platform as a Service (PaaS).

A Platform as a Service in this context allows Developers to spend more time on the _business logic_ and less time on the _infrastructure_. After all, the goal for _most companies_ is to build or provide a product to their internal or external clients, not to manage infrastructure.

## Definitions

The industry is full of buzzwords and acronyms, and varying definitions of the same terms.

To better understand the content of _this_ guide, let's clarify some important terms that will be used throughout.

- **Kubernetes:** Kubernetes is an open-source container orchestration system that automates application deployment, scaling, and management. It serves as the underlying _engine_ for the prescribed PaaS.
- **Kubernetes Runtime:** A Kubernetes Runtime is a set of tools used to build and manage multiple Kubernetes clusters. It provides the necessary infrastructure to create, manage, and run Kubernetes clusters on a particular computing platform.
- **Platform-as-a-Service (PaaS):** A Platform-as-a-Service (PaaS) is a cloud computing model that offers a platform to customers for developing, running, and managing applications without the complexity of building and maintaining the infrastructure typically required to launch an app. A PaaS abstracts away the complexities of managing Kubernetes clusters and provides users with an easy-to-use interface to deploy their applications.

## Journey

_It all starts with a plan._

No matter what the sales brochures tell you, building an enterprise Kubernetes platform is no easy feat. It requires a lot of planning and preparation before the first line of code is written.

The below links walk through some opinionated categories that should be considered when building your own PaaS.

- [Stages](stages)
- [Runtime](runtime)
- [Platform as a Service](platform)
- [An example starter backlog](./backlog.csv)

Once your PaaS is up and running, it's time to verify you're cluster is production-ready and start start building and shipping your applications.

- [Production-ready](production)
