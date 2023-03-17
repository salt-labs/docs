---
title: vSphere 7
date: 2023-02-26T00:00:00+00:00
icon: "fa-solid fa-credit-card"
description: "Upgrading Tanzu Kubernetes Grid (TKGs) on vSphere 7"
type: "docs"
weight: 201
draft: true
---

## Table of Contents

<!-- TOC -->

- [Table of Contents](#table-of-contents)
- [Overview](#overview)
- [Preparation](#preparation)
- [Upgrade](#upgrade)
  - [Upgrade using vSphere Lifecycle Manager](#upgrade-using-vsphere-lifecycle-manager)
  - [Upgrading using vCenter Server Appliance](#upgrading-using-vcenter-server-appliance)
  - [Upgrading via a Namespaces Update](#upgrading-via-a-namespaces-update)

<!-- /TOC -->

## Overview

With a little preparation, upgrading a TKGs is a straightforward process that incurs no downtime.

## Preparation

There are a few preparation steps that should be completed before upgrading a TKGs cluster.

1. Spend time on the [VMware interoperability](https://interopmatrix.vmware.com/Interoperability) website to ensure that the version of vSphere you are upgrading to is compatible with the version of TKGs you are upgrading to. This is especially important in a VMware SDDC environment where the vSphere version is dependent on the version of SDDC.

1. Spend time on the [VMware upgrade path](https://interopmatrix.vmware.com/Upgrade) website to ensure that the you are moving through a supported path.

1. Gather your upgrade information. You will need the following bit of info to upgrade a TKGs cluster:

    - The version of vSphere you are on
    - The version of TKGs you are on
    - The version of TKGs you are upgrading to

    For example;

    | Component | Current Version | New Version |
    | --------- | --------------- | ----------- |
    | vSphere   | 7.1U2           |             |
    | TKGs      | 1.4.0           | 1.4.2       |

1. Gather the versions of **ALL** workload clusters running on the TKGs cluster. You will need this information to verify [compatibility](https://docs.vmware.com/en/VMware-vSphere/7.0/vmware-vsphere-with-tanzu/GUID-292482C2-A5FA-44B5-B26E-F887A91BB19D.html) before the update.

    For example;

    | Workload Cluster | Kubernetes Version |
    | ---------------- | ------------------ |
    | cluster-1        | 1.21.8             |
    | cluster-2        | 1.21.8             |
    | cluster-3        | 1.21.8             |

    You can check the currently available releases that can be used with the following command:

    ```bash
    kubectl get tanzukubernetesreleases
    ```

    Look for the `COMPATIBLE` column in the results.

    ```bash
    NAME                                VERSION                          READY   COMPATIBLE   CREATED   UPDATES AVAILABLE
    v1.18.15---vmware.1-tkg.1.600e412   1.18.15+vmware.1-tkg.1.600e412   True    True         21h       [1.19.7+vmware.1-tkg.1.fc82c41]
    v1.19.7---vmware.1-tkg.1.fc82c41    1.19.7+vmware.1-tkg.1.fc82c41    True    True         21h       [1.20.2+vmware.1-tkg.1.1d4f79a]
    v1.20.2---vmware.1-tkg.1.1d4f79a    1.20.2+vmware.1-tkg.1.1d4f79a    True    True         21h
    ```

    VMware also provides a handy `find-incompatible-tkcs` script to help, available [HERE](https://kb.vmware.com/s/article/82592)

1. The version of TKGs that you are installing directly relates the the version of Kubernetes that will be deployed. For the latest table of Kubernetes versions and TKG versions, see the release notes. For example it might look like this:

    | Tanzu Kubernetes Grid Version | Kubernetes Version of Management Cluster | Provided Kubernetes (TKr) Versions |
    | ----------------------------- | ---------------------------------------- | ---------------------------------- |
    | 1.6.1                         | 1.23.10                                  | 1.23.10, 1.22.13, 1.21.14          |
    | 1.6.0                         | 1.23.8                                   | 1.23.8, 1.22.11, 1.21.14           |
    | 1.5.4                         | 1.22.9                                   | 1.22.9, 1.21.11, 1.20.15           |
    | 1.5.3                         | 1.22.8                                   | 1.22.8, 1.21.11, 1.20.15           |
    | 1.5.2, 1.5.1, 1.5.0           | 1.22.5                                   | 1.22.5, 1.21.8, 1.20.14            |
    | 1.4.2                         | 1.21.8                                   | 1.21.8, 1.20.14, 1.19.16           |
    | 1.4.0, 1.4.1                  | 1.21.2                                   | 1.21.2, 1.20.8, 1.19.12            |

1. Review the TKGs release notes to ensure that you are familiar with any known issues or changes in the release you are moving to. You can find the right TKG docs for your deployment on the [VMware Tanzu Kubernetes Grid](https://docs.vmware.com/en/VMware-Tanzu-Kubernetes-Grid/index.html#find-the-right-tkg-docs-for-your-deployment-2) website.

1. As with all upgrades, ensure that the cluster is in a healthy state. If the cluster is not healthy, you are setting yourself for failure.

1. If you are using the [vSphere Content Library](https://docs.vmware.com/en/VMware-vSphere/7.0/vmware-vsphere-with-tanzu/GUID-6519328C-E4B7-46DE-BE2D-FC9CA0994C39.html) to house your images, ensure that the library is healthy and the content is pre-downloaded ready for use.

## Upgrade

There are multiple options for upgrading a TKGs cluster and not all are covered here in depth. It's always a good idea to check the latest official documentation is available over on the [VMware Docs](https://docs.vmware.com/en/VMware-vSphere/7.0/vmware-vsphere-with-tanzu/GUID-E491159F-645F-4810-B9A0-8B19AF3E9219.html) website.

### Upgrade using vSphere Lifecycle Manager

If you are using vSphere Lifecycle Manager, it can't get any easier.

- See [Upgrade a Supervisor Cluster](https://docs.vmware.com/en/VMware-vSphere/7.0/vmware-vsphere-with-tanzu/GUID-2581B3E5-6A80-4306-B88E-35DE6AC81008.html)

### Upgrading using vCenter Server Appliance

If you are running the vCenter Server Appliance, each time you perform an upgrade each Supervisor Cluster that is running an `N-3` version of Kubernetes will automatically be upgraded to `N-1` version in-line with what the vCenter Server Appliance supports.

Just be sure to check for compatibility of the workload clusters **before** upgrading.

### Upgrading via a Namespaces Update

Another option is to update via a Namespace update, instructions for which can found [here](https://docs.vmware.com/en/VMware-vSphere/7.0/vmware-vsphere-with-tanzu/GUID-61B1526E-9857-438D-8EF0-A0F6CF2B055F.html).

The main points to be aware of are:

- Ensure all workloads are in a `Running` state before upgrading.
- Upgrading the Supervisor Cluster in this way will trigger a rolling upgrade of all workload clusters.
- You **MUST** update incrementally when using this method, do not skip updates.

Be sure to check your applications are compatible with the new Kubernetes version **before** upgrading. There are 3rd party solutions to assist in this area such as
