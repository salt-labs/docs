---
title: "Folder Structure"
date: 2021-03-01T00:00:00+00:00
icon: "fa-solid fa-box"
description: "Anatomy of a Carvel Package"
type: "docs"
weight: 3502
draft: false
---

The first part is to understand and create the required directory structure for the package.

The structure will depend on the repository where the package will ultimately be held.

In this example it is assumed you are creating an empty repository from scratch named from the variable you defined `REPOSITORY_NAME`.

Don't worry too much about understanding the layout early on, we will be filling it out as we go along.

- Create a tutories folder and change into it. This is where we will be working from.

{{< tabs "structure-rootdir" >}}

{{< tab "Linux" >}}

```bash
mkdir tutorial && cd $_
```

{{< /tab >}}

{{< /tabs >}}

- As we are creating a new repository from the variable named `$REPOSITORY_NAME`, we need to create the folder structure first where all the files will be held.

{{< tabs "structure-pkgr" >}}

{{< tab "Linux" >}}

```bash
# NOTE: This is the manual way of doing this to understand "how the sausage is made".
# The CI we have setup does this part for you automatically.
mkdir -p ${ROOT_DIR}/repos/${REPOSITORY_NAME}/{.imgpkg,examples,packages}
mkdir -p ${ROOT_DIR}/repos/${REPOSITORY_NAME}/packages/${PACKAGE_NAME}.${PACKAGE_FQN}
touch ${ROOT_DIR}/repos/${REPOSITORY_NAME}/examples/PackageRepository.yaml
touch ${ROOT_DIR}/repos/${REPOSITORY_NAME}/.imgpkg/{bundle,images}.yml
touch ${ROOT_DIR}/repos/${REPOSITORY_NAME}/packages/${PACKAGE_NAME}.${PACKAGE_FQN}/${PACKAGE_VERSION}.yaml

# NOTE: If you were adding a real repository you would instead copy the template.
# The CI is configured to read from this template and generate the repository for you.
# Example:
# cp ${ROOT_DIR}/repos/template.yaml ${ROOT_DIR}/repos/${REPOSITORY_NAME}.yaml
```

{{< /tab >}}

{{< /tabs >}}

- Create the `Package` folder structure and files.

{{< tabs "structure-pkg" >}}

{{< tab "Linux" >}}

- Create the empty folder structure for the package.

```bash
# NOTE: Outside of this tutorial, this process is automated with tools like `tt` and `kctrl` to initiailse a package.
# But the steps are here for you to understand the inner-workings.

mkdir -p \
    ${ROOT_DIR}/packages/${PACKAGE_NAME}/${PACKAGE_VERSION}/{bundle,examples,test,templates} \
    ${ROOT_DIR}/packages/${PACKAGE_NAME}/${PACKAGE_VERSION}/bundle/{.imgpkg,kbld,vendir,vendor,ytt} \
    ${ROOT_DIR}/packages/${PACKAGE_NAME}/${PACKAGE_VERSION}/bundle/ytt/{config,overlays} \
    ${ROOT_DIR}/packages/${PACKAGE_NAME}/${PACKAGE_VERSION}/schema
```

- Create the empty folder structure for the repository.

```bash
# Create empty files which will be populated later by the various tools.
# NOTE: It's annoying, but some of the tools require .yml and some require .yaml. Just something to be aware of.
touch \
    ${ROOT_DIR}/packages/${PACKAGE_NAME}/metadata.yaml \
    ${ROOT_DIR}/packages/${PACKAGE_NAME}/${PACKAGE_VERSION}/examples/{PackageInstall,Secret}.yaml \
    ${ROOT_DIR}/packages/${PACKAGE_NAME}/${PACKAGE_VERSION}/README.md \
    ${ROOT_DIR}/packages/${PACKAGE_NAME}/${PACKAGE_VERSION}/templates/Package.yaml \
    ${ROOT_DIR}/packages/${PACKAGE_NAME}/${PACKAGE_VERSION}/bundle/kbld/Config.yaml \
    ${ROOT_DIR}/packages/${PACKAGE_NAME}/${PACKAGE_VERSION}/Package.yaml \
    ${ROOT_DIR}/packages/${PACKAGE_NAME}/${PACKAGE_VERSION}/bundle/vendir/{Lock,LockConfig}.yaml \
    ${ROOT_DIR}/packages/${PACKAGE_NAME}/${PACKAGE_VERSION}/bundle/.imgpkg/{bundle,images}.yml \
    ${ROOT_DIR}/packages/${PACKAGE_NAME}/${PACKAGE_VERSION}/bundle/ytt/{schema,defaults}.yaml \
    ${ROOT_DIR}/packages/${PACKAGE_NAME}/${PACKAGE_VERSION}/schema/{openapi,helm}.yaml
```

{{< /tab >}}

{{< /tabs >}}

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
    │   │   ├── kbld
    │   │       └── Config.yaml
    │   │   ├── vendir
    │   │       ├── LockConfig.yaml
    │   │       └── Config.yaml
    │   │   ├── vendor
    │   │   └── ytt
    │   │       ├── config
    │   │       ├── overlays
    │   │       ├── schema.yaml
    │   │       └── defaults.yaml
    │   ├── examples
    │   │   ├── PackageInstall.yaml
    │   │   └── Secret.yaml
    │   ├── Package.yaml
    │   ├── README.md
    │   ├── schema
    │   │   ├── helm.yaml
    │   │   └── openapi.yaml
    │   ├── templates
    │   │   └── Package.yaml
    │   └── test
    └── PackageMetadata.yaml

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
