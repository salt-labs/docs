---
title: "12 Factor Applications"
date: 2021-04-19T00:00:00+00:00
icon: "fa-solid fa-box"
description: "A common pattern for building applications that are scalable, maintainable, and secure."
type: "docs"
weight: 106
draft: true
---

## Overview

In the modern era, software is commonly delivered as a service, often referred to as _software-as-a-service_.

The _twelve-factor_ app is a methodology for building _software-as-a-service_ applications that:

- Use declarative formats for setup automation, to minimize time and cost for new developers joining the project.

- Have a clean contract with the underlying operating system, offering maximum portability between execution environments.

- Are suitable for deployment on modern cloud platforms, obviating the need for servers and systems administration.

- Minimize divergence between development and production, enabling continuous deployment for maximum agility.

- Can scale up without significant changes to tooling, architecture, or development practices.

The _twelve-factor_ methodology can be applied to applications written in any programming language, and which use any combination of backing services (database, queue, memory cache, etc).

## Background

The _Heroku_ team created the _12 Factor App_ methodology to help teams build and deploy _software-as-a-service_ applications.

Their motivation was to raise awareness of some systemic problems they saw in modern application development, to provide a shared vocabulary for discussing those problems, and to offer a set of broad conceptual solutions to those problems with accompanying terminology. The format is inspired by Martin Fowler's books _Patterns of Enterprise Application Architecture and Refactoring_.

Applications deployed onto Kubernetes are often built using the _12 Factor App_ methodology following the same principles.

### Who should read this document?

- Any developer building applications which run as a service.
- Ops engineers who deploy or manage such applications.
- Platform Engineers managing Kubernetes environments.

## The Twelve Factors

| Number | Description                                                      | Link                                                                                   |
| :----: | :--------------------------------------------------------------- | :------------------------------------------------------------------------------------- |
|   1    | One codebase tracked in revision control, many deploys           | {{< button label="Codebase" link="https://12factor.net/codebase" >}}                   |
|   2    | Explicitly declare and isolate dependencies                      | {{< button label="Dependencies" link="https://12factor.net/dependencies" >}}           |
|   3    | Store config in the environment                                  | {{< button label="Config" link="https://12factor.net/config" >}}                       |
|   4    | Treat backing services as attached resources                     | {{< button label="Backing services" link="https://12factor.net/backing-services" >}}   |
|   5    | Strictly separate build and run stages                           | {{< button label="Build,Release,Run" link="https://12factor.net/build-release-run" >}} |
|   6    | Execute the app as one or more stateless processes               | {{< button label="Processes" link="https://12factor.net/processes" >}}                 |
|   7    | Export services via port binding                                 | {{< button label="Port binding" link="https://12factor.net/port-binding" >}}           |
|   8    | Scale out via the process model                                  | {{< button label="Concurrency" link="https://12factor.net/concurrency" >}}             |
|   9    | Maximize robustness with fast startup and graceful shutdown      | {{< button label="Disposability" link="https://12factor.net/disposability" >}}         |
|   10   | Keep development, staging, and production as similar as possible | {{< button label="Parity" link="https://12factor.net/dev-prod-parity" >}}              |
|   11   | Treat logs as event streams                                      | {{< button label="Logs" link="https://12factor.net/logs" >}}                           |
|   12   | Run admin/management tasks as one-off processes                  | {{< button label="Admin" link="https://12factor.net/admin-processes" >}}               |

## Related Links

- [12 Factor Applications](https://12factor.net/)
- [Catalog of Patterns of Enterprise Application Architecture](https://martinfowler.com/eaaCatalog/)
- [Martin Fowler Books](https://martinfowler.com/books/)
