---
title: "Repository"
date: 2021-03-01T00:00:00+00:00
icon: "fa-solid fa-box"
description: "Carvel repository custom resource"
type: "docs"
weight: 3508
draft: false
---

_But wait, there's more..._

Rather than manage the packages individually, there is another custom resource to know about.

The `Repository` custom resource is a way to group packages together.

Now that the individual package is ready and published, it's time to update the repository with the new metadata.

_This is how you manage many packages at scale._

This process is made much easier with the CI configuration, but the following is a learning exercise to understand what happens under the hood.

{{< tabs "pkgr-file" >}}

{{< tab "Linux" >}}

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

{{< /tab >}}

{{< /tabs >}}

- Run `kbld` again, this time to resolve the image references for the repository.

{{< tabs "pkgr-kbld" >}}

{{< tab "Linux" >}}

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

{{< /tab >}}

{{< /tabs >}}

- Define metadata about the imgpkg `bundle`

{{< tabs "pkgr-bundle" >}}

{{< tab "Linux" >}}

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

{{< /tab >}}

{{< /tabs >}}

- Ship it!

{{< tabs "pkgr-push" >}}

{{< tab "Linux" >}}

```bash
# Push the Repository to your container registry as an imgpkg bundle.
imgpkg push \
  --file "${ROOT_DIR}/repos/${REPOSITORY_NAME}" \
  --bundle ${OCI_REGISTRY}/${OCI_PROJECT}/repos/${REPOSITORY_NAME}:${REPOSITORY_VERSION} \
  --lock-output "${ROOT_DIR}/repos/${REPOSITORY_NAME}/.imgpkg/images.yml" \
  --registry-ca-cert-path "${HOME}/.docker/certs.d/${OCI_REGISTRY}/ca.crt"
```

{{< /tab >}}

{{< /tabs >}}

- Create the samples to be used by _"Package Consumers"_.

{{< tabs "pkgr-samples" >}}

{{< tab "Linux" >}}

```bash
# Make sure you have credentials in your cluster
# to access the package and repo you just created!
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

{{< /tab >}}

{{< /tabs >}}
