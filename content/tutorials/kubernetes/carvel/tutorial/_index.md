---
title: "Tutorial"
date: 2021-03-01T00:00:00+00:00
icon: "fa-solid fa-box"
description: "A tutorial on creating a Carvel package"
type: "docs"
weight: 3400
draft: true
---

## Overview

For those new to carvel packaging, this is an example walk through taking you through the manual steps for the creation of a _Carvel Package_ "the hard way".

It is assumed that the reader has already an understanding of Kubernetes concepts and has completed the example [Katacoda](https://katacoda.com/carvel/scenarios/kapp-controller-package-management) course from VMware prior to following this.

## Instructions

<details>
  <summary>Prepare</summary>

### Prepare

There are a few pre-requisites for this walkthrough.

- [x] Have a working [Kind](./kind.md) development environment (Or alternative cluster with permissions to deploy)
- [x] Have all the [carvel](https://carvel.dev) tools locally available
- [x] Optionally have the [tanzu](https://docs.vmware.com/en/VMware-Tanzu-Kubernetes-Grid/1.6/vmware-tanzu-kubernetes-grid-16/GUID-install-cli.html) cli installed locally

### Steps

- Checkout this git repo and create a local working branch

```bash
REPO_URL="github.com/salt-labs"
REPO_NAME="tanzu-kapps"

git clone "${REPO_URL}" "${REPO_NAME}"
cd "${REPO_NAME}"

git checkout -b feat/my-first-package

# Take a copy of the templates for your local use.
# NOTE: .config/custom is included in .gitignore.
cp -r .config/template .config/custom
```

</details>

<details>
  <summary>Package Author</summary>

### Package Author

Play the part of the `Package Author` persona.

This section goes through an example process one might take in order to package an application ready for localised testing. The process will vary based on the type of package being created and how you will customise it, but the general process is the same.

The sample application used in this process is called 'pacman'. _I wonder what it does? Let's find out!_

<details>
  <summary>Define Variables</summary>

In order to make it easier to work through, define all your variables upfront. These are all relative to the _root_ folder of the git repository.

_Note that all commands from this point will use these so choose carefully._

```bash
# Define the name for the top level folder that holds all packages and repos.
ROOT_DIR="kapps"

# What is the name of the repository where this package will be stored?
REPOSITORY_NAME="local"

# What is the name of your package?
PACKAGE_NAME="pacman-carvel-test-${USER}"

# What is the namespace where your packages and repositories are managed from?
PACKAGE_NAMESPACE="kapps"

# Where will your application be deployed into inside the cluster?
DEPLOY_NAMESPACE="pacman-carvel-test"

# What is the FQN your package will use?
PACKAGE_FQN="saltlabs.tech"

# What is the version number of the package you are creating?
PACKAGE_VERSION="0.0.1"

# What is a good description of your package (short)
PACKAGE_DESC_SHORT="chomp chomp"

# How do you want your package name displayed in UIs?
PACKAGE_DISPLAY="Pacman"

# What is a good description of your package (long)
PACKAGE_DESC_LONG="Mission critical application."

# What is a TLDR change description for this package version?
PACKAGE_RELEASE_NOTES="Fixed a bug with the widget collector."

# Package Author name
PACKAGE_AUTHOR="MAHDTech"

# Package Author email
PACKAGE_AUTHOR_EMAIL="MAHDTech@saltlabs.tech"

# Package Author website
PACKAGE_WEBSITE="https://saltlabs.tech"

# What is the version of the repository you will be creating?
REPOSITORY_VERSION="$(date +%Y-%m-%d)"

# Where is the container registry you will be using?
OCI_REGISTRY="ghcr.io"

# What is the name of the Project/Org within the image registry
# Different registries call this different things, but it will be the suffix after the registry.
OCI_PROJECT="salt-labs"
```

</details>

<details>
  <summary>Folder structure</summary>

#### Folder Structure

The first part is to understand and create the required directory structure for the package.

The structure will depend on the repository where the package will ultimately be held.

In this example it is assumed you are creating an empty repository from scratch named 'local'.

- As we are creating a new repository named `local`, we need to create the folder structure first.

```bash
# NOTE: This is the manual way of doing this to understand "how the sausage is made". The CI does this part for you.
mkdir -p ${ROOT_DIR}/repos/${REPOSITORY_NAME}/{.imgpkg,examples,packages}
mkdir -p ${ROOT_DIR}/repos/${REPOSITORY_NAME}/packages/${PACKAGE_NAME}.${PACKAGE_FQN}
touch ${ROOT_DIR}/repos/${REPOSITORY_NAME}/examples/PackageRepository.yaml
touch ${ROOT_DIR}/repos/${REPOSITORY_NAME}/.imgpkg/{bundle,images}.yml
touch ${ROOT_DIR}/repos/${REPOSITORY_NAME}/packages/${PACKAGE_NAME}.${PACKAGE_FQN}/${PACKAGE_VERSION}.yaml

# NOTE: If you were adding a real repository you would instead copy the template.
# The CI is configured to read from this template and generate the repository for you.
cp ${ROOT_DIR}/repos/template.yaml ${ROOT_DIR}/repos/${REPOSITORY_NAME}.yaml
```

- Create the `Package` folder structure and files.

```bash
# NOTE: Outside of This has been automated with the `tt` utility but is here for you to understand the inner-workings.

# Create the empty folder structure for the package.
mkdir -p \
    ${ROOT_DIR}/packages/${PACKAGE_NAME}/${PACKAGE_VERSION}/{bundle,examples,test,templates} \
    ${ROOT_DIR}/packages/${PACKAGE_NAME}/${PACKAGE_VERSION}/bundle/{.imgpkg,vendor,ytt} \
    ${ROOT_DIR}/packages/${PACKAGE_NAME}/${PACKAGE_VERSION}/bundle/ytt/overlays \
    ${ROOT_DIR}/packages/${PACKAGE_NAME}/${PACKAGE_VERSION}/schema

# Create the empty folder structure for the repository

# Create empty files which will be populated later by the various tools.
# NOTE: It's annoying, but some of the tools require .yml and some require .yaml
touch \
    ${ROOT_DIR}/packages/${PACKAGE_NAME}/metadata.yaml \
    ${ROOT_DIR}/packages/${PACKAGE_NAME}/${PACKAGE_VERSION}/examples/{PackageInstall,Secret}.yaml \
    ${ROOT_DIR}/packages/${PACKAGE_NAME}/${PACKAGE_VERSION}/README.md \
    ${ROOT_DIR}/packages/${PACKAGE_NAME}/${PACKAGE_VERSION}/templates/package.yaml \
    ${ROOT_DIR}/packages/${PACKAGE_NAME}/${PACKAGE_VERSION}/{kbld,package}.yaml \
    ${ROOT_DIR}/packages/${PACKAGE_NAME}/${PACKAGE_VERSION}/bundle/{vendir,vendir.lock}.yaml \
    ${ROOT_DIR}/packages/${PACKAGE_NAME}/${PACKAGE_VERSION}/bundle/.imgpkg/{bundle,images}.yml \
    ${ROOT_DIR}/packages/${PACKAGE_NAME}/${PACKAGE_VERSION}/bundle/ytt/{values-schema,values}.yaml \
    ${ROOT_DIR}/packages/${PACKAGE_NAME}/${PACKAGE_VERSION}/schema/{openapi,helm}.yaml
```

- Here is a visual representation of the folder structure we will get to by the end of the process. If you have been following along, yours should look the same but the files are presently empty.

```bash
# Packages
tree -Aa "${ROOT_DIR}/packages"

kapps/packages
└── pacman
    ├── 0.0.1
    │   ├── bundle
    │   │   ├── .imgpkg
    │   │   │   └── images.yml
    │   │   ├── vendir.lock.yaml
    │   │   ├── vendir.yaml
    │   │   ├── vendor
    │   │   └── ytt
    │   │       ├── overlays
    │   │       ├── values-schema.yaml
    │   │       └── values.yaml
    │   ├── examples
    │   │   ├── PackageInstall.yaml
    │   │   └── Secret.yaml
    │   ├── kbld.yaml
    │   ├── package.yaml
    │   ├── README.md
    │   ├── schema
    │   │   ├── helm.yaml
    │   │   └── openapi.yaml
    │   ├── templates
    │   │   └── package.yaml
    │   └── test
    └── metadata.yaml

# Repositories
tree -Aa "${ROOT_DIR}/repos"

kapps/repos
├── local
│   ├── examples
│   │   └── PackageRepository.yaml
│   ├── .imgpkg
│   │   └── images.yml
│   └── packages
│       └── pacman.saltlabs.tech
│           └── 0.0.1.yaml
├── local.yaml
└── template.yaml
```

- For more information about the folder structure, see [folders](./folders.md).

</details>

<details>
  <summary>vendir</summary>

#### vendir

Now it's time to configure where `vendir` will pull the upstream content from.

For further documentation on the `vendir` available options see [carvel.dev/vendir](https://carvel.dev/vendir/docs/develop/).

- Create the `vendir` configuration file that we will use.

```bash
cat <<- _EOF_ > "${ROOT_DIR}/packages/${PACKAGE_NAME}/${PACKAGE_VERSION}/bundle/vendir.yaml"
---
apiVersion: vendir.k14s.io/v1alpha1
kind: Config
minimumRequiredVersion: 0.30.0
directories:
  - path: vendor
    contents:
      - path: helm
        helmChart:
          name: pacman
          version: "0.1.7"
          repository:
            url: https://shuguet.github.io/pacman/
          helmVersion: ""
_EOF_

cat <<- _EOF_ > "${ROOT_DIR}/packages/${PACKAGE_NAME}/${PACKAGE_VERSION}/bundle/vendir.lock.yaml"
# This file is generated automatically by vendir and will be updated with resolved image references by kbld later.
_EOF_
```

- Execute `vendir` to pull down the upstream content unmodified and place it into the `vendor` folder.

```bash
vendir sync \
  --file "vendir.yaml" \
  --lock-file "vendir.lock.yaml" \
  --chdir "${ROOT_DIR}/packages/${PACKAGE_NAME}/${PACKAGE_VERSION}/bundle"

# Take a look at the upstream content you just downloaded.
tree -a "${ROOT_DIR}/packages/${PACKAGE_NAME}/${PACKAGE_VERSION}/bundle/vendor"
```

</details>

<details>
  <summary>Data Values vs Overlays</summary>

---

👍**TIP:** Data Values and Overlays are important to learn.

One of the most powerful features of the Carvel toolchain is the ability to extend upstream content using overlays.

Combining the best of Helm and Kustomize, Carvel offers both Data Values and Overlays.

Rather than forking upstream Helm charts and having to maintain, we can overlay only small changes that might be required.

When compared to Kustomize overlays, Carvel overlays also offer additional flexibility.

---

Once you have obtained your unmodified upstream configuration, the next step is to extend the configuration beyond what the original author has created.

Common usage examples might be to;

- Add Firewall Rules
- Add required annotations
- Lock-down RBAC
- Add or remove certain configuration items that don't suit your environment.

The Carvel toolchain, courtesy of `ytt`, has two ways to achieve this.

1. **Data Values:** Similar to Helm values, these allow you to change common options at install time.
1. **Overlays:** Similar to `kustomize`, these allow you to patch, extend or remove items as required.

For more information on when and how to use each method, you can refer to the [documentation](https://carvel.dev/ytt/docs/develop/data-values-vs-overlays/). There is also a great blog article and video [here](https://carvel.dev/blog/primer-on-ytt-overlays/).

- For this example, let's set a fictional scenario.

  - You have been provided a Helm chart from a third party.
  - Upon inspection, you have found the `namespace` has been **hardcoded** to a value you need to override in your environment.
  - There is no helm value to override the name in the current Helm chart. (we are pretending --namespace doesn't exist)
  - You have no access to the source code to make the changes upstream.

This is obviously a contrived example, and for such a simple issue you would attempt to get a value added to the source upstream, but never the less, it will demonstrate how to use overlays to override a simple `namespace` value.

Let's create a simple `overlay` to allow overriding the `namespace` value.

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

- But how do you know if it works? Let's test...

---

👍**NOTE:** Contrived example

Of course, Helm offers the `--namespace` flag, but this is a contrived example to demonstrate overlays.

This is to show what the package config we configure later is doing for us automatically under the hood.

Kapp will;

- Template with Helm.
- Pass the result through ytt and overlay the default values defined in the package.

---

- First see what a normal "Helm template" would give us.

```bash
helm template ${PACKAGE_NAME} \
    "${ROOT_DIR}/packages/${PACKAGE_NAME}/${PACKAGE_VERSION}/bundle/vendor/helm/" \
    --values "${ROOT_DIR}/packages/${PACKAGE_NAME}/${PACKAGE_VERSION}/bundle/vendor/helm/values.yaml" \
| \
grep "namespace:"
```

- Now, let's see what our overlay does.

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

---

👍**TIP:** Inspecting values

ytt has a handy flag you can use when developing to see if the resulting values are what you expect.

```bash
--data-values-inspect
```

---

</details>

<details>
  <summary>kbld</summary>

#### kbld

A common best practice is to use _immutable_ image references when deploying containerised applications. Often vendors are lazy or immature and provide helm charts and manifests using tags like this;

```yaml
image: mycontainer:latest
```

This is bad practice in several ways, one of which is using a mutable image reference. If the upstream vendor pushes a new image using the same tag, if you were to deploy it again you will get a different result.

Of course, Kubernetes does help us with the `ImagePullPolicy` options, but this is not the final solution.

Instead, we can use an image resolver to lock our supply chain making each deployment predictable.

**Enter `kbld`**

The next step is to resolve and record any image references found by scanning the `vendor` directory.

For further documentation on the kbld available options see [carvel.dev/kbld](https://carvel.dev/kbld/docs/develop/).

- In order for `kbld` to operate, the tool requires a valid yaml configuration file.

```bash
# Generate a basic kbld config file
cat <<- _EOF_ > "${ROOT_DIR}/packages/${PACKAGE_NAME}/${PACKAGE_VERSION}/kbld.yaml"
---
apiVersion: kbld.k14s.io/v1alpha1
kind: Config
minimumRequiredVersion: 0.31.0
searchRules:
  - keyMatcher:
    path:
      - spec
      - images:
        allIndexes: true
  - keyMatcher:
    name: image
    updateStrategy:
      entireValue: {}
_EOF_
```

Now it's time to run `kbld` to resolve the images. For templates such Helm Charts, pass the templated output as input to kbld.

- Here is an example for a Helm chart

```bash
# NOTE: You need to run this for this tutorial.
helm template kbld \
  "${ROOT_DIR}/packages/${PACKAGE_NAME}/${PACKAGE_VERSION}/bundle/vendor/helm" \
| \
kbld \
  --file - \
  --imgpkg-lock-output "${ROOT_DIR}/packages/${PACKAGE_NAME}/${PACKAGE_VERSION}/bundle/.imgpkg/images.yml"
```

- Here is an example if you were using YAML manifests.

```bash
# NOTE: You don't need to run this for this tutorial.
kbld \
  --file "${ROOT_DIR}/packages/${PACKAGE_NAME}/${PACKAGE_VERSION}/bundle/vendor/manifests/" \
  --imgpkg-lock-output "${ROOT_DIR}/packages/${PACKAGE_NAME}/${PACKAGE_VERSION}/bundle/.imgpkg/images.yml"
```

- Now check the images have been resolved successfully.

```bash
cat "${ROOT_DIR}/packages/${PACKAGE_NAME}/${PACKAGE_VERSION}/bundle/.imgpkg/images.yml"
```

Now, you might be asking, What does this mean?

- When the package is built today, 3 weeks from now, or 3 years from now, the result will be the same (so long as the upstream exists at build time)
- If the upstream vendor pushes a new image to the same tag, it will not affect the resulting package (unless you re-run kbld and re-resolve the images)
- You can even reference bundles from bundles, meaning no further network access is required to pull those images for offline support.
- For auditing, you can forever see the supply chain with the contents that made up this version of the package.
- And later we will scan the images for vulnerabilities.

</details>

<details>
  <summary>Custom Resources</summary>

#### Custom Resources

Now you have a `bundle` on the local file system, how to we get it into OCI format into a container registry?

---

👍**TIP:** What's a bundle?

You will learn more about bundles in the `imgpkg` section later, but for now think of a bundle as _"one or more container images and a metadata file"_.

---

This is where we create the custom resources so the package can be used.

- Create the `PackageMetadata` object first.

```bash
cat <<- _EOF_ > "${ROOT_DIR}/packages/${PACKAGE_NAME}/metadata.yaml"
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

**Question:** Wait, now hold up. What is this `PackageMetadata` object and all this about?

**Answer:** This is a custom resource that is used by the `kapp-controller` to manage packages. It is a way to store metadata about the package, such as the name, description, and categories. For linux users, a good analogy is thinking of it like `apt` in debian based distros. First you `apt update` the metadata to see what packages are available in the repository, then you `apt install` the package you want. A similar model is used with carvel.

- Now let's generate the OpenAPI schema from the values. When writing schemas, the [cheatsheet](https://carvel.dev/ytt/docs/develop/schema-validations-cheat-sheet/) is your friend. **Bookmark it.**

---

⚠️ **HERE BE DRAGONS**

This is an amazing capability of carvel to validate schemas before installing packages, but it is not without it's challenges.

There is not one single method to create Kubernetes applications, but several...

There _is_ however one format the schema is required in, **OpenAPI v3+**.

This may take more or less effort based on the upstream sources you have been handed.

---

**IMPORTANT:** For this tutorial, you only need to follow the _"generic helm"_ option. The others are provided for reference about possible options you might encounter as a package author.

- For a `ytt` package, generating a schema is as simple as;

```bash
# (You don't need to run this for this tutorial)
# NOTE: We place the output from this into a temporary file, as we will use it later.
ytt \
  --file "${ROOT_DIR}/packages/${PACKAGE_NAME}/${PACKAGE_VERSION}/bundle/ytt/values-schema.yaml" \
  --data-values-schema-inspect \
  --output openapi-v3 \
  > "${ROOT_DIR}/packages/${PACKAGE_NAME}/${PACKAGE_VERSION}/schema/openapi.yaml"
```

For a Helm chart however...

- Is it a Bitnami Helm Chart?

```bash
# YES: -> Try the Bitnami schema generator tool.
# TODO: Add Bitnami schema example to tutorial here...
```

- Is it a generic Helm chart? (This tutorial is a generic Helm chart)

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

- No matter which option you have performed, you should always manually validate the schema looks correct before continuing as this process can be quite fragile.

```bash
# Look at schema.dataValues.properties ...
yq \
  --input-format yaml \
  --output-format yaml \
  --prettyPrint \
  "${ROOT_DIR}/packages/${PACKAGE_NAME}/${PACKAGE_VERSION}/schema/openapi.yaml"
```

- Create a template for the `Package` object next. This is used later to generate the package metadata for the `Repository`.

```bash
# This step varies wildly per-package. This is an example for this tutorial.
# When creating real packages, this file is usually created once, and lasts for the lifetime of the package.
cat <<- _EOF_ > "${ROOT_DIR}/packages/${PACKAGE_NAME}/${PACKAGE_VERSION}/templates/package.yaml"
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
              - "ytt/overlays"
              - "ytt/schema.yaml"
              - "ytt/values.yaml"
        - kbld:
            paths:
              - "-"
              - ".imgpkg/images.yml"
      deploy:
        - kapp: {}
_EOF_
```

</details>

<details>
  <summary>imgpkg</summary>

#### imgpkg

Now it's time to push the imgpkg bundle that you have created locally to the image registry as an OCI compatible image.

For further documentation on the imgpkg available options see [carvel.dev/imgpkg](https://carvel.dev/imgpkg/docs/develop/).

- Define metadata about the bundle

```bash
cat <<- _EOF_ > "${ROOT_DIR}/packages/${PACKAGE_NAME}/${PACKAGE_VERSION}/bundle/.imgpkg/bundle.yml"
---
apiVersion: imgpkg.carvel.dev/v1alpha1
kind: Bundle
metadata:
  name: ${PACKAGE_NAME}
authors:
  - name: ${PACKAGE_AUTHOR}
    email: ${PACKAGE_AUTHOR_EMAIL}
websites:
  - url: ${PACKAGE_WEBSITE}
_EOF_
```

- Push the imgpkg bundle to your image registry.

```bash
imgpkg push  \
  --file "${ROOT_DIR}/packages/${PACKAGE_NAME}/${PACKAGE_VERSION}/bundle/" \
  --bundle ${OCI_REGISTRY}/${OCI_PROJECT}/packages/${PACKAGE_NAME}:${PACKAGE_VERSION} \
  --lock-output "${ROOT_DIR}/packages/${PACKAGE_NAME}/${PACKAGE_VERSION}/bundle/.imgpkg/images.yml" \
  --registry-ca-cert-path "${HOME}/.docker/certs.d/${OCI_REGISTRY}/ca.crt"
```

- **OPTIONAL:** Load up the Image Registry Web UI and take a look at the package you have just created.

```bash
open https://{OCI_REGISTRY}
```

- 🥳 **Congratulations**, the individual package is now ready! 🥳

</details>

<details>
  <summary>Repository</summary>

#### Create Repository

Now that the package is ready, it's time to update the repository with the new metadata. This is how you manage _many_ packages at scale.

This process is made much easier with the CI configuration, but the following is a learning exercise to understand what happens under the hood.

```bash
# Use YTT to template the file we made previously.
ytt \
  --file "${ROOT_DIR}/packages/${PACKAGE_NAME}/${PACKAGE_VERSION}/templates/package.yaml" \
  --data-value version="${PACKAGE_VERSION}" \
  --data-value-file openapi="${ROOT_DIR}/packages/${PACKAGE_NAME}/${PACKAGE_VERSION}/schema/openapi.yaml" \
  > ${ROOT_DIR}/repos/${REPOSITORY_NAME}/packages/${PACKAGE_NAME}.${PACKAGE_FQN}/${PACKAGE_VERSION}.yaml

# Take a copy of the package metadata to add the package to your repository.
# The metadata is how the repository knows what packages are contained within.
cp -f \
  "${ROOT_DIR}/packages/${PACKAGE_NAME}/metadata.yaml" \
  "${ROOT_DIR}/repos/${REPOSITORY_NAME}/packages/${PACKAGE_NAME}.${PACKAGE_FQN}/"
```

- Run `kbld` again, this time to resolve the image references for the repository.

```bash
# Resolve the images by;
#   - Connecting to the image registry
#   - Writing the checksums to a lock file.
# This 'locks' the supply chain of this version of the repo.
kbld \
  --file ${ROOT_DIR}/repos/${REPOSITORY_NAME}/packages \
  --imgpkg-lock-output ${ROOT_DIR}/repos/${REPOSITORY_NAME}/.imgpkg/images.yml \
  --registry-ca-cert-path "${HOME}/.docker/certs.d/${OCI_REGISTRY}/ca.crt"
```

- Define metadata about the bundle

```bash
cat <<- _EOF_ > "${ROOT_DIR}/repos/${REPOSITORY_NAME}/.imgpkg/bundle.yml"
---
apiVersion: imgpkg.carvel.dev/v1alpha1
kind: Bundle
metadata:
  name: ${REPOSITORY_NAME}
authors:
  - name: ${PACKAGE_AUTHOR}
    email: ${PACKAGE_AUTHOR_EMAIL}
websites:
  - url: ${PACKAGE_WEBSITE}
_EOF_
```

```bash
# Push the Repository to your container registry as an imgpkg bundle.
imgpkg push \
  --file "${ROOT_DIR}/repos/${REPOSITORY_NAME}" \
  --bundle ${OCI_REGISTRY}/${OCI_PROJECT}/repos/${REPOSITORY_NAME}:${REPOSITORY_VERSION} \
  --lock-output "${ROOT_DIR}/repos/${REPOSITORY_NAME}/.imgpkg/images.yml" \
  --registry-ca-cert-path "${HOME}/.docker/certs.d/${OCI_REGISTRY}/ca.crt"
```

- Create the samples to be used by _"Package Consumers"_.

```bash
# If you're using kind, make sure you have credentials in your cluster
# to access the package and repo you just created.
kubectl create namespace ${PACKAGE_NAMESPACE}
kubectl create secret docker-registry \
  registry-creds \
    --from-file=.dockerconfigjson=${HOME}/.docker/config.json \
    --namespace=${PACKAGE_NAMESPACE}

# Create the Repository metadata and export the Secret so it's available to the kapp-controller.
cat <<- _EOF_ > "${ROOT_DIR}/repos/${REPOSITORY_NAME}/examples/PackageRepository.yaml"
---
apiVersion: packaging.carvel.dev/v1alpha1
kind: PackageRepository
metadata:
  name: ${REPOSITORY_NAME}
  namespace: ${PACKAGE_NAMESPACE}
spec:
  #! When working locally, you can set this to a much shorter value for quickly testing changes.
  syncPeriod: 6h
  fetch:
    imgpkgBundle:
      image: ${OCI_REGISTRY}/${OCI_PROJECT}/repos/${REPOSITORY_NAME}:${REPOSITORY_VERSION}
---
#! This requires the secret gen controller installed.
apiVersion: secretgen.carvel.dev/v1alpha1
kind: SecretExport
metadata:
  name: registry-creds
  namespace: ${PACKAGE_NAMESPACE}
spec:
  toNamespaces:
    - "${PACKAGE_NAMESPACE}"
    - "*" #! TODO: Lockdown permissions.
_EOF_
```

</details>

<!--
TODO: Complete the review of the following steps from here down
-->

<details>
  <summary>kapp-controller</summary>

Clusters deployed in production will have the `kapp-controller` pre-installed as part of the SKU.

To see how the underlying system works, or to test locally, here are the steps to install the `kapp-controller` manually into your cluster and grant the necessary permissions.

In order for the `kapp-controller` to be able to install packages in your cluster, we need need to grant access with a service account.

- Create the Service Account and Role Based Access Controls for Kapp Controller.

```bash
# Render the YTT template using your defined values and apply to the cluster.
ytt \
  --file .config/custom/ytt/kapp-controller/RBAC.yaml \
  --data-value name="${PACKAGE_NAMESPACE}" \
  --data-value namespace="${PACKAGE_NAMESPACE}" \
| \
kubectl apply -f -
```

- Install the `kapp-controller` into your cluster.

```bash
kapp deploy \
  --app kapp-controller \
  --file https://github.com/vmware-tanzu/carvel-kapp-controller/releases/latest/download/release.yml
```

</details>

<details>
  <summary>DNS</summary>

**NOTE:** This section is only if you are running a local container registry in `kind` and need to do some DNS trickery to make it work.

- Review and apply DNS configuration for the environment.

```bash
# Verify the harbor rewrite matches your settings and DNS looks correct if you have made any adjustments outside of the defaults.
code .config/custom/manifests/coredns/ConfigMap.yaml

kubectl apply -f .config/custom/manifests/coredns/ConfigMap.yaml
```

- _Wait 30s for CoreDNS to apply the_ `ConfigMap` or run the optional verification step below.

```bash
# OPTIONAL: Verification step

# Run the DNS Tools Pod
kubectl run \
  -it \
  --rm \
  --restart=Never \
  --image=docker.io/infoblox/dnstools:latest \
  --namespace default \
  dnstools

# Ensure these both resolve to the same IP before exiting the pod.
nslookup harbor.cluster.local
nslookup harbor-core.harbor.svc.cluster.local

# Exit and terminate the Pod
exit
```

</details>

</details>

<details>
  <summary>Package Consumer</summary>

### Package Consumer

Play the part of the `Package Consumer` persona.

This section will take the repository and package you created previously and install it into your local cluster allowing you an opportunity to test it out.

<details>
  <summary>Repository</summary>

#### Install Repository

In order for `kapp-controller` to be able to find the package, the package metadata needs to be available within the cluster. Once the metadata is available, you can then `PackageInstall` your package.

- But first, the `kapp-controller` needs to trust the certificate that the container registry presents. As we are developing locally, you can update the kapp-controller `Secret` to ignore this for now. (or you can add the cert chain from Harbor if you wish).

```bash
# Apply the secret to the environment and rollout a new deployment using the modified configuration.
kubectl apply -f .config/custom/manifests/kapp-controller/Secret.yaml

kubectl rollout restart -n kapp-controller deployment/kapp-controller

# NOTE: You may be required to terminate the old kapp-controller manually due a port allocation error. Check if the new Pod is stuck 'Pending'
kubectl get pod -n kapp-controller

# If the new Pod is stuck pending, just terminate them to kick it into gear.
kubectl delete -n kapp-controller $(kubectl get pod -n kapp-controller --selector app=kapp-controller -o name)
```

- Install the `PackageRepository` resource into your cluster.

```base
kapp deploy \
  --app ${REPOSITORY_NAME} \
  --file "${ROOT_DIR}/repos/${REPOSITORY_NAME}/examples/PackageRepository.yaml" \
  --yes

kubectl get PackageMetadata -n ${PACKAGE_NAMESPACE}

kubectl get Packages -n ${PACKAGE_NAMESPACE}
```

- [x] Make sure the repository is in the state `Reconcile Succeeded` before proceeding.

```bash
kubectl get PackageRepository -n ${PACKAGE_NAMESPACE} -w
```

</details>

<details>
  <summary>Package Installation</summary>

#### Package Installation

Now that the package is available, it's _finally_ time to actually install it!

- Applications are managed by storing the configuration in source control. This is managed by a minimum of two resources, a `PackageInstall` and a `Secret`.

- _These will need to be included with every created package as user examples for installation. You can see the examples below which you can `kubectl apply` for testing locally._

- Create the `PackageInstall` resource.

```bash
cat <<- _EOF_ > ${ROOT_DIR}/packages/${PACKAGE_NAME}/${PACKAGE_VERSION}/examples/PackageInstall.yaml
---
apiVersion: packaging.carvel.dev/v1alpha1
kind: PackageInstall
metadata:
  name: ${PACKAGE_NAME}
  namespace: ${PACKAGE_NAMESPACE}
spec:
  serviceAccountName: ${PACKAGE_NAMESPACE}-sa
  packageRef:
    refName: ${PACKAGE_NAME}.${PACKAGE_FQN}
    versionSelection:
      constraints: ${PACKAGE_VERSION}
  values:
    - secretRef:
        name: ${PACKAGE_NAME}-values
_EOF_
```

- Create a `Secret` which is how the custom values are applied to the package. This is similar to a Helm values file, or the package values you have been using manually from `.config/custom'

```bash
cat <<- _EOF_ > ${ROOT_DIR}/packages/${PACKAGE_NAME}/${PACKAGE_VERSION}/examples/Secret.yaml
---
apiVersion: v1
kind: Secret
metadata:
  name: ${PACKAGE_NAME}-values
  namespace: ${PACKAGE_NAMESPACE}
  annotations:
    tkg.tanzu.vmware.com/tanzu-package: ${PACKAGE_NAME}
stringData:
  values: |
    ---
    replicaCount: 1

    service:
      type: ClusterIP
      port: 80
_EOF_
```

- Apply these resources to your cluster for testing.

```bash
kubectl apply -f "${ROOT_DIR}/packages/${PACKAGE_NAME}/${PACKAGE_VERSION}/examples"
```

- Check the package reconciled successfully

```bash
kubectl get pkgi -n ${PACKAGE_NAMESPACE} -w
```

- Check out the super important application and make sure it's working correctly.

```bash
kubectl get all -n "${DEPLOY_NAMESPACE}"
```

- **Bonus round:** Have a go at exposing the application outside your cluster via the Contour Ingress Controller.

```bash
# HINT: If you get stuck, there is a sample at .config/custom/manifests/pacman/HTTPProxy.yaml to get you started.

# Reminder: DNS needs to work first :)
firefox http://pacman.cluster.local
```

- Congratulations on slaying you're first _Carvel Package_. Now aren't you glad we have a CI and tooling to help for most of this process :)

![Chuffed](./images/meme/chuffed.jpg)

</details>

</details>
