---
title: "Platform Checklist"
date: 2023-06-15T09:00:00+10:00
icon: "fab fa-kubernetes"
description: "A starter checklist to ensure your platform is production-ready."
type: "docs"
weight: 2
draft: false
---

## Checklist

The following is a checklist to help you ensure your platform is production-ready. It is not exhaustive and should be used as a guide only. It is recommended to use tools like Sonobuoy on cluster deployment or Admission Controller rules and/or OPA policies to automate the process of confirming as a form of continuous assurance.

### Availability

- [ ] Set up an odd-numbered set of replicated master nodes, with a minimum of 3.
- [ ] Schedule regular, automated etcd snapshots.
- [ ] Schedule automated etcd snapshot verifications.
- [ ] Configure the Cluster Autoscaler if it's supported by the underlying platform.

### Resource Management

- [ ] Properly size the cluster for the workload.
- [ ] Deploy the required Namespaces with resource limits.
- [ ] Ensure default resource requests and limits for Namespaces are applied.
- [ ] Ensure Nodes have the required billing tags.
- [ ] Confirm the limits for the number of Pods per node are as expected.
- [ ] Ensure priority classes are correctly applied.
- [ ] Reserve resources for critical core services such as logging and security tooling.
- [ ] Configure out-of-resource handling and eviction policies.

### Storage

- [ ] Document the StorageClasses provided and ensure they offer various performance and availability levels to meet workload requirements.
- [ ] Confirm Log Rotation is configured.

### Core Services

- [ ] Verify all core services meet the production-ready application checklist.
- [ ] Confirm all core services are monitoring and alerting on key metrics.

### AAA

- [ ] Implement OpenID Connect (OIDC) as the authentication mechanism.
- [ ] Ensure role-based access controls are configured.
- [ ] Confirm the correct Authentication backend is configured.
- [ ] Ensure all authentication logs are captured off-cluster and retained.
- [ ] Verify automated certificate rotation is functional.
- [ ] Limit `ServiceAccount` tokens to applications and controllers only.

### Security

- [ ] Confirm the usage of a supported Kubernetes GA version.
- [ ] Ensure audit logging is enabled and logs are captured externally.
- [ ] Enable NSP.
- [ ] Enable PSP.
- [ ] Set up a Bastion host with controlled access.
- [ ] Enable Kubernetes logging.
- [ ] Ensure the default service account is disabled.
- [ ] Confirm etcd data encryption at rest is enabled.
- [ ] Ensure runtime security is deployed and reporting correctly.
- [ ] Implement well-documented processes for secure handling of secrets from source to cluster.
- [ ] Lock down all pods and nodes and implement a traceable break-glass policy.
- [ ] Configure security contexts for pods, containers, and volumes.
- [ ] Implement procedures for handling runtime security alerts and discovered vulnerabilities.
- [ ] Pass the Cluster CIS benchmark tests.
- [ ] Collect logs from Nodes, including Kubelet and Container Runtime.
- [ ] Collect logs from Control Plane components, including API Server, Scheduler, Controller Manager, and Cloud Controller Manager.
- [ ] Collect Auditing logs from all requests to the Kubernetes API Server.

### Observability

- [ ] Integrate the Cluster with the Observability Platform.
- [ ] Set up metrics thresholds with processes in place for regular SRE review and adjustment.
- [ ] Configure alerting and self-healing thresholds.
- [ ] Centralize logs, metrics, and traces in a single indexed and searchable location with RBAC, if possible.
- [ ] Set up alerting and report summary generation based on tags, directed to the correct personnel or team.

### CI/CD

- [ ] Ensure only immutable tags are used.
- [ ] Adopt blue/green or rolling deployment

## Links

- [Kubernetes checklist](https://kubernetes.io/docs/setup/production-environment/)
- [Cloud Control checklist](https://www.ecloudcontrol.com/kubernetes-production-readiness-checklist/)
- [Cloud Control Enterprise checklist](https://www.ecloudcontrol.com/kubernetes-production-readiness-checklist-for-enterprise/)
- [Learnk8s checklist](https://learnk8s.io/production-best-practices)
- [WeaveWorks checklist](https://www.weave.works/blog/kubernetes-best-practices)
- [Rancher checklist](https://ranchermanager.docs.rancher.com/v2.5/pages-for-subheaders/checklist-for-production-ready-clusters)
- [Container Capabilities](https://blog.container-solutions.com/linux-capabilities-why-they-exist-and-how-they-work)
