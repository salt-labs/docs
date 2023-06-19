---
title: "Application Checklist"
date: 2023-06-15T09:00:00+10:00
icon: "fab fa-kubernetes"
description: "A starter checklist for ensuring your application is production-ready."
type: "docs"
weight: 2
draft: false
---

## Checklist

The following checklist will assist in ensuring your application is production-ready. This list isn't exhaustive and should serve as a guide. Use Admission Controller rules and/or OPA policies to automate the process of confirming as a form of continuous assurance.

### Availability

- [ ] Deploy the application in a high-availability configuration.
- [ ] Configure a `readiness` probe for the application.
- [ ] Configure a separate `liveness` probe for the application.
- [ ] Set the application to crash on failure.
- [ ] Ensure the `readiness` probe operates independently of dependencies.
- [ ] Implement retry logic for the application when connecting to dependencies.
- [ ] Handle SIGTERM gracefully in the application.
- [ ] If necessary, handle lifecycle events such as preStop and postStart in the application.
- [ ] Ensure the CMD in the Dockerfile forwards SIGTERM to the process.
- [ ] Close all idle keep-alive connections on application shutdown.
- [ ] Configure `PodDisruptionBudgets` for the application.
- [ ] Set up PodAntiAffinity for all critical workloads.
- [ ] Configure PodAffinity for all critical workloads.
- [ ] Set up PriorityClasses for all critical workloads.
- [ ] Configure HorizontalPodAutoscalers.
- [ ] If supported by the application, configure VerticalPodAutoscalers for non-HPA workloads.
- [ ] Adopt best practices for application upgrades (blue/green, canary, rolling, etc.).

### Resource Management

- [ ] Create separate namespaces for each application.
- [ ] Configure `ResourceQuotas` for all namespaces.
- [ ] Configure `LimitRange` for all namespaces.
- [ ] Configure QoS for Pods.
- [ ] Configure memory requests and limits for all containers.
- [ ] Configure CPU requests for all containers.
- [ ] Label all resources with technical labels:
  - app.kubernetes.io/name
  - app.kubernetes.io/instance
  - app.kubernetes.io/version
  - app.kubernetes.io/component
  - app.kubernetes.io/part-of
  - app.kubernetes.io/managed-by
- [ ] Label all resources with business labels:
  - owner
  - project
  - business-unit
  - cost-centre
  - contact
- [ ] Label all resources with security labels:
  - confidentiality
  - compliance

### Storage

- [ ] Use the correct storage class for the workload (RWX/RWO).

### AAA

- [ ] Configure RBAC for all applications.
- [ ] Use the least privileged service account for the workload.
- [ ] For applications that don't support logging natively, add sidecar containers for logging and monitoring.
- [ ] Review Zalando's RBAC best practices.
- [ ] Disable the default ServiceAccount.

### Security

- [ ] Use container images from scratch or trusted sources.
- [ ] Enforce pod security policies.
- [ ] Enforce pod security contexts, such as `readOnlyRootFilesystem`.
- [ ] Enforce network security policies.
- [ ] Enforce secret management policies; avoid passwords on any filesystem.
- [ ] Set up ingress controllers and/or API gateways.
- [ ] Log all applications to stdout and stderr using passive logging.
- [ ] If possible, avoid logging sidecars; instead, implement logging in the application.
- [ ] If possible, use secrets as volumes for all applications.
- [ ] Through Admission Control, restrict all non-approved container images.
- [ ] Through Validating webhook, enforce unique ingress names.
- [ ] Enforce approved domain names in ingress hostnames.

### Observability

- [ ] Configure logging for all applications.
- [ ] Configure metrics for all applications.
- [ ] Capture distributed traces for all applications.
- [ ] Provide a framework for logging and analysis.

## Tips

### Container Images

- Don't trust arbitrary container images from the internet; use trusted sources or build from scratch.
- Keep base images as small as possible.
- Adopt the builder pattern or cloud-native application bundles.
- Use only non-root containers.
- Mark container images as read-only.
- Maintain one-process per container.
- Don't restart on failure; instead, crash.
- Log everything to stdout and provide config options for log level and text or JSON output.

### Deployments

- For all deployments, use the `record` option for rollback.
- For all deployments, use labels correctly.
- Use separate namespaces for each application.
- Use sidecars for proxying, watchers, etc.
- For bootstrapping, don't use sidecars; instead, use init containers.
- Use immutable tags for all deployments.
- Don't use services of type LoadBalancer; instead, use ingress controllers or API gateways.
- Map external services to internal services.

### Application Architecture

- Use Carvel packages for repeatable, reconcilable deployments.
- Utilize Kubernetes namespace isolation for applications.
- Implement Role-Based Access Control (RBAC) for all applications.

## Links

- [Kubernetes checklist](https://kubernetes.io/docs/setup/production-environment/)
- [Cloud Control checklist](https://www.ecloudcontrol.com/kubernetes-production-readiness-checklist/)
- [Cloud Control Enterprise checklist](https://www.ecloudcontrol.com/kubernetes-production-readiness-checklist-for-enterprise/)
- [Learnk8s checklist](https://learnk8s.io/production-best-practices)
- [WeaveWorks checklist](https://www.weave.works/blog/kubernetes-best-practices)
- [Rancher checklist](https://ranchermanager.docs.rancher.com/v2.5/pages-for-subheaders/checklist-for-production-ready-clusters)
- [Container Capabilities](https://blog.container-solutions.com/linux-capabilities-why-they-exist-and-how-they-work)
