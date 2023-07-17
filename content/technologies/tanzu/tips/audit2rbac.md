---
title: Audit2RBAC
date: 2023-07-05T00:00:00+00:00
icon: "fa-solid fa-user"
description: "Audit2RBAC"
type: "docs"
weight: 2201
draft: true
---

## Overview

An open source tool created by [Jordan Liggitt](https://github.com/liggitt) in the same vein as Netflix's [repokid](https://github.com/Netflix/repokid) allows you to generate RBAC resouce manifests for a specific service account using a Kubernetes audit log.

- Install you package

- Obtain the `audit.log` from a control plane node.

```bash
cat /var/log/kubernetes/audit.log
```

- Run the tool

```bash
APP_NAME="my-app"
SA=my-service-account
ANNOTATIONS="tkg.tanzu.vmware.com/tanzu-package=contour-tkg-system"
LABELS=""

audit2rbac \
  --file audit.log \
  --serviceaccount "${SA}" \
  --generate-annotations "${ANNOTATIONS}" \
  --generate-labels="${LABELS}" \
  --generate-name "${APP_NAME}-system" > "${APP_NAME}-rbac.yaml"
```
