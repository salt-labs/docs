---
title: TKG v2.1
date: 2023-07-05T00:00:00+00:00
icon: "fa-solid fa-user"
description: "TKG v2.1"
type: "docs"
weight: 2101
draft: true
---

## Overview

Tanzu Kubernetes Grid v2.x is a major release up from TKG v1.6. There are quite a few new features and changes that make this a significant release.

## Features

### Cluster Classes

Previously, when templating a Tanzu Kubernetes Cluster (TKC), we would use `ytt` client side to create the templates before passing the the Control Plane for creation.

Now, in v2.1, Cluster Classes from the upstream ClusterAPI (CAPI) have been implemented. Cluster Class was a feature [announced](https://kubernetes.io/blog/2021/10/08/capi-clusterclass-and-managed-topologies/#clusterclass) in 2021 and the announcement includes a good summary.

> The idea behind ClusterClass is simple: define the shape of your cluster once, and reuse it many times, abstracting the complexities and the internals of a Kubernetes cluster away. The general idea is to have a template of a cluster and its resources in the management cluster and then whenever we create a cluster, we can reference this template and supply the values that are specific to this cluster, this allows for reuse of almost all of the boilerplate, and to allow us to only supply when creating a cluster, the needed values that are specific to this exact cluster we are creating.

TKG has implemented this in a new and interesting way. Whereas, some of us have gotten used to the power of `ytt`, TKG v2.1 uses JSON patching and Go templating which is performed server-side.

Creating a `ClusterClass` from scratch is well documented in the the [Cluster API Book](https://cluster-api.sigs.k8s.io/tasks/experimental-features/cluster-class/write-clusterclass.html).

{{< image src="images/tkg/Cluster_vs_ClusterClass.webp" class="h-auto" alt="image" zoomable="true" >}}
<br/>

### Networking Enhancements

Gone are the days of issues with DHCP and Control Plane nodes, the IPAM controller is now available in v2.1. There are new objects that can be used to define the IPAM configuration for the cluster.

- `InClusterIPPool` A pool of IP addresses that can be used nodes.
- `IPAddressClaim` A custom resource that when created gets an IP Address back. Works in the same way as `PVC`
- `IPAddress` The custom resource that represents the IP Address.

One small thing to be aware of. No longer can you use a `CNI:none` like in v1.x. No more BYO CNI provider.

### Security Enhancements

`Pod Security Policies` are officially gone, and in their place `Pod Security Admission` are now available in v2.1.

The downside is many current packages need to be updated in order to support this new control measure.

#### Certificate Management

Probably my favourite feature of TKG v2.1 for environments which are infrequently updated.

_Auto-rollout of nodes to renew certificates._ You can set how long before the certs expire to auto-rollout the nodes and re-generate certs. This means that automatically, prior to the 365 day expiry the nodes can be rolled out with new certs.

### Feature Definitions

In TKG 2.1 VMware has defined four different [levels](https://docs.vmware.com/en/VMware-Tanzu-Kubernetes-Grid/2/about-tkg/support-policies.html) of features with support policies and guarantees.

1. **Experimental:** No supported and voids support for the _entire_ environment when used.
2. **Technical Preview:** Not supported, but does not void warranty for its environment.
3. **Stable:** Fully tested and supported for production environments.
4. **Deprecated:** Tested and supported, but with end of support expected.

### GitOps

Now in TKG v2.1, as the templating is done server side, you no longer need full YAML for CAPI manifests. The `kapp-controller` can be used the same way for application and infrastructure manifests.

### Improved Air-gapped support

The Tanzu CLI now includes a useful command for those of us working in internet restricted or air-gapped environments.

- On the internet-connected run the following

```bash
tanzu isolated-cluster download-bundle \
  --source-repo projects.registry.vmware.com/tkg \
  --tkg-version v2.1.0 \
  --verbose
```

- Then, [SneakerNet](https://en.wikipedia.org/wiki/Sneakernet) the bundle to the air-gapped environment and run the following

```bash
BUNDLE_SOURCE="/path/to/bundle"
BUNDLE_DESTINATION="harbor.internal.or/tkg"
CA_CERT="/path/to/ca.crt"

tanzu isolated-cluster upload-bundle \
  --source-directory "${BUNDLE_SOURCE}" \
  --destination-repo "${BUNDLE_DESTINATION}" \
  --ca-cert "${CA_CERT}" \
  --verbose
```

In addition to this new command for the Tanzu CLI, VMware has also solved a little chicken and egg issue with the need for a private registry being needed to be depoloyed prior to deploying TKG.

Now, there is a new Habor OVA that can be deployed to the vSphere environment and used as the private registry for TKG to solve this issue.
