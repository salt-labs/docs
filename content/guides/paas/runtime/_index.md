---
title: "Kubernetes Runtime Roadmap"
date: 2020-02-13T15:00:00+02:00
icon: "fab fa-kubernetes"
description: "A roadmap for building a Kubernetes Runtime."
type: "docs"
weight: 2
draft: false
---

## Overview

The following is an opinionated grouping of categories for developing an enterprise Kubernetes Runtime. This information is based on various sources across the web.

The information is centered around the idea of the layered diagram below representing the final product and works through from the bottom up.

## Challenges

Delivering a consistent Kubernetes runtime for developers is crucial for success, particularly as more and more enterprises have environments spread across multiple clouds. Standardizing on a common toolchain across the below areas will ensure consistency and allow operations teams to keep codebases as DRY as possible.

## Layers

The following diagram is a visual representation of the layers of a Kubernetes Runtime. Each layer involves a different set of tools and technologies based on organisation requirements.

<!-- UPLOAD DIAGRAM HERE -->

TODO: Upload the diagram here.

Layer 6. Applications

Layer 5. Platform Services

Layer 4. Security Policies, Certificates, Conformance, Test/Bench, Build Security (wrap CI/CD,SCM, Runtime Security, Observability.

Layer 3. CNI, CSI, CR, Certificates, Service Proxy, Auth, Backup

Layer 2. Lifecycle, Automation, Configuration

Layer 1. DNS, Scheduler, CRI, etcd

Layer 0. Platform & eXternal services. Dependencies like CI/CD, SCM

## Layer 0

### Platform

The underlying platform serves as the the foundation and is the first stage in the decision tree.

This will set the constraints and requirements for the rest of the decisions.

- Are you deploying to Public Cloud, Private Cloud, or Hybrid Cloud?
- Are you deploying to a single cloud provider or multiple cloud providers?
- Are you deploying across Regions?
- What services will be provided within the PaaS and what are consumed externally?

Examples: AWS, Azure, GCP, OpenStack, VMware, Bare Metal

### Source Control

Source control, also known as version control, is a system that manages changes to a set of files or code over time. It allows developers to track revisions, collaborate on code, and maintain a history of modifications. This is essential for efficient software development and provides a foundation for collaboration, code review, and automation.

Examples: Git, GitHub, GitLab, BitBucket, Plastic SCM

### Continuous Integration and Delivery

Continuous Integration (CI) and Continuous Delivery (CD) are essential practices in modern software development. CI is the process of integrating changes to the codebase automatically and continuously, ensuring that the code is consistently tested and built. CD is the practice of automatically deploying the built code to various environments, ensuring a smooth release process. Together, CI/CD pipelines help teams to develop, test, and deliver software efficiently and reliably.

Examples: Jenkins, GitHub Actions, GitLab CI, Bamboo, Spinnaker, Tekton, ArgoCD, Flux, Drone, Concourse, TeamCity, Octopus Deploy, AWS CodePipeline, Azure DevOps, Google Cloud Build.

## Layer 1

### Scheduling and Orchestration

Scheduling and orchestration are fundamental components of a Kubernetes Runtime. The scheduler is responsible for assigning workloads to available resources, while the orchestrator manages the lifecycle of those workloads, ensuring that they are running, scaling, and recovering as needed. Together, these components enable the efficient and reliable deployment and management of containerized applications.

Examples: Kubernetes, Marathon, Docker Swarm

### Coordination and Service Discovery

Coordination and service discovery are essential aspects of distributed systems and microservices architectures. Coordination ensures that the components of a system can communicate and collaborate effectively, while service discovery allows these components to dynamically locate and interact with one another. These features enable the system to adapt to changes in the environment and maintain high availability and resilience.

Examples: SkyDNS, KubeDNS, CoreDNS, Consul, etcd.

### Container Runtime

The container runtime is the underlying technology responsible for running containers on a host. It provides the necessary isolation, resource management, and security features required for running containerized applications. Different container runtime options offer varying levels of performance, security, and compatibility, so choosing the right one for your organization's needs is crucial.

Examples: Docker, containerd, CRI-O, gVisor, Kata Containers, CRX.

## Layer 2

### Automation and Configuration

Automation and configuration management are essential aspects of a Kubernetes Runtime, enabling teams to manage the complexity of deploying and maintaining containerized applications. Automation tools help to streamline the deployment process, reducing human error and improving efficiency. Configuration management tools enable teams to manage the settings and configuration of their applications in a consistent and versioned manner, ensuring that the system remains stable and predictable.

Examples: Ansible, Terraform, Chef, Puppet, SaltStack, Helm, Kustomize, Jsonnet, Carvel.

### Lifecycle Management

Kubernetes Cluster lifecycle management demands significant effort and attention. Up until the `1.22` release, upstream Kubernetes followed a quarterly release cycle, with monthly patches to stay updated. This can be challenging for operations teams to keep up with, especially when faced with competing priorities. Therefore, it's crucial to automate the process, reducing the maintenance burden and ensuring that the clusters stay up to date.

Examples: Cluster API, Terraform, CAPS.

## Layer 3

### Cloud Native Networking

Cloud Native Networking is a critical aspect of building and managing Kubernetes environments. It involves the networking components that enable communication between various parts of the system, providing connectivity, load balancing, and network policy enforcement. Different networking solutions offer different levels of performance, flexibility, and integration with other platforms, making it essential to choose the right solution for your organization's needs.

Examples: Multus, Antrea, Calico, NSX-T, Cilium, Weave, Flannel, Romana, OpenContrail, Open vSwitch, OVN-Kubernetes, OpenShift SDN.

### Cloud Native Storage

Cloud Native Storage is an essential aspect of building and managing Kubernetes environments, as it enables the storage and retrieval of data required by applications running on the platform. It comes in different forms, such as block storage, object storage, and file storage, each with its own unique characteristics and use cases. Understanding these different storage types and their respective advantages and limitations is crucial to choosing the right storage solution for your organization's needs.

### Block Storage (CSI)

Block Storage provides raw, fixed-size storage volumes that can be attached to containers. It is useful for applications that require high-performance storage with low latency, such as databases and transactional applications. Container Storage Interface (CSI) is a standard that allows Kubernetes to use external block storage providers in a vendor-neutral way, offering flexibility in choosing the best storage solution for your organization.

Examples: Amazon EBS, Google Persistent Disk, Azure Disk, VMware vSphere, OpenStack Cinder, Ceph RBD.

### Object Storage

Object Storage is a highly scalable and cost-effective storage solution that stores data as objects in a distributed storage system. It is suitable for use cases such as backups, archives, and large data sets like images, videos, and logs. Object Storage typically provides a RESTful API to access and manipulate stored objects, making it easy to integrate with various applications and platforms.

Examples: Amazon S3, Google Cloud Storage, Azure Blob Storage, MinIO, Ceph Object Storage, OpenStack Swift.

### File Storage

File Storage provides a shared filesystem that can be mounted by multiple containers simultaneously. This is useful for applications that require a shared storage space for files and directories, such as content management systems, web servers, and other collaborative applications. File Storage solutions can be either managed services provided by cloud providers or self-hosted solutions deployed on-premises or in the cloud.

Examples: Amazon EFS, Google Cloud Filestore, Azure Files, NFS, GlusterFS, CephFS, OpenStack Manila.

### Container Registry

A container registry is a centralized storage and distribution system for container images. It allows developers to push, store, and share container images with their team or the wider community. Using a container registry simplifies the deployment and management of containerized applications, ensuring that the appropriate versions of images are available and accessible when needed.

Examples: Docker Hub, Quay, ECR, GCR, ACR, Harbor, Artifactory, GitLab Registry, JFrog.

### Service Proxy

A service proxy, also known as an ingress controller, is responsible for managing traffic routing between external clients and internal services running in a Kubernetes cluster. It serves as a single entry point for external traffic, enabling load balancing, SSL termination, and other traffic management tasks.

Examples: NGINX, Contour, Traefik, HAProxy.

### Load Balancing

Load balancing is a technique used to distribute network traffic across multiple servers to ensure high availability, fault tolerance, and optimal resource utilization. In a Kubernetes environment, load balancing can be achieved using various mechanisms, such as software-based load balancers, cloud provider-native load balancers, or hardware load balancers.

Examples: MetalLB, AWS ELB, Azure Load Balancer, GCP Load Balancer, AVI Networks, NSX.

### External DNS

External DNS automation refers to the automatic management and configuration of DNS records for services running in a Kubernetes cluster. This process helps ensure that external clients can access the services using human-readable domain names instead of IP addresses. External DNS automation can be achieved using tools that monitor the cluster for changes and automatically update the DNS records accordingly.

Examples: ExternalDNS, CoreDNS, Route 53, Cloudflare, Infoblox, Azure DNS, Google Cloud DNS.

### Authentication

Authentication is the process of verifying the identity of users, applications, or systems trying to access resources within a Kubernetes cluster. By implementing authentication, you can ensure that only authorized entities have access to specific resources or perform specific actions. Several authentication methods and solutions can be integrated with Kubernetes to provide a secure and seamless user experience.

Examples: Pinniped, Dex, Keycloak, Okta, Auth0, Azure AD, Google Cloud Identity, AWS IAM, LDAP, OIDC, SAML.

### Package Management

Package management in Kubernetes refers to the tools and processes used to package, distribute, and deploy applications or configurations within a Kubernetes cluster. These tools help streamline the deployment of complex applications and simplify the management of application dependencies, configurations, and updates.

Examples: Helm, Kustomize, Carvel.

### Data Protection

Data protection is an essential aspect of managing and operating Kubernetes clusters, ensuring the integrity and availability of data stored within the cluster. Tools and solutions for data protection help with backup and restore operations, disaster recovery, and data migration. By implementing data protection solutions, you can safeguard your cluster's data against accidental deletion, hardware failures, or other unforeseen events.

Examples: Velero, Restic Operator, Kasten.

## Layer 4

### Security and Compliance

Ensuring the security and compliance of Kubernetes clusters is a critical aspect of managing and operating them within an enterprise context. Kubernetes, by default, is designed to be developer-centric, which can sometimes conflict with the compliance and accreditation requirements of an organization. Securing a Kubernetes cluster involves implementing a defense-in-depth approach across multiple layers. Examples of security considerations for enterprises include:

- Hardened node images
- Build security with SAST (Static Application Security Testing) tooling
- Verification with image signing and whitelisting
- Runtime security

Shifting security "left" by catching potential issues before they are introduced into any environment can greatly ease the burden on operations teams and help prevent potential security breaches.

### Policy

Policy management tools help define and enforce rules and best practices for Kubernetes clusters, ensuring that deployed applications and configurations adhere to the organization's security, compliance, and performance requirements.

Examples: Open Policy Agent, Kyverno, jsPolicy, Polaris.

### ABAC

Attribute-Based Access Control (ABAC) is an access control model that defines access permissions based on attributes associated with users, resources, and actions within the system. This approach allows for more fine-grained control and flexibility in defining access rules.

Examples: TMC.

### Certificate Management

Certificate management involves the creation, distribution, rotation, and revocation of digital certificates within a Kubernetes cluster. Proper certificate management is crucial for ensuring secure communication between components and maintaining the integrity of the system.

Examples: cert-manager, Let's Encrypt, HashCorp Vault, Kubernetes Certificate API.

### Build Time Security

Build time security involves scanning and validating code, dependencies, and container images during the build process, ensuring that potential security issues are detected and addressed before deployment. This proactive approach helps mitigate vulnerabilities and enables organizations to maintain a higher level of security.

Examples: Clair, Trivy, Snyk, Aqua Security, Twistlock, Anchore.

### Runtime Security

Runtime security focuses on detecting and mitigating security threats during the execution of applications and services within a Kubernetes cluster. It involves monitoring and analyzing runtime behavior to identify malicious activities, enforce security policies, and protect sensitive data.

Examples: Sysdig, Falco, NeuVector, Prisma Cloud, Aqua Security, Twistlock.

### Key Management

Key management involves the secure generation, storage, and distribution of cryptographic keys used for encryption and decryption in a Kubernetes environment. Proper key management is essential for protecting sensitive data and ensuring the overall security of the system.

Examples: HashCorp Vault, AWS Key Management Service (KMS), Google Cloud KMS, Azure Key Vault.

### Conformance and Benchmarks

Conformance and benchmark testing are crucial for ensuring that a Kubernetes cluster meets the required standards and best practices for performance, security, and reliability. These tests can help identify areas of improvement and verify compliance with industry standards and regulatory requirements.

Examples: Sonobuoy, CIS Kubernetes Benchmark, Kubernetes Conformance Certification.

### Build Service

Build services are responsible for automating the process of building, testing, and packaging applications for deployment on Kubernetes clusters. They provide a streamlined and consistent approach to managing the application lifecycle, ensuring that applications are built and deployed efficiently and securely.

Examples: Buildpacks, Kpack, Kaniko, Tekton, ArgoCD, Flux, Drone, Concourse, TeamCity, Octopus Deploy, AWS CodePipeline, Azure DevOps, Google Cloud Build.

### GitOps

GitOps is a paradigm that emphasizes using Git as the single source of truth for declarative infrastructure and application configuration. GitOps promotes a clear separation between infrastructure and application code, enabling continuous integration and deployment (CI/CD) workflows and promoting collaboration and visibility among teams.

Examples: ArgoCD, Flux, Drone, Concourse, TeamCity, Octopus Deploy, AWS CodePipeline, Azure DevOps, Google Cloud Build, kapp-controller.

### Application Catalog

An application catalog is a centralized repository that stores and manages Helm charts, Kubernetes Operators, and other Kubernetes-native applications. It simplifies the deployment and management of applications on Kubernetes clusters by providing a user-friendly interface and automating the discovery, installation, and upgrade processes.

Examples: Kubeapps, ChartMuseum.

### Observability

An observability platform is the combination of logs, metrics, and tracing, often in a single pane of glass. Highly distributed, cloud-native applications create monitoring challenges that traditional tools can't handle. With potentially hundreds or thousands of containers running across multiple cloud providers and environments, visibility gaps can occur. This, when combined with an increase in the rate of change, causes enterprises to re-think their monitoring and site reliability engineering practices.

Modern application architectures can be complex, typically consisting of multiple distributed microservices implemented in different languages by different teams. As a developer or site-reliability engineer, you are responsible for the reliability and performance of these complex systems.

#### Logging

Logging involves the collection, storage, and analysis of log data from applications, infrastructure, and various services. This data is crucial for troubleshooting, debugging, and gaining insight into the behavior of systems.

Examples: Fluentd, Fluentbit, Splunk OTEL Collector.

#### Metrics

Metrics are quantitative measurements that provide insights into the performance, health, and utilization of systems and applications. They allow for the monitoring of trends, identification of anomalies, and capacity planning.

Examples: Prometheus, OpenTelemetry.

#### Tracing

Tracing provides visibility into the end-to-end execution of requests within a distributed system, allowing for the identification of performance bottlenecks, latency issues, and other operational challenges.

Examples: Jaeger, OpenTracing, Zipkin.

#### Syscall Tracing

Syscall tracing monitors system calls made by applications, providing visibility into the interactions between applications and the underlying operating system.

Examples: Sysdig, DTrace.

#### Alerting

Alerting systems detect anomalies, errors, or critical events in monitored systems and trigger notifications to designated recipients, allowing for rapid response and remediation.

Examples: Prometheus Alert-Manager.

#### Visualization

Visualization tools provide graphical representations of log, metric, and tracing data, enabling users to quickly identify trends, anomalies, and other insights.

Examples: Grafana, Splunk, Aria Operations.

## Related Links

- [Tanzu Developer Center](https://docs.vmware.com/en/VMware-vSphere/8.0/vsphere-with-tanzu-tkg/GUID-CDF0C2A1-54E8-483F-935A-71D64CA7921C.html)
- [Tanzu 12 Factor Microservices](https://tanzu.vmware.com/content/blog/12-factor-microservices-vmware-tanzu-kubernetes)
- [Building Paths to Production with Cartographer](https://tanzu.vmware.com/content/blog/building-paths-to-production-cartographer)
- [Security Product for US Army Software Factory](https://tanzu.vmware.com/content/blog/security-product-us-army-software-factory)
- [Modern SRE Practices: Incident Management](https://tanzu.vmware.com/content/blog/modern-sre-practices-incident-management)
- [Continuous and Automated Validation of Tanzu Solutions on VMware Marketplace: What, Why, How](https://tanzu.vmware.com/content/blog/continuous-and-automated-validation-tanzu-solutions-vmware-marketplace-what-why-how)
- [VMware Continuous Automated Validation of ISV Ecosystem Solutions](https://tanzu.vmware.com/content/blog/vmware-continuous-automated-validation-isv-ecosystem-solutions)
- [US Army Futures Command and VMware Tanzu](https://tanzu.vmware.com/content/blog/us-army-futures-command-vmware-tanzu)
- [Creating a Culture of DevSecOps](https://tanzu.vmware.com/content/blog/creating-a-culture-of-devsecops)
- [Almost Everything You Need to Know About SRE](https://tanzu.vmware.com/content/blog/almost-everything-you-need-to-know-about-sre)
- [Getting Started with Kubernetes and the New Tanzu Application Service](https://tanzu.vmware.com/content/blog/getting-started-with-kubernetes-then-get-to-know-the-new-tanzu-application-service)
- [A Quick Guide for Getting Up to Speed on SRE](https://tanzu.vmware.com/content/blog/a-quick-guide-for-getting-up-to-speed-on-sre)
- [Kubernetes: One Cluster or Many?](https://tanzu.vmware.com/content/blog/kubernetes-one-cluster-or-many)
- [Getting Started with Kubernetes](https://tanzu.vmware.com/developer/blog/getting-started-with-kubernetes/)
- [VMware Tanzu Kubernetes Grid 2.0](https://tanzu.vmware.com/content/blog/vmware-tanzu-kubernetes-grid-2-0)
- [Building Kubernetes Runtime](https://tanzu.vmware.com/developer/topics/building-kubernetes-runtime/)
- [VMware Tanzu Kubernetes Grid](https://tanzu.vmware.com/kubernetes-grid)
- [Building Your Kubernetes Platform](https://tanzu.vmware.com/developer/guides/building-your-kubernetes-platform/)
