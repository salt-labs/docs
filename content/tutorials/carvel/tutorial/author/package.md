---
title: "Package"
date: 2021-03-01T00:00:00+00:00
icon: "fa-solid fa-box"
description: "Carvel package custom resource"
type: "docs"
weight: 3506
draft: false
---

At this point in the tutorial, we have a `bundle` on the local file system, but how to we get it into OCI format into a container registry for consumption?

{{< notice info >}}👍 **What's a bundle?** You will learn more about bundles in the `imgpkg` section later, but for now think of a bundle as a configuration file and a list of references to one or more container images.
{{< /notice >}}

Now it's time to create our first custom resource, the `Package`.

- Create the `PackageMetadata` object first.

{{< tabs "pkg-pkgm" >}}

{{< tab "Linux" >}}

```bash
cat <<- _EOF_ > "${ROOT_DIR}/packages/${PACKAGE_NAME}/PackageMetadata.yaml"
---
apiVersion: data.packaging.carvel.dev/v1alpha1
kind: PackageMetadata
metadata:
  name: ${PACKAGE_NAME}.${PACKAGE_FQN}
spec:
  displayName: "${PACKAGE_DISPLAY}"
  shortDescription: "${PACKAGE_DESC_SHORT}"
  longDescription: "${PACKAGE_DESC_LONG}"
  categories:
    - demo
_EOF_
```

{{< /tab >}}

{{< /tabs >}}

**Question:** Wait, now hold up. What is this `PackageMetadata` object and all this about?

**Answer:** This is a custom resource that is used by the `kapp-controller` to manage packages. It is a way to store metadata about the package, such as the name, description, and categories. For linux users, a good analogy is thinking of it like `apt` in debian based distros. First you `apt update` the metadata to see what packages are available in the repository, then you `apt install` the package you want. A similar model is used with carvel.

You can refer to the documentation [here](https://carvel.dev/kapp-controller/docs/v0.46.0/packaging/) for additional depth in the custom resource definitions.

- Now let's generate the OpenAPI schema from the values. When writing schemas, the [cheatsheet](https://carvel.dev/ytt/docs/develop/schema-validations-cheat-sheet/) is your friend. **Bookmark it!**

{{< notice warning >}}⚠️ **HERE BE DRAGONS** This is an amazing capability of carvel to validate schemas before installing packages, but it is not without it's challenges.
{{< /notice >}}

This part is challenging to include in a tutorial for several reasons.

- There is not one single method to create Kubernetes applications, but several...
- There _is_ however one format the schema is required in, **OpenAPI v3+**.

This may take more or less effort based on the upstream sources you have been handed.

Below are just a few examples of what you might come across.

{{< notice note >}}**IMPORTANT:** For this tutorial, you only need to follow the _"generic helm"_ option. The others are provided for reference about possible options you might encounter as a package author.
{{< /notice >}}

- For a `ytt` package, generating a schema is as simple as;

{{< tabs "pkg-schema-ytt" >}}

{{< tab "Linux" >}}

```bash
# (You don't need to run this for this tutorial)
# NOTE: We place the output from this into a temporary file, as we will use it later.
ytt \
  --file "${ROOT_DIR}/packages/${PACKAGE_NAME}/${PACKAGE_VERSION}/bundle/ytt/schema.yaml" \
  --data-values-schema-inspect \
  --output openapi-v3 \
  > "${ROOT_DIR}/packages/${PACKAGE_NAME}/${PACKAGE_VERSION}/schema/openapi.yaml"
```

{{< /tab >}}

{{< /tabs >}}

For a Helm chart however...

- Is it a Bitnami Helm Chart?

{{< tabs "pkg-schema-helm-bitnami" >}}

{{< tab "Linux" >}}

```bash
# YES: -> Then try the Bitnami schema generator tool.
# https://github.com/bitnami-labs/readme-generator-for-helm
```

{{< /tab >}}

{{< /tabs >}}

- Is it a generic Helm chart? (This tutorial is a generic Helm chart)

{{< tabs "pkg-schema-helm-generic" >}}

{{< tab "Linux" >}}

```bash
# YES: -> Try the Helm schema plugin
# NOTE: You need the plugin, yq and sed available for this to work.

# Part 1. Generate the schema from the Helm chart
helm plugin install https://github.com/karuppiah7890/helm-schema-gen.git
helm schema-gen \
  "${ROOT_DIR}/packages/${PACKAGE_NAME}/${PACKAGE_VERSION}/bundle/vendor/helm/values.yaml" \
| \
yq \
  --input-format yaml \
  --output-format yaml \
  --prettyPrint \
| \
tail -n +3 \
| \
yq \
  --input-format yaml \
  --output-format yaml \
  --prettyPrint \
| \
sed 's|^|      |g' \
> "${ROOT_DIR}/packages/${PACKAGE_NAME}/${PACKAGE_VERSION}/schema/helm.yaml"

# Part 2. Create the OpenAPI schema from the Helm schema
cat <<- _EOF_ > "${ROOT_DIR}/packages/${PACKAGE_NAME}/${PACKAGE_VERSION}/schema/openapi.yaml"
openapi: 3.0.0
info:
  version: ${PACKAGE_VERSION}
  title: Schema for ${PACKAGE_NAME} ${PACKAGE_VERSION}
paths: {}
components:
  schemas:
    dataValues:
$(cat "${ROOT_DIR}/packages/${PACKAGE_NAME}/${PACKAGE_VERSION}/schema/helm.yaml")
_EOF_
```

{{< /tab >}}

{{< /tabs >}}

- No matter which option you have performed, you should always manually validate the schema looks correct before continuing as this process can be quite fragile.

{{< tabs "pkg-check" >}}

{{< tab "Linux" >}}

```bash
# Look at schema.dataValues.properties ...
yq \
  --input-format yaml \
  --output-format yaml \
  --prettyPrint \
  "${ROOT_DIR}/packages/${PACKAGE_NAME}/${PACKAGE_VERSION}/schema/openapi.yaml"
```

{{< /tab >}}

{{< /tabs >}}

- Create a template for the `Package` object next. This is used later to generate the package resource for the `Repository`.

{{< tabs "pkg-package-ytt" >}}

{{< tab "Linux" >}}

```bash
# This step varies wildly per-package. This is an example for this tutorial.
# When creating real packages, this file is usually created once, and lasts for the lifetime of the package.
cat <<- _EOF_ > "${ROOT_DIR}/packages/${PACKAGE_NAME}/${PACKAGE_VERSION}/templates/Package.yaml"
#@ load("@ytt:data", "data")
#@ load("@ytt:yaml", "yaml")

---
apiVersion: data.packaging.carvel.dev/v1alpha1
kind: Package
metadata:
  name: #@ "${PACKAGE_NAME}.${PACKAGE_FQN}." + data.values.version
  namespace: ${PACKAGE_NAMESPACE}
spec:
  refName: ${PACKAGE_NAME}.${PACKAGE_FQN}
  version: #@ data.values.version
  releaseNotes: |
    ${PACKAGE_RELEASE_NOTES}
  capacityRequirementsDescription: "RAM: 1GB CPU: 1"
  licenses:
    - "Unlicense"
  valuesSchema:
    openAPIv3: #@ yaml.decode(data.values.openapi)["components"]["schemas"]["dataValues"]
  template:
    spec:

      fetch:

        - imgpkgBundle:
            image: #@ "${OCI_REGISTRY}/${OCI_PROJECT}/packages/${PACKAGE_NAME}:" + data.values.version

      template:

        - helmTemplate:
            path: "vendor/helm"
            name: ${PACKAGE_NAME}
            namespace: ${DEPLOY_NAMESPACE}
            valuesFrom:
              - secretRef:
                name: ${PACKAGE_NAME}-values

        - ytt:
            paths:
              - "-"
              - "ytt"

        - kbld:
            paths:
              - "kbld/Config.yaml"
              - "-"
              - ".imgpkg/images.yml"

      deploy:

        - kapp: {}

_EOF_
```

{{< /tab >}}

{{< /tabs >}}

Ok, now take a break to digest what happened, there was a lot going on this section!
