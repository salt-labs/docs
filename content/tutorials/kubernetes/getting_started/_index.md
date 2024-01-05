---
title: "Getting Started"
date: 2020-10-20T15:00:00+10:00
icon: "fab fa-help"
description: "Getting started with Kubernetes."
type: "docs"
weight: 3201
draft: false
---

## Table of Contents

<!-- TOC -->

- [Table of Contents](#table-of-contents)
- [Overview](#overview)
- [Pre-requisites](#pre-requisites)
- [Containers](#containers)
  - [Containers Theory](#containers-theory)
  - [Containers Practical](#containers-practical)
- [Cloud Native](#cloud-native)
  - [Cloud Native Theory](#cloud-native-theory)
  - [Cloud Native Practical](#cloud-native-practical)
- [Kubernetes](#kubernetes)
  - [Kubernetes Theory](#kubernetes-theory)
    - [What is it?](#what-is-it)
    - [History](#history)
    - [What does it do?](#what-does-it-do)
    - [Concepts](#concepts)
    - [Demos](#demos)
    - [Courses](#courses)
  - [Kubernetes Practical](#kubernetes-practical)
    - [Beginner](#beginner)
    - [Intermediate](#intermediate)
    - [Advanced](#advanced)

<!-- /TOC -->

## Overview

This is a recommended list of reading material and labs for users who are new to _Kubernetes._

The sections are laid out in a defined order, but they can be considered _optional_ based on the users current level of knowledge. The idea is to start where you feel is right based on what you know and what you would like to learn.

Time estimates are included where they are known to give you idea of what to expect before starting the content.

{{< notice warning >}}This document is still a work-in-progress and will continue to evolve with your help. _You're contributions are welcome!_
{{< /notice >}}

{{< notice info >}}An **_OUTCOMES_** box is provided within each section to give you an idea about what you should understand before moving on. If you have completed the content provided but still feel you haven't achieved the outcome, then please help by finding additional content and submit a pull request.
{{< /notice >}}

## Pre-requisites

The material throughout assumes the reader already has an understanding of _Linux_ and the command line.

If you're coming from a Windows background and looking for a decent introduction to Linux, you might want to check out this free course from [edX](https://edx.org) in your own time.

{{< button label="Introduction to Linux (14 weeks)" link="https://www.edx.org/course/introduction-to-linux" >}}
</br>

## Containers

### Containers Theory

{{< collapse "Outcomes" >}}

- [x] Know what a `container` actually is.
- [x] Know what `cgroups` are.
- [x] Know what `namespaces` are.
- [x] Know what a `container runtime` is and common implementations.

{{< /collapse >}}

Before you can begin learning and using Kubernetes, you need to first understand containers.

VMware Kubeacademy provides an introductory _Containers 101_ course to get you started.

{{< button label="Start Course (30 min)" link="https://kube.academy/courses/containers-101" >}}
<br/>

Kubernetes interfaces with containers through a _container runtime interface_, known as 'CRI' which will be covered in the Kubernetes sections further below.

There are many options when selecting a _container runtime_. Each one comes with it's own pros and cons based on the underlying architecture choices. For a relatively current summary of the main players, check out this comparison document from [capital one](https://capitalone.com).

{{< button label="Read Document (30 min)" link="https://www.capitalone.com/tech/cloud/container-runtime/" >}}
<br/>

And if you're specifically looking for resources on Red Hat's `podman`;

{{< button label="Read posts (1 hr)" link="https://www.redhat.com/sysadmin/podman-guides-2020" >}}

Now that you have read about container runtimes, this visual might be of use to see how they interact with the _Linux kernel_.

{{< image src="drawio/cri-oh-my.drawio.png" alt="CRI, oh my!" height="" width="" position="center" command="fill" option="q100" class="img-fluid" title="CRI, oh my!" webp="true" >}}

### Containers Practical

{{< collapse "Outcomes" >}}

- [x] Know what a `Dockerfile` is and how to create one.
- [x] Know how to build and tag an `OCI image` with at least one tool such as `docker` or `podman`.
- [x] Know how to `run` and `exec` into containers and capture logs for troubleshooting.
- [x] Know what a `Container Registry` is and how to push and pull images.

{{< /collapse >}}

So now you know what a `container` is, how do you create one?

If you haven't already created a container whilst following along in the previous section, now is the time to try it out.

There are a number of tutorials available in this space, here are some examples from [Katacoda](https://katacoda.com/). Note that there is some overlap between the scenarios, it's up to the individual to choose how to best spend their time.

- A general course on container runtimes.

{{< button label="Start scenario (3 hr)" link="https://www.katacoda.com/courses/container-runtimes" >}}
</br>

- For `Docker` specifically,

{{< button label="Start scenario (1 hr)" link="https://www.katacoda.com/courses/docker" >}}
</br>

- For `Podman/Buildah/Skopeo`,

{{< button label="Start scenario (1 hr)" link="https://www.katacoda.com/courses/containers-without-docker/" >}}
</br>

And for the more adventurous, ensure you create a container directly using `runc` to see what's really under the hood. 😲

## Cloud Native

### Cloud Native Theory

{{< collapse "Outcomes" >}}

- [x] Know what _Cloud Infrastructure_ is
- [x] Know what _Cloud Native_ is and how it is different from _Cloud Infrastructure_
- [x] Know what it takes to become a _Cloud Native Engineer_

{{< /collapse >}}

Although learning _Cloud Infrastructure_ is outside the scope of this _getting started with Kubernetes_ material you should have an idea of;

- Cloud vs Cloud Native

{{< button label="Watch video (1 min)" link="/frameworks/#cloud-vs-cloud-native" >}}
</br>

- Cloud Native Concepts

{{< button label="Read posts (1 hr)" link="/frameworks/#concepts" >}}
</br>

- VMware also has a course available to answer frequently asked questions.

{{< button label="Start course (1hr 30min)" link="https://kube.academy/courses/frequently-asked-questions" >}}
</br>

### Cloud Native Practical

{{< collapse "Outcomes" >}}

- [x] Know how to use the environment _where_ you are deploying Kubernetes to.

{{< /collapse >}}

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

You might also want to check out what it takes to be a _Cloud Native Engineer_, particularly as the industry continues to move towards that dream of a _Cloud Agnostic_ future.

{{< button label="Cloud Native Engineer (♾ infinity hrs)" link="/tutorials/cne/" >}}
</br>

If none of the above makes sense, or you are completely new to the use of cloud technologies, you might want to check out this free introductory course from [edX](https://edx.org).

{{< button label="Start Course (14 weeks)" link="https://www.edx.org/course/introduction-to-cloud-infrastructure-technologies" >}}</br>

## Kubernetes

### Kubernetes Theory

{{< collapse "Outcomes" >}}

- [x] Know what _Kubernetes_ is
- [x] Know why _Kubernetes_ is useful
- [x] Know some of the history to understand why _Kubernetes_ has become the defacto standard.
- [x] Know the difference between _declarative_ and _imperative_.
- [x] Know what _12 Factor Applications_ are.
- [x] Know what _Promise Theory_ is.
- [x] Know what _Graph Theory_ is.
- [x] Know what _Control Loops_ are.

{{< /collapse >}}

#### What is it?

So what exactly is _Kubernetes_ and why do we want it?

- The business case for Kubernetes.

{{< button label="Start Course (30 min)" link="https://kube.academy/courses/the-business-case-for-kubernetes" >}}
</br>

#### History

Where did Kubernetes come from?

- The Kubernetes Documentary

{{< button label="Part 1 (25 min)" link="https://www.youtube.com/watch?v=BE77h7dmoQU" >}}
<br/>

{{< button label="Part 2 (25 min)" link="https://www.youtube.com/watch?v=318elIq37PE" >}}
<br/>

#### What does it do?

If you're after a quick run through on what the components are and common scenarios, Microsoft has the following videos available on the link below.

- How Kubernetes works light board video (6min)
- Common Kubernetes scenarios (4min)

{{< button label="Watch videos (10 min)" link="https://azure.microsoft.com/en-us/topic/what-is-kubernetes/#overview" >}}
<br/>

#### Concepts

Kubernetes uses a number of concepts which might be foreign if you haven't seem them before.

If you're completely new to Kubernetes, you might want to check out the following resources.

- A summary of _Graph Theory_ concepts.

{{< button label="View content (30 min)" link="/frameworks/graph-theory" >}}
<br/>

- A summary of _Promise Theory_ concepts.

{{< button label="View content (1 hr)" link="/frameworks/promise-theory" >}}
<br/>

- A summary of _12 Factor Applications_

{{< button label="View content (1 hr)" link="/frameworks/12factors" >}}
<br/>

#### Demos

Some of the more interesting demos from around the web to give you an idea of some of the capabilities.

- Kubernetes for Sysadmins

{{< button label="Demo (45 min)" link="https://www.youtube.com/watch?v=HlAXp0-M6SY&t=1s" >}}
<br/>

- GitOps with Kubernetes

{{< button label="Demo (30 min)" link="https://www.youtube.com/watch?v=yIAa5wHsfw4" >}}
<br/>

- "Hashinetes"

{{< button label="Demo (30 min)" link="https://www.youtube.com/watch?v=v77FFbQwC6E" >}}
<br/>

- Building Cloud-native applications with Kubernetes and Istio

{{< button label="Demo (20 min)" link="https://www.youtube.com/watch?v=6BYq6hNhceI&t=1s" >}}
<br/>

#### Courses

There are a number of courses available on the VMware [KubeAcademy](https://kube.academy/) website arranged here by difficulty level.

##### Beginner courses

- An introduction to Kubernetes for _Virtual Infrastructure Administrators_.

{{< button label="Start Course (45 mins)" link="https://kube.academy/courses/introduction-to-kubernetes-for-the-virtual-infrastructure-administrator" >}}
<br/>

- Start to navigate the Cloud Native ecosystem.

{{< button label="Start Course (45 min)" link="https://kube.academy/courses/getting-started" >}}
<br/>

- Kubernetes 101

{{< button label="Start Course (15 min)" link="https://kube.academy/courses/kubernetes-101" >}}
<br/>

- Kubernetes Architecture in depth

{{< button label="Start Course (45 min)" link="https://kube.academy/courses/kubernetes-in-depth" >}}
<br/>

- Kubernetes Platform Security

{{< button label="Start Course (1 hr)" link="https://kube.academy/courses/kubernetes-platform-security" >}}
<br/>

##### Intermediate courses

- Operational considerations for _Virtual Infrastructure_ administrators.

{{< button label="Start Course (1hr 30min)" link="https://kube.academy/courses/operational-considerations-for-virtual-infrastructure-administrators" >}}
<br/>

##### Advanced courses

- Networking in Kubernetes

{{< button label="Start Course (3 hr)" link="https://kube.academy/courses/networking-in-kubernetes" >}}
<br/>

- The Kubernetes Machine (Component Deep dive)

{{< button label="Start Course (1 hr)" link="https://kube.academy/courses/the-kubernetes-machine" >}}
<br/>

- Cluster API

{{< button label="Start Course (1 hr 30 min)" link="https://kube.academy/courses/cluster-api" >}}
<br/>

- Introduction to Operators

{{< button label="Start Course (1 hr 30 min)" link="https://kube.academy/courses/introduction-to-operators" >}}
<br/>

##### More courses

If you're still hungry for more, there is a self-paced introduction workshop from [edX](https://edx/org) you can complete.

{{< button label="Start Course (14 weeks)" link="https://www.edx.org/course/introduction-to-kubernetes" >}}
<br/>

##### Certification

If you're keen to get some certifications under your belt, the _[Cloud Native Computing Foundation](https://cncf.io)_ offers the following industry standard certifications;

- [Certified Kubernetes Application Developer (CKAD)](https://www.cncf.io/certification/ckad/)
- [Certified Kubernetes Administrator (CKA)](https://www.cncf.io/certification/cka/)
- [Certified Kubernetes Security Specialist (CKS)](https://www.cncf.io/certification/ckas/)

### Kubernetes Practical

{{< collapse "Outcomes" >}}

- [x] Be able to pass the _Certified Kubernetes Application Developer_ (CKAD) exam
- [x] Be able to pass the _Certified Kubernetes Administrator_ (CKA) exam

{{< /collapse >}}

Ok, so now you know what it is, how do you learn how to use it?

VMware has published relevant Labs for free on [KubeAcademy](https://kube.academy/).

These are a mix of theory and hands on labs rolled into each course.

#### Beginner

- Setup your Developer Workstation

{{< button label="Start Course (1hr 30min)" link="https://kube.academy/courses/building-applications-for-kubernetes" >}}
<br/>

- Learn how to create a container and deploy to Kubernetes.

{{< button label="Start Course (1hr 30min)" link="https://kube.academy/courses/interactive-introduction-to-containers-and-kubernetes" >}}
<br/>

- Learn how to build an application for Kubernetes

{{< button label="Start Course (1 hr)" link="https://kube.academy/courses/building-applications-for-kubernetes" >}}
<br/>

- Get more Hands on time with a Kubernetes Lab.

{{< button label="Start Course (30min)" link="https://kube.academy/courses/hands-on-with-kubernetes-and-containers" >}}
<br/>

- Kubernetes Core Concepts (Platform)

{{< button label="Start Course (2hr 30min)" link="https://kube.academy/courses/kubernetes-core-concepts-part-1" >}}
<br/>

- Kubernetes Core Concepts (Managing Applications)

{{< button label="Start Course (1hr 30min)" link="https://kube.academy/courses/kubernetes-core-concepts-part-2" >}}
<br/>

#### Intermediate

- Learn different methods for building container images.

{{< button label="Start Course (1 hr)" link="https://kube.academy/courses/building-images" >}}
<br/>

- See different methods for observing applications on Kubernetes

{{< button label="Start Course (45 min)" link="https://kube.academy/courses/introduction-to-observability" >}}
<br/>

- Kubernetes Core Concepts (Clusters)

{{< button label="Start Course (1hr 30min)" link="https://kube.academy/courses/kubernetes-core-concepts-part-3" >}}
<br/>

- Kubernetes Core Concepts (Additional Application features)

{{< button label="Start Course (1hr 30min)" link="https://kube.academy/courses/kubernetes-core-concepts-part-4" >}}
<br/>

- Kubernetes workloads and security

{{< button label="Start Course (1 hr)" link="https://kube.academy/courses/kubernetes-core-concepts-part-5" >}}
<br/>

- Interacting with Kubernetes

{{< button label="Start Course (15 min)" link="https://kube.academy/courses/interacting-with-kubernetes" >}}
<br/>

- Interacting with Cloud Providers

{{< button label="Start Course (45 min)" link="https://kube.academy/courses/integrating-with-cloud-providers" >}}
<br/>

- Cluster Operations with various tools.

{{< button label="Start Course (1 hr)" link="https://kube.academy/courses/cluster-operations" >}}
<br/>

- Helm 101

{{< button label="Start Course (2 hr)" link="https://kube.academy/courses/helm-101" >}}
<br/>

#### Advanced

- How to prepare for the _Certified Kubernetes Administrator_ exam.

{{< button label="Start Lab (2 hrs)" link="https://kube.academy/courses/how-to-prepare-for-the-cka-exam" >}}
<br/>

- The _Certified Kubernetes Application Developer_ practice exam.

{{< button label="Start Lab (3 hrs)" link="https://kube.academy/courses/ckad-practice" >}}
<br/>

- More _Certified Kubernetes Application Developer_ practice scenarios.

{{< button label="Start Lab (3 hrs)" link="https://www.katacoda.com/liptanbiswas/courses/ckad-practice-challenges" >}}
<br/>

- Interactive Scenarios for _Certified Kubernetes Administrator_

{{< button label="Start Lab (3+ hrs)" link="https://killercoda.com/killer-shell-cka" >}}
<br/>

{{< notice tip >}}This last one is not free, but is the best exam simulator available!{{</ notice >}}

- Killer CKS, CKA, CKAD exam simulator.

{{< button label="Start Lab (3+ hrs)" link="https://killer.sh/" >}}
<br/>
