---
title: Bootstrap
date: 2016-04-14T00:00:00+00:00
icon: "fa-solid fa-user"
description: "Bootstrap using Salt Orchestrator."
type: "docs"
weight: 400
draft: false
---

## Overview

There are a number of ways to Bootstrap an initial Salt-Master deployment.

A generic workflow example:

**Bootstrap Scaffolding:**

- Manually fill in the answer file
- Use the Salt-Orchestrator to create the scaffolding for the environment
- Use Salt-Cloud with "make_master" to deploy an Instance for the Salt-Master
- Configure the Salt-Master with an initial configuration

**Bootstrap Environment:**

- Execute a High State on the newly deployed Salt-Master
- Use Salt-Cloud from the new Salt-Master to deploy a Map of the environment

### Amazon Web Services

This bootstrap process is based on the following Architecture.

![AWS Architecture](/images/salt-project/salt-orchestrator/aws/architecture.png "AWS Architecture")

The steps to bootstrap Salt in AWS are as follows:

1. XXX

### Microsoft Azure

This bootstrap process is based on the following Architecture.

![Azure Architecture](/images/salt-project/salt-orchestrator/azure/architecture.png "Azure Architecture")

The steps to bootstrap Salt in Azure are as follows:

1. XXX

### Google Cloud Platform

This bootstrap process is based on the following Architecture.

![GCP Architecture](/images/salt-project/salt-orchestrator/gcp/architecture.png "GCP Architecture")

The steps to bootstrap Salt in GCP are as follows:

1. Manually create a project within the GCP console.

1. Manually enable Compute Engine

1. Manually Create a Service Account

   Navigate to

   - IAM & Admin
   - Service Accounts
   - Create Service Account
     ![GCP Service Account](/images/salt-project/salt-orchestrator/gcp/service_account.png "GCP Service Account")
   - Download the .json file and store securely
   - Configure the Salt-Cloud Provider

1. Complete the steps in the Common Section below.

### VMware

This bootstrap process is based on the following Architecture

[VMware Architecture](/images/salt-project/salt-orchestrator/vmware/architecture.png "VMware Architecture")

The steps to bootstrap Salt in VMware are as follows:

### Common

#### Deploy

Complete these steps which are common across all Cloud Providers.

1. Manually fill in the answer file

**NOTE:** Ensure that AWS is Enabled in the Answer File

```bash
vim Answer_File.yaml
```

1. Bootstrap the environment

```bash
salt-run state.orchestrate orch.Bootstrap pillar='{"Deploy": True}'
```

#### Destroy

To Destroy a previously bootstrapped environment:

```bash
salt-run state.orchestrate orch.Bootstrap pillar='{"Destroy": True}'
```
