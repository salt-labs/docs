---
title: "kapp-controller"
date: 2021-03-01T00:00:00+00:00
icon: "fa-solid fa-box"
description: "The kapp-controller"
type: "docs"
weight: 3508
draft: false
---

Clusters can install the `kapp-controller` to enable the management of carvel packages.

You can skip this section if you're working with a cluster that includes the `kapp-controller` as part of the base SKU.

To see how the underlying system works, or to test locally, here are the steps to install the `kapp-controller` manually into your cluster and grant the necessary permissions.

In order for the `kapp-controller` to be able to install packages in your cluster, we need need to grant access with a service account.

- Deploy the `kapp-controller` to your cluster.

{{< tabs "kapp-controller" >}}

{{< tab "Linux" >}}

```bash
kapp deploy \
  --app kapp-controller \
  --namespace kapps \
  --diff-changes \
  --yes \
  --wait \
  --file https://github.com/vmware-tanzu/carvel-kapp-controller/releases/latest/download/release.yml
```

{{< /tab >}}

{{< /tabs >}}

- Create the RBAC template for the `kapp-controller` service account.

{{< tabs "kapp-controller-rbac-file" >}}

{{< tab "Linux" >}}

```bash
mkdir -p other/ytt/kapp-controller

cat << EOF > other/ytt/kapp-controller/rbac.yml
#@ load("@ytt:data", "data")
---
apiVersion: v1
kind: ServiceAccount
metadata:
  name: #@ str(data.values.name) + "-sa"
  namespace: #@ data.values.namespace
  annotations:
    kapp.k14s.io/change-group: #@ str(data.values.name) + "-rbac"
    kapp.k14s.io/change-rule.create-order: #@ "upsert after upserting " + str(data.values.name) + "-" + "namespace"
    kapp.k14s.io/change-rule.delete-order: #@ "delete before deleting " + str(data.values.name) + "-" + "namespace"

---
kind: ClusterRole
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  name: #@ str(data.values.name) + "-cluster-admin"
  annotations:
    kapp.k14s.io/change-group: #@ str(data.values.name) + "-rbac"
    kapp.k14s.io/change-rule.create-order: #@ "upsert after upserting " + str(data.values.name) + "-" + "namespace"
    kapp.k14s.io/change-rule.delete-order: #@ "delete before deleting " + str(data.values.name) + "-" + "namespace"
rules:
  - apiGroups:
      - "*"
    resources:
      - "*"
    verbs:
      - "*"

---
kind: ClusterRoleBinding
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  name: #@ str(data.values.name) + "-cluster-admin"
  annotations:
    kapp.k14s.io/change-group: #@ str(data.values.name) + "-rbac"
    kapp.k14s.io/change-rule.create-order: #@ "upsert after upserting " + str(data.values.name) + "-" + "namespace"
    kapp.k14s.io/change-rule.delete-order: #@ "delete before deleting " + str(data.values.name) + "-" + "namespace"
subjects:
  - kind: ServiceAccount
    name: #@ str(data.values.name) + "-sa"
    namespace: #@ data.values.namespace
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: #@ str(data.values.name) + "-cluster-admin"
EOF
```

{{< /tab >}}

{{< /tabs >}}

- Create the Service Account and Role Based Access Controls for Kapp Controller.

{{< tabs "kapp-controller-rbac" >}}

{{< tab "Linux" >}}

```bash
# Render the YTT template using your defined values and apply to the cluster.
ytt \
  --file other/ytt/kapp-controller/RBAC.yaml \
  --data-value name="${PACKAGE_NAMESPACE}" \
  --data-value namespace="${PACKAGE_NAMESPACE}" \
| \
kubectl apply -f -
```

{{< /tab >}}

{{< /tabs >}}

Hang in there, we are almost done!
