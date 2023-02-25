---
title: "Getting Started"
type: 'docs'
weight: 100
bookFlatSection: false
bookCollapseSection: true
bookHidden: false
bookToc: true
bookComments: false
bookSearchExclude: false
---

## Overview

This is a recommended list of reading material and labs for users who are new to _Kubernetes._

The sections are laid out in a defined order, but they can be considered _optional_ based on the users current level of knowledge. The idea is to start where you feel is right based on what you know and what you would like to learn.

Time estimates are included where they are known to give you idea of what to expect before starting the content.

{{< hint info >}}
**NOTE**

This is still a work in progress and will continue to evolve with your help.

An ___OUTCOMES___ box is provided within each section to give you an idea about what you should understand before moving on.

If you have completed the content provided but still feel you haven't achieved the outcome, then please help by finding additional content and submit a pull request.

_Contributions are welcome!_

{{< /hint >}}

## Pre-requisites

The material throughout assumes the reader already has an understanding of _Linux_ and the command line.

If you're coming from a Windows background and looking for a decent introduction to Linux, you might want to check out this free course from [edX](https://edx.org) in your own time.

{{< button href="https://www.edx.org/course/introduction-to-linux" >}}Introduction to Linux (14 weeks){{< /button >}}

## Containers

{{< details "Theory" closed >}}

{{< hint warning >}}
**OUTCOMES**

- [x] Know what a `container` actually is.
- [x] Know what `cgroups` are.
- [x] Know what `namespaces` are.
- [x] Know what a `container runtime` is and common implementations.

{{< /hint >}}

Before you can begin learning and using Kubernetes, you need to first understand containers.

VMware Kubeacademy provides an introductory _Containers 101_ course to get you started.

{{< button href="https://kube.academy/courses/containers-101" >}}Start Course (30 min){{< /button >}}

Kubernetes interfaces with containers through a _container runtime interface_, known as 'CRI' which will be covered in the Kubernetes sections further below.

There are many options when selecting a _container runtime_. Each one comes with it's own pros and cons based on the underlying architecture choices. For a relatively current summary of the main players, check out this comparison document from [capital one](https://capitalone.com).

{{< button href="https://www.capitalone.com/tech/cloud/container-runtime/" >}}Read Document (30 min){{< /button >}}

And if you're specifically looking for resources on Red Hat's `podman`;

{{< button href="https://www.redhat.com/sysadmin/podman-guides-2020" >}}Read posts (1 hr){{< /button >}}

Now that you have read about container runtimes, this visual might be of use to see how they interact with the _Linux kernel_.

{{< button href="/images/cri-oh-my.drawio.png" >}}View diagram{{< /button >}}

{{< /details >}}

{{< details "Practical" closed >}}

{{< hint warning >}}
**OUTCOMES**

- [x] Know what a `Dockerfile` is and how to create one.
- [x] Know how to build and tag an `OCI image` with at least one tool such as `docker` or `podman`.
- [x] Know how to `run` and `exec` into containers and capture logs for troubleshooting.
- [x] Know what a `Container Registry` is and how to push and pull images.

{{< /hint >}}

So now you know what a `container` is, how do you create one?

If you haven't already created a container whilst following along in the previous section, try it out.

There are a number of tutorials available in this space, here are some examples from [Katacoda](https://katacoda.com/). Note that there is some overlap between the scenarios, it's up to the individual to choose how to spend their time.

{{< button href="https://www.katacoda.com/courses/container-runtimes" >}}Start scenario (3 hr){{< /button >}}

For `Docker` specifically,

{{< button href="https://www.katacoda.com/courses/docker" >}}Start scenario (1 hr){{< /button >}}

For `Podman/Buildah/Skopeo`,

{{< button href="https://www.katacoda.com/courses/containers-without-docker/" >}}Start scenario (1 hr){{< /button >}}

And for the more adventurous, ensure you create a container directly using `runc` to see what's really under the hood. 😲
{{< /details >}}

## Cloud Native

{{< details "Theory" closed >}}

{{< hint warning >}}
**OUTCOMES**

- [x] Know what _Cloud Infrastructure_ is
- [x] Know what _Cloud Native_ is and how it is different from _Cloud Infrastructure_
- [x] Know what it takes to become a _Cloud Native Engineer_

{{< /hint >}}

Although learning _Cloud Infrastructure_ is outside the scope of this _getting started with Kubernetes_ material you should have an idea of;

- Cloud vs Cloud Native

{{< button href="../../../frameworks/#cloud-vs-cloud-native" >}}Watch video (1 min){{< /button >}}

- Cloud Native Concepts

{{< button href="../../../frameworks/#concepts" >}}Read posts (1 hr){{< /button >}}

- VMware has a course available to answer frequently asked questions.

{{< button href="https://kube.academy/courses/frequently-asked-questions" >}}Start course (1hr 30min){{< /button >}}

{{< /details >}}

{{< details "Practical" closed >}}

{{< hint warning >}}
**OUTCOMES**

- [x] Know how to use the environment _where_ you are deploying Kubernetes to.

{{< /hint >}}

There is no prescribed journey to learning about Cloud Infrastructure, this is entirely dependant on the vendor selected and their technology stack.

Kubernetes is _Cloud Agnostic_, meaning you can run it on any Public, Private or Hybrid Cloud. Each provider has it's own set of tools and techniques to get you started.

The only expectation is that you need to know about the environment where you are _deploying_ Kubernetes to.

Some examples of vendor specific training resources can be found in the following links.

- [AWS Training](https://www.aws.training/)
- [Azure Training](https://docs.microsoft.com/en-us/learn/azure/)
- [Google Cloud Training](https://cloud.google.com/training)
- [IBM Cloud](https://www.ibm.com/training/cloud)
- [OpenStack Training](https://www.openstack.org/marketplace/training/)
- [VMware Training](https://www.vmware.com/learning.html)
- [A Cloud Guru](https://acloudguru.com/)

You might also want to check out what it takes to be a _Cloud Native Engineer_, particularly as the industry continues to move towards that dream of a Cloud Agnostic future.

{{< button href="../../cne/" >}}Cloud Native Engineer (♾ infinity hrs)
{{< /button >}}

If none of the above makes sense, or you are completely new to the use of cloud technologies, you might want to check out this free introductory course from [edX](https://edx.org) in your own time.

{{< button href="https://www.edx.org/course/introduction-to-cloud-infrastructure-technologies" >}}Start Course (14 weeks){{< /button >}}

{{< /details >}}

## Kubernetes

{{< details "Theory" closed >}}

{{< hint warning >}}
**OUTCOMES**

- [x] Know what _Kubernetes_ is
- [x] Know why _Kubernetes_ is useful
- [x] Know some of the history to understand why _Kubernetes_ has become the defacto standard.
- [x] Know the difference between _declarative_ and _imperative_.
- [x] Know what _12 Factor Appplications_ are.
- [x] Know what _Promise Theory_ is.
- [x] Know what _Graph Theory_ is.
- [x] Know what _Control Loops_ are.

{{< /hint >}}

### What is it?

So what exactly is _Kubernetes_ and why do we want it?

- The business case for Kubernetes.

{{< button href="https://kube.academy/courses/the-business-case-for-kubernetes" >}}Start Course (30 min){{< /button >}}

### History

Where did Kubernetes come from?

- The Kubernetes Documentary

{{< button href="https://www.youtube.com/watch?v=BE77h7dmoQU" >}}Part 1 (25 min){{< /button >}}

<br/>
<br/>

{{< button href="https://www.youtube.com/watch?v=318elIq37PE" >}}Part 2 (25 min){{< /button >}}

### What does it do?

If you're after a quick run through on what the components are and common scenarios, Microsoft has the following videos available.

- How Kubernetes works light board video (6min)
- Common Kubernetes scenarios (4min)

{{< button href="https://azure.microsoft.com/en-us/topic/what-is-kubernetes/#overview" >}}Watch videos (10 min){{< /button >}}

## Concepts

Kubernetes uses a number of concepts which might be foreign if you haven't seem them before.

If you're completely new to Kubernetes, you might want to check out the following resources.

- A summary of _Graph Theory_ concepts.

{{< button href="../../../frameworks/graph-theory" >}}View content (30 min){{< /button >}}

- A summary of _Promise Theory_ concepts.

{{< button href="../../../frameworks/promise-theory" >}}View content (1 hr){{< /button >}}

- A summary of _12 Factor Applications_

{{< button href="../../../frameworks/12factors" >}}View content (1 hr){{< /button >}}

## Demos

Some of the more interesting demos from around the web to give you an idea of the capabilities.

- Kubernetes for Sysadmins

{{< button href="https://www.youtube.com/watch?v=HlAXp0-M6SY&t=1s" >}}Demo (45 min){{< /button >}}

- GitOps with Kubernetes

{{< button href="https://www.youtube.com/watch?v=yIAa5wHsfw4" >}}Demo (30 min){{< /button >}}

- "Hashinetes"

{{< button href="https://www.youtube.com/watch?v=v77FFbQwC6E" >}}Demo (30 min){{< /button >}}

- Building Cloud-native applications with Kubernetes and Istio

{{< button href="https://www.youtube.com/watch?v=6BYq6hNhceI&t=1s" >}}Demo (20 min){{< /button >}}

### Courses

There are a number of courses available on the VMware [KubeAcademy](https://kube.academy/) website arranged here by difficulty level.

#### Beginner

- An introduction to Kubernetes for _Virtual Infrastructure Administrators_.

{{< button href="https://kube.academy/courses/introduction-to-kubernetes-for-the-virtual-infrastructure-administrator" >}}Start Course (45 mins){{< /button >}}

- Start to navigate the Cloud Native ecosystem.

{{< button href="https://kube.academy/courses/getting-started" >}}Start Course (45 min){{< /button >}}

- Kubernetes 101

{{< button href="https://kube.academy/courses/kubernetes-101" >}}Start Course (15 min){{< /button >}}

- Kubernetes Architecture in depth

{{< button href="https://kube.academy/courses/kubernetes-in-depth" >}}Start Course (45 min){{< /button >}}

- Kubernetes Platform Security

{{< button href="https://kube.academy/courses/kubernetes-platform-security" >}}Start Course (1 hr){{< /button >}}

### Intermediate

- Operational considerations for _Virtual Infrastructure_ administrators.

{{< button href="https://kube.academy/courses/operational-considerations-for-virtual-infrastructure-administrators" >}}Start Course (1hr 30min){{< /button >}}

### Advanced

- Networking in Kubernetes

{{< button href="https://kube.academy/courses/networking-in-kubernetes" >}}Start Course (3 hr){{< /button >}}

- The Kubernetes Machine (Component Deep dive)

{{< button href="https://kube.academy/courses/the-kubernetes-machine" >}}Start Course (1 hr){{< /button >}}

- Cluster API

{{< button href="https://kube.academy/courses/cluster-api" >}}Start Course (1 hr 30 min){{< /button >}}

- Introduction to Operators

{{< button href="https://kube.academy/courses/introduction-to-operators" >}}Start Course (1 hr 30 min){{< /button >}}

### More courses

If you're still hungry for more, there is a self-paced introduction workshop from [edX](https://edx/org) you can complete in your own time.

{{< button href="https://www.edx.org/course/introduction-to-kubernetes" >}}Start Course (14 weeks){{< /button >}}

### Certification

If you're keen to get some certifications under your belt, the _[Cloud Native Computing Foundation](https://cncf.io)_ offers the following industry standard certifications;

- [Certified Kubernetes Application Developer (CKAD)](https://www.cncf.io/certification/ckad/)
- [Certified Kubernetes Administrator (CKA)](https://www.cncf.io/certification/cka/)
- [Certified Kubernetes Security Specialist (CKS)](https://www.cncf.io/certification/ckas/)

{{</details >}}

{{< details "Practical" closed >}}

{{< hint warning >}}
**OUTCOMES**

- [x] Be able to pass the _Certified Kubernetes Application Developer_ (CKAD) exam
- [x] Be able to pass the _Certified Kubernetes Administrator_ (CKA) exam

{{< /hint >}}

Ok, so now you know what it is, how do you learn how to use it?

VMware has published relevant Labs for free on [KubeAcademy](https://kube.academy/).

These are a mix of theory and hands on labs rolled into each course.

#### Beginner

- Setup your Developer Workstation

{{< button href="https://kube.academy/courses/building-applications-for-kubernetes" >}}Start Course (1hr 30min){{< /button >}}

- Learn how to create a container and deploy to Kubernetes.

{{< button href="https://kube.academy/courses/interactive-introduction-to-containers-and-kubernetes" >}}Start Course (1hr 30min){{< /button >}}

- Learn how to build an application for Kubernetes

{{< button href="https://kube.academy/courses/building-applications-for-kubernetes" >}}Start Course (1 hr){{< /button >}}

- Get more Hands on time with a Kubernetes Lab.

{{< button href="https://kube.academy/courses/hands-on-with-kubernetes-and-containers" >}}Start Course (30min){{< /button >}}

- Kubernetes Core Concepts (Platform)

{{< button href="https://kube.academy/courses/kubernetes-core-concepts-part-1" >}}Start Course (2hr 30min){{< /button >}}

- Kubernetes Core Concepts (Managing Applications)

{{< button href="https://kube.academy/courses/kubernetes-core-concepts-part-2" >}}Start Course (1hr 30min){{< /button >}}

### Intermediate

- Learn different methods for building container images.

{{< button href="https://kube.academy/courses/building-images" >}}Start Course (1 hr){{< /button >}}

- See different methods for observing applications on Kubernetes

{{< button href="https://kube.academy/courses/introduction-to-observability" >}}Start Course (45 min){{< /button >}}

- Kubernetes Core Concepts (Clusters)

{{< button href="https://kube.academy/courses/kubernetes-core-concepts-part-3" >}}Start Course (1hr 30min){{< /button >}}

- Kubernetes Core Concepts (Additional Application features)

{{< button href="https://kube.academy/courses/kubernetes-core-concepts-part-4" >}}Start Course (1hr 30min){{< /button >}}

- Kubernetes workloads and security

{{< button href="https://kube.academy/courses/kubernetes-core-concepts-part-5" >}}Start Course (1 hr){{< /button >}}

- Interacting with Kubernetes

{{< button href="https://kube.academy/courses/interacting-with-kubernetes" >}}Start Course (15 min){{< /button >}}

- Interacting with Cloud Providers

{{< button href="https://kube.academy/courses/integrating-with-cloud-providers" >}}Start Course (45 min){{< /button >}}

- Cluster Operations with various tools.

{{< button href="https://kube.academy/courses/cluster-operations" >}}Start Course (1 hr){{< /button >}}

- Helm 101

{{< button href="https://kube.academy/courses/helm-101" >}}Start Course (2 hr){{< /button >}}

### Advanced

- How to prepare for the _Certified Kubernetes Administrator_ exam.

{{< button href="https://kube.academy/courses/how-to-prepare-for-the-cka-exam" >}}Start Lab (2 hrs){{< /button >}}

- The _Certified Kubernetes Application Developer_ practice exam.

{{< button href="https://kube.academy/courses/ckad-practice" >}}Start Lab (3 hrs){{< /button >}}

- More _Certified Kubernetes Application Developer_ practice scenarios.

{{< button href="https://www.katacoda.com/liptanbiswas/courses/ckad-practice-challenges" >}}Start Lab (3 hrs){{< /button >}}

- Interactive Scenarios for _Certified Kubernetes Administrator_

{{< button href="https://killercoda.com/killer-shell-cka" >}}Start Lab (3+ hrs){{< /button >}}

**NOTE:** This last one is not free, but is the best exam simulator available.

- Killer CKS, CKA, CKAD exam simulator.

{{< button href="https://killer.sh/" >}}Start Lab (3+ hrs){{< /button >}}

{{< /details >}}
