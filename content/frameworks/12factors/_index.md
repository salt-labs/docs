---
title: "12 Factor Applications"
date: 2021-04-19T00:00:00+00:00
icon: "fa-solid fa-box"
description: "A common pattern for building applications that are scalable, maintainable, and secure."
type: "docs"
weight: 100
draft: true
---

## Overview

In the modern era, software is commonly delivered as a service, often referred to as _software-as-a-service_.

The _twelve-factor_ app is a methodology is for building _software-as-a-service_ applications that:

-   Use declarative formats for setup automation, to minimize time and cost for new developers joining the project.

-   Have a clean contract with the underlying operating system, offering maximum portability between execution environments.

-   Are suitable for deployment on modern cloud platforms, obviating the need for servers and systems administration.

-   Minimize divergence between development and production, enabling continuous deployment for maximum agility.

-   Can scale up without significant changes to tooling, architecture, or development practices.

The _twelve-factor_ methodology can be applied to applications written in any programming language, and which use any combination of backing services (database, queue, memory cache, etc).

## Background

The _Heroku_ team created the _12 Factor App_ methodology to help teams build and deploy _software-as-a-service_ applications.

Their motivation was to raise awareness of some systemic problems they saw in modern application development, to provide a shared vocabulary for discussing those problems, and to offer a set of broad conceptual solutions to those problems with accompanying terminology. The format is inspired by Martin Fowler's books _Patterns of Enterprise Application Architecture and Refactoring_.

Applications deployed onto Kubernetes are often built using the _12 Factor App_ methodology following the same principles.

### Who should read this document?

-   Any developer building applications which run as a service.
-   Ops engineers who deploy or manage such applications.
-   Platform Engineers managing Kubernetes environments.

## The Twelve Factors

| Number | Description                                                      | Link                                                                                         |
| :----: | :--------------------------------------------------------------- | :------------------------------------------------------------------------------------------- |
|   1    | One codebase tracked in revision control, many deploys           | {{< button href="https://12factor.net/codebase" >}}Codebase{{< /button >}}                   |
|   2    | Explicitly declare and isolate dependencies                      | {{< button href="https://12factor.net/dependencies" >}}Dependencies{{< /button >}}           |
|   3    | Store config in the environment                                  | {{< button href="https://12factor.net/config" >}}Config{{< /button >}}                       |
|   4    | Treat backing services as attached resources                     | {{< button href="https://12factor.net/backing-services" >}}Backing services{{< /button >}}   |
|   5    | Strictly separate build and run stages                           | {{< button href="https://12factor.net/build-release-run" >}}Build,Release,Run{{< /button >}} |
|   6    | Execute the app as one or more stateless processes               | {{< button href="https://12factor.net/processes" >}}Processes{{< /button >}}                 |
|   7    | Export services via port binding                                 | {{< button href="https://12factor.net/port-binding" >}}Port binding{{< /button >}}           |
|   8    | Scale out via the process model                                  | {{< button href="https://12factor.net/concurrency" >}}Concurrency{{< /button >}}             |
|   9    | Maximize robustness with fast startup and graceful shutdown      | {{< button href="https://12factor.net/disposability" >}}Disposability{{< /button >}}         |
|   10   | Keep development, staging, and production as similar as possible | {{< button href="https://12factor.net/dev-prod-parity" >}}Parity{{< /button >}}              |
|   11   | Treat logs as event streams                                      | {{< button href="https://12factor.net/logs" >}}Logs{{< /button >}}                           |
|   12   | Run admin/management tasks as one-off processes                  | {{< button href="https://12factor.net/admin-processes" >}}Admin{{< /button >}}               |

## References

-   [12 Factor Applications](https://12factor.net/)
-   [Catalog of Patterns of Enterprise Application Architecture](https://martinfowler.com/eaaCatalog/)
-   [Martin Fowler Books](https://martinfowler.com/books/)
