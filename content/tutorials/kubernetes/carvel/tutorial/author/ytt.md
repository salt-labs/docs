---
title: "ytt"
date: 2021-03-01T00:00:00+00:00
icon: "fa-solid fa-box"
description: "Data Values and Overlays"
type: "docs"
weight: 3504
draft: false
---

Now it's time to learn about _data values_ and _overlays_.

{{< notice tip >}}👍 Data Values and Overlays are super-awesome and important to learn.
{{< /notice >}}

One of the most powerful features of the Carvel toolchain is the ability to extend upstream content using `ytt` overlays.

Combining the best of Helm and Kustomize, `ytt` offers both data values and overlays.

Rather than forking upstream Helm charts and having to maintain them, we can overlay only small changes that might be required and still get all of the benefits of declarative package management. :ok_hand:

Once you have obtained your unmodified upstream configuration, the next step is to extend the configuration beyond what the original author has created.

Common usage examples might be to;

- Add Firewall Rules
- Add required annotations
- Lock-down RBAC
- Add or remove certain configuration items that don't suit your environment.

The Carvel toolchain, courtesy of `ytt`, has two ways to achieve this.

1. **Data Values:** Similar to `helm` values, these allow you to change common options at install time.
1. **Overlays:** Similar to `kustomize`, these allow you to patch, extend or remove items as required.

For more information on when and how to use each method, you can refer to the [documentation](https://carvel.dev/ytt/docs/develop/data-values-vs-overlays/). There is also a great blog article and primer video [here](https://carvel.dev/blog/primer-on-ytt-overlays/).

For this example, let's set a _fictional_ scenario.

- You have been provided a Helm chart from a third party.
- Upon inspection, you have found the `namespace` has been **hardcoded** to a value you need to override in your environment.
- There is no helm value to override the name in the current Helm chart. (we are pretending the `--namespace` option doesn't exist)
- You have no access to the source code to contribute the the changes upstream.

This is obviously a contrived example, and for such a simple issue you would attempt to get a value added to the source upstream, but never the less, it will demonstrate how to use overlays to override a simple `namespace` value.

Let's create a simple `overlay` to allow overriding the `namespace` value.

{{< tabs "ytt-overlay" >}}

{{< tab "Linux" >}}

```bash
# Create the Overlay file
cat <<- _EOF_ > "${ROOT_DIR}/packages/${PACKAGE_NAME}/${PACKAGE_VERSION}/bundle/ytt/overlays/replace-namespace.yaml"
#@ load("@ytt:data", "data")
#@ load("@ytt:overlay", "overlay")

#@overlay/match by=overlay.all, expects="1+"
#@overlay/merge
---

#@overlay/match expects=1
#@overlay/merge
metadata:
  #@overlay/match missing_ok=True
  #@overlay/replace
  namespace: #@ data.values.namespace
_EOF_

# Define the ytt values schema with example value types.
# This also acts as fallback default values for the package, if not provided in values.yaml
cat <<- _EOF_ > "${ROOT_DIR}/packages/${PACKAGE_NAME}/${PACKAGE_VERSION}/bundle/ytt/values-schema.yaml"
#! values-schema.yaml

#@data/values-schema
#@schema/desc "OpenAPIv3 Schema for pacman"
---
#@schema/desc "The namespace in which pacman is deployed"
#@schema/nullable
namespace: ""
_EOF_

# Define default data values for the package.
# These are values that can be overridden by Package Consumers in the Secret config at install time.
cat <<- _EOF_ > "${ROOT_DIR}/packages/${PACKAGE_NAME}/${PACKAGE_VERSION}/bundle/ytt/values.yaml"
#! values.yaml

#@data/values
---
namespace: "pacman"
_EOF_
```

{{< /tab >}}

{{< /tabs >}}

What is this syntax you ask, [windings?](https://en.wikipedia.org/wiki/Wingdings) :confused:

{{< notice note >}}ytt uses [starlark](https://github.com/bazelbuild/starlark), a python dialect, to provide a powerful templating language, all within yaml comments.
{{< /notice >}}

But how do you know if it works? Let's test...

This is to show what the package config we configure later is doing for us automatically under the hood.

The `kapp-controller` can be installed into a cluster to provide a `Kubernetes` native way to manage the lifecycle of your carvel packages.

In this example, the package would;

- Template this example with Helm
- Pass the result through ytt and overlay the default values defined in the package.

This is a very simple example of the level of customisation you can perform.

- First, let's see what a normal `helm template` would give us.

{{< tabs "ytt-helm-template" >}}

{{< tab "Linux" >}}

```bash
helm template ${PACKAGE_NAME} \
    "${ROOT_DIR}/packages/${PACKAGE_NAME}/${PACKAGE_VERSION}/bundle/vendor/helm/" \
    --values "${ROOT_DIR}/packages/${PACKAGE_NAME}/${PACKAGE_VERSION}/bundle/vendor/helm/values.yaml" \
| \
grep "namespace:"
```

{{< /tab >}}

{{< /tabs >}}

- Now again, this time applying the overlay.

{{< tabs "ytt-overlay" >}}

{{< tab "Linux" >}}

```bash
# This allows you to rapidly test and iterate on you changes before creating the entire package.
helm template ${PACKAGE_NAME} \
  "${ROOT_DIR}/packages/${PACKAGE_NAME}/${PACKAGE_VERSION}/bundle/vendor/helm/" \
  --values "${ROOT_DIR}/packages/${PACKAGE_NAME}/${PACKAGE_VERSION}/bundle/vendor/helm/values.yaml" \
| \
ytt \
  --file - \
  --file "${ROOT_DIR}/packages/${PACKAGE_NAME}/${PACKAGE_VERSION}/bundle/ytt/values-schema.yaml" \
  --file "${ROOT_DIR}/packages/${PACKAGE_NAME}/${PACKAGE_VERSION}/bundle/ytt/values.yaml" \
  --file "${ROOT_DIR}/packages/${PACKAGE_NAME}/${PACKAGE_VERSION}/bundle/ytt/overlays" \
| \
grep "namespace:"
```

{{< /tab >}}

{{< /tabs >}}

{{< notice tip >}}👍 `ytt` has a handy flag `--data-values-inspect` you can use when developing to see if the resulting values are what you expect.
{{< /notice >}}
