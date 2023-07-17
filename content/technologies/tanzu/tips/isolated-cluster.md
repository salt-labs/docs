---
title: Isolated Clusters
date: 2023-07-05T00:00:00+00:00
icon: "fa-solid fa-user"
description: "Management cluster deployment for Isolated Clusters"
type: "docs"
weight: 2202
draft: false
---

## Overview

Deployment steps for a new management cluster in an internet restricted environment.

## Online

Complete the following steps from and internet connected PC.

- Create a folder to store all the required files. All commands will be run from this folder.

```bash
BUNDLE_DEST="/tmp/tkg"
mkdir -p "${BUNDLE_DEST}" && cd "${BUNDLE_DEST}"
```

- Download the following items from [here](https://customerconnect.vmware.com/downloads/details?downloadGroup=TKG-220&productId=1400)

  - VMware Tanzu CLI for Linux
  - Photon v3 Kubernetes OVA for the Management Cluster
  - Kubectl CLI for Linux
  - Harbor OVA

- Download the OVFTool from [here](https://developer.vmware.com/web/tool/4.4.0/ovf)

- Place all download items into the `${BUNDLE_DEST}/tools` directory.

- Place all your cluster configs into the `${BUNDLE_DEST}/config` directory.

```bash
mkdir -p "${BUNDLE_DEST}/config"

tree -L 1 "${BUNDLE_DEST}/config"
.
├── mgmt.yaml
└── workload.yaml
```

- Install the Tanzu CLI on the local machine.

- Initialise the Tanzu CLI once installed

```bash
tanzu init
```

- Prepare the necessary files locally. Note this step requires approximately `GB` of free space.

```bash
mkdir bundle && pushd bundle

TKG_VERSION="v2.1.0"

tanzu isolated-cluster download-bundle \
  --source-repo projects.registry.vmware.com/tkg \
  --tkg-version "${TKG_VERSION}" \
  --verbose 9

popd
```

- Copy the contents of the `${BUNDLE_DEST}` directory to the air-gapped environment.

```bash
tree -L 1 "${BUNDLE_DEST}"
.
├── bundle
└── tools
```

## Offline

Complete the following steps from the bootstrap PC to setup the greenfields environment.

- Deploy the Harbor OVA to the vSphere environment.

```bash
# Harbor details
HARBOR_OVA="harbor.ova"
HARBOR_OVF="harbor.ovf"
HARBOR_VM="harbor-tkg"
HARBOR_NET="mgmt"
HARBOR_IP="192.168.1.1"
HARBOR_NETMASK="255.255.255.0"
HARBOR_GATEWAY="192.168.1.254"
HARBOR_DNS_1="192.168.1.101"
HARBOR_DNS_2="192.168.1.102"
HARBOR_DOMAIN="mgmt.local"
HARBOR_ROOT_PASS="Vmware123!"
HARBOR_DB_PASS="Vmware123!"
HARBOR_ADMIN_PASS="Vmware123!"

# vCenter details
VCENTER_HOST="vcenter.mgmt.local"
VCENTER_USER="administrator@vsphere.local"
VCENTER_PASS="Vmware123!"
VCENTER_DATASTORE="vsan-lab"
VCENTER_DATACENTER="datacenter1"
VCENTER_CLUSTER="vsphere-cluster"
VCENTER_PATH="/${VCENTER_DATACENTER}/vm/${VCENTER_CLUSTER}/${HARBOR_VM}"

ovftool "${HARBOR_OVA}" "${HARBOR_OVF}"

ovftool \
  --datastore="${VCENTER_DATASTORE}" \
  --name="${HARBOR_VM}" \
  --net:"Network 1"="${HARBOR_NET}" \
  --diskMode=thin \
  --powerOn \
  --X:waitForIp \
  --X:injectOvfEnv \
  --X:enableHiddenProperties \
  --prop:vami.domain.Harbor="${HARBOR_DOMAIN}" \
  --prop:root_pw="${HARBOR_PASS}" \
  --prop:harbor_admin_password="${HARBOR_ADMIN_PASS}" \
  --prop:db_password="${HARBOR_DB_PASS}" \
  --prop:vami.searchpath.Harbor="${HARBOR_DOMAIN}" \
  --prop:vami.DNS.Harbor="${HARBOR_DNS_1},${HARBOR_DNS_2}" \
  --prop:vami.ip0.Harbor="${HARBOR_IP}" \
  --prop:vami.netmask0.Harbor="${HARBOR_NETMASK}" \
  --prop:vami.gateway.Harbor="${HARBOR_GATEWAY}" \
  --prop:vm.vmname="${HARBOR_VM}" \
  "${HARBOR_OVF}" \
  "vi://${VCENTER_USER}:${VCENTER_PASS}@${VCENTER_HOST}/${VCENTER_PATH}"
```

- Create a DNS entry for the Harbor instance.

- Login to the Harbor instance and create a project Tanzu Kubernetes Grid images.

- Using the local bundle, upload the images to the Harbor instance.

```bash
BUNDLE_SOURCE="/path/to/bundle"
BUNDLE_DESTINATION="harbor.mgmt.local/tkg"
CA_CERT="/path/to/ca.crt"

tanzu isolated-cluster upload-bundle \
  --source-directory "${BUNDLE_SOURCE}" \
  --destination-repo "${BUNDLE_DESTINATION}" \
  --ca-cert "${CA_CERT}" \
  --verbose 9
```

- Using the Tanzu CLI, create a management cluster.

```bash
tanzu management-cluster create \
  --file "${BUNDLE_DEST}/config/mgmt.yaml \
  --log-file /tmp/tkg-mgmt.log \
  --verbose 9
```
