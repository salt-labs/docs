---
title: "Cloud Native Engineer"
type: 'docs'
weight: 100
bookFlatSection: false
bookCollapseSection: true
bookHidden: false
bookToc: true
bookComments: false
bookSearchExclude: false
---

## Cloud Native Engineer

{{< hint danger >}}
**Early Release**

This is a _living_ document and continues to evolve.

Contributions are welcome!

{{< /hint >}}

Are you interested in becoming a _Cloud Native Engineer?_

If so, you have come to the right place. This document is a collection of resources and techniques that will help you along your journey.

The goal is not to prescribe specific technologies (as there are too many and they change frequently) but to provide a general overview of the cloud native development process with **examples** of concepts and tools in different areas to help you finding a path to your goals.

But first, what exactly is a _Cloud Native Engineer?_

___A cloud native engineer (CNE) takes an application from a repository through a continuous integration and delivery pipeline.___

During this journey, they ensure that the code builds, tests pass and the application gets safely and securely deployed up to the production environment.

The list of relevant technologies in this space is _overwhelming_. Just check out the <a href="https://landscape.cncf.io/" target="_blank">CNCF Landscape</a> to get an idea on _some of_ them. _But don't panic, you don't need to know them all_.

{{< hint info >}}
**Recommended Reading**

The CNCF has an excellent guide available to help decipher the landscape.

{{< button href="https://landscape.cncf.io/guide" >}}CNCF Landscape Guide{{< /button >}}

{{< /hint >}}

When it comes to product selection, there isn't _one_ answer to an often asked question, _what is the best toolchain to learn?_ The technologies and skills required will vary based on a number of factors.

Some of these factors include;

{{< columns >}}

### Programming Language

_What application programming languages are being used?_

- Java
- Python
- Go
- Rust
- .NET

<--->

### Build vs Buy

_Are you building or buying and integrating?_

- Building
- COTS
- SaaS
- Private, Public or Hybrid Cloud

<--->

### Environment requirements

_What makes your environment unique?_

- Existing integration points
- Reporting and Compliance
- Governance

{{< /columns >}}

CNE's need to have a broad range of knowledge across several key areas and should aim to have experience with one or more technologies in each area.

### Software Architecture

_Know what you are dealing with_

{{< tabs "software-architecture" >}}

{{< tab "Concepts" >}}

There are many available patterns for software architecture.

Some common examples include:

{{< button href="../../frameworks/monoliths" >}}Monoliths{{< /button >}}
{{< button href="../../frameworks/microservices" >}}Microservices{{< /button >}}
{{< button href="../../frameworks/serverless" >}}Serverless{{< /button >}}

{{< /tab >}}

{{< /tabs >}}

### Software Development

_How to run and build the project_

{{< tabs "software-development" >}}

{{< tab "Concepts" >}}

Learn about different concepts and techniques for software development.

{{< button href="/" >}}Build Scripts{{< /button >}}
{{< button href="/" >}}Reproducible Builds{{< /button >}}

{{< /tab >}}

{{< tab "Tools" >}}

Some of the tools you might come across in this are include;

{{< button href="/" >}}cmake{{< /button >}}
{{< button href="/" >}}npm{{< /button >}}
{{< button href="/" >}}installtools{{< /button >}}
{{< button href="/" >}}cargo{{< /button >}}
{{< button href="/" >}}Dockerfile{{< /button >}}

{{< /tab >}}

{{< /tabs >}}

### Packaging

_How the application is packaged for delivery_

{{< tabs "software-packaging" >}}

{{< tab "Concepts" >}}

{{< button href="/" >}}OS Packaging{{< /button >}}
{{< button href="/" >}}Containers{{< /button >}}
{{< button href="/" >}}Wasm{{< /button >}}

{{< /tab >}}

{{< tab "Tools" >}}

{{< button href="/" >}}RPM{{< /button >}}
{{< button href="/" >}}DEB{{< /button >}}
{{< button href="/" >}}Docker{{< /button >}}
{{< button href="/" >}}Buildpacks{{< /button >}}
{{< button href="/" >}}Kpack{{< /button >}}
{{< button href="/" >}}wasmtime{{< /button >}}
{{< button href="https://landscape.cncf.io/serverless" >}}CNCF Serverless Landscape{{< /button >}}
{{< button href="https://landscape.cncf.io/wasm" >}}CNCF Wasm Landscape{{< /button >}}

{{< /tab >}}

{{< /tabs >}}

### Continuous Integration and Delivery

_The CI tool drives the entire delivery process._

{{< tabs "ci-cd" >}}

{{< tab "Concepts" >}}

{{< button href="/" >}}CI{{< /button >}}
{{< button href="/" >}}CT{{< /button >}}
{{< button href="/" >}}CD{{< /button >}}
{{< button href="/" >}}Pipeline Design{{< /button >}}
{{< button href="/" >}}Choreographer Pattern{{< /button >}}
{{< button href="https://landscape.cd.foundation/" >}}CNCF CD Landscape{{< /button >}}

{{< /tab >}}

{{< tab "Tools" >}}

{{< button href="/" >}}GitLab CI{{< /button >}}
{{< button href="/" >}}GitHub Actions{{< /button >}}
{{< button href="/" >}}Jenkins X{{< /button >}}
{{< button href="/" >}}Concourse{{< /button >}}
{{< button href="/" >}}Tekton{{< /button >}}
{{< button href="/" >}}Cartogtapher{{< /button >}}

{{< /tab >}}

{{< /tabs >}}

### Orchestrators

_Container Schedulers and Orchestrators_

{{< tabs "container-orchestrators" >}}

{{< tab "Concepts" >}}

{{< button href="../../frameworks/12factors" >}}12 Factor Apps{{< /button >}}
{{< button href="../../frameworks/graph-theory" >}}Graph Theory{{< /button >}}
{{< button href="../../frameworks/promise-theory" >}}Promise Theory{{< /button >}}

{{< /tab >}}

{{< tab "Tools" >}}

{{< button href="https://docs.docker.com/engine/swarm/" >}}Docker Swarn{{< /button >}}
{{< button href="https://mesos.apache.org/" >}}Apache Mesos{{< /button >}}
{{< button href="https://www.nomadproject.io/" >}}Hashicorp Nomad{{< /button >}}
{{< button href="https://kubernetes.io/" >}}Kubernetes{{< /button >}}

{{< /tab >}}

{{< /tabs >}}

### Infrastructure Automation

_Build the infrastructure where the application will run._

For Cloud environments, this is usually a mix of managed services and writing glue code for the missing parts.

{{< tabs "infrastructure-automation" >}}

{{< tab "Concepts" >}}

{{< button href="/" >}}Graph Theory{{< /button >}}
{{< button href="/" >}}Promise Theory{{< /button >}}
{{< button href="/" >}}DRY{{< /button >}}

{{< /tab >}}

{{< tab "Tools" >}}

{{< button href="/" >}}CAPS{{< /button >}}
{{< button href="/" >}}Cloud Formation{{< /button >}}
{{< button href="/" >}}ARM{{< /button >}}
{{< button href="/" >}}gcloud{{< /button >}}
{{< button href="/" >}}Terraform{{< /button >}}
{{< button href="/" >}}Pulumi{{< /button >}}

{{< /tab >}}

{{< /tabs >}}

### Security

_How to secure the application throughout all stages_

{{< columns >}}

#### Build

{{< tabs "security-build" >}}

Secure the application during the build stage.

{{< tab "Concepts" >}}

{{< button href="/" >}}SAST{{< /button >}}
{{< button href="/" >}}DAST{{< /button >}}
{{< button href="/" >}}Container Scanning{{< /button >}}
{{< button href="/" >}}Conformance{{< /button >}}
{{< button href="/" >}}Secret Scanning{{< /button >}}
{{< button href="/" >}}Licensing{{< /button >}}
{{< button href="/" >}}Variant Analysis{{< /button >}}
{{< button href="/" >}}Structured Bill of Materials{{< /button >}}

{{< /tab >}}

{{< tab "Tools" >}}

{{< button href="/" >}}SonarQube{{< /button >}}
{{< button href="/" >}}ZAP{{< /button >}}
{{< button href="/" >}}Sysdig{{< /button >}}
{{< button href="/" >}}AquaSec{{< /button >}}
{{< button href="/" >}}Snyk{{< /button >}}
{{< button href="/" >}}Carbon Black{{< /button >}}
{{< button href="/" >}}CodeQL{{< /button >}}

{{< /tab >}}

{{< /tabs >}}

<--->

#### Run

{{< tabs "security-run" >}}

Secure the applications in realtime.

{{< tab "Concepts" >}}

{{< button href="/" >}}Continuous Compliance{{< /button >}}
{{< button href="/" >}}Policy Engines{{< /button >}}
{{< button href="/" >}}Activity Auditing{{< /button >}}
{{< button href="/" >}}Alerting and Incident response{{< /button >}}
{{< button href="https://cheatsheetseries.owasp.org/cheatsheets/Kubernetes_Security_Cheat_Sheet.html" >}}OWASP Cheat Sheet{{< /button >}}

{{< /tab >}}

{{< tab "Tools" >}}

{{< button href="/" >}}Sysdig{{< /button >}}
{{< button href="/" >}}AquaSec{{< /button >}}
{{< button href="/" >}}Carbon Black{{< /button >}}

{{< /tab >}}

{{< /tabs >}}

{{< /columns >}}

### Observability

_How to monitor the application inside and out_

{{< tabs "observability" >}}

{{< tab "Concepts" >}}

{{< button href="/" >}}Logs{{< /button >}}
{{< button href="/" >}}Metrics{{< /button >}}
{{< button href="/" >}}Distributed Tracing{{< /button >}}

{{< /tab >}}

{{< tab "Tools" >}}

{{< button href="/" >}}Splunk{{< /button >}}
{{< button href="/" >}}Loki{{< /button >}}
{{< button href="/" >}}Prometheus{{< /button >}}
{{< button href="/" >}}Stackdriver{{< /button >}}
{{< button href="/" >}}OpenTelemetry{{< /button >}}
{{< button href="/" >}}Jaegar{{< /button >}}
{{< button href="/" >}}Zipkin{{< /button >}}

{{< /tab >}}

{{< /tabs >}}

### Building Blocks

_For a lot of companies, Infrastructure gets replaced by an API, credentials and a bill that tracks usage._

CNE's need to understand the building blocks of the cloud native applications.

{{< tabs "building-blocks" >}}

{{< tab "Concepts" >}}

{{< button href="/" >}}Compute Units{{< /button >}}
{{< button href="/" >}}Databases{{< /button >}}
{{< button href="/" >}}Storage{{< /button >}}
{{< button href="/" >}}Network{{< /button >}}
{{< button href="/" >}}Pricing{{< /button >}}

{{< /tab >}}

{{< tab "Tools" >}}

{{< button href="/" >}}Public Cloud Providers{{< /button >}}
{{< button href="/" >}}Private and Hybrid Cloud Providers{{< /button >}}
{{< button href="/" >}}Billing consoles and CSV reports 😁{{< /button >}}

{{< /tab >}}

{{< /tabs >}}

### Deployment Patterns

_Common deployment patterns_

{{< tabs "deployment-patterns" >}}

{{< tab "Concepts" >}}

{{< button href="/" >}}Rolling deployments{{< /button >}}
{{< button href="/" >}}Blue/Green{{< /button >}}
{{< button href="/" >}}Canary Deployments{{< /button >}}
{{< button href="/" >}}Feature Flags{{< /button >}}
{{< button href="/" >}}GitOps{{< /button >}}

{{< /tab >}}

{{< tab "Tools" >}}

{{< button href="/" >}}X{{< /button >}}
{{< button href="/" >}}X{{< /button >}}
{{< button href="/" >}}X{{< /button >}}

{{< /tab >}}

{{< /tabs >}}

### Service Mesh

_Customisable network-based interprocess communication_

{{< tabs "service-mesh" >}}

{{< tab "Concepts" >}}

{{< button href="/" >}}Circuit breaker pattern{{< /button >}}
{{< button href="/" >}}Load Balancing{{< /button >}}
{{< button href="/" >}}Encryption{{< /button >}}
{{< button href="/" >}}Observability{{< /button >}}
{{< button href="/" >}}Traceability{{< /button >}}
{{< button href="/" >}}Authentication{{< /button >}}
{{< button href="/" >}}Authorization{{< /button >}}

{{< /tab >}}

{{< tab "Tools" >}}

{{< button href="/" >}}Istio{{< /button >}}
{{< button href="/" >}}Envoy{{< /button >}}
{{< button href="/" >}}Linkerd{{< /button >}}
{{< button href="/" >}}Traefik Mesh{{< /button >}}
{{< button href="https://www.hashicorp.com/products/consul/multi-platform-service-mesh" >}}Consul{{< /button >}}

{{< /tab >}}

{{< /tabs >}}

### Soft Skills

_Engineer's are people too!_

Besides being a good coder, every engineer needs soft skills in their toolbox.

Some of these skills are hard or even impossible to teach, but these are the most common soft-skills asked by top IT recruiters with "_10 years experience recruiting for cloud-native roles_" 😏.

{{< tabs "soft-skills" >}}

{{< tab "Interpersonal" >}}

CNEs work with customers, interact with partners, colleagues and sometimes even the _'competition'_.

_CNEs need to be able to communicate with everybody._

{{< /tab >}}

{{< tab "Curiosity" >}}

Have you seen the <a href="https://landscape.cncf.io/" target="_blank">CNCF Landscape</a>? There is ___a lot to learn___.

So I hope you like learning new things. 😄

{{< /tab >}}

{{< tab "Problem Solving" >}}

CNEs need to be able to solve problems, and to understand _how to solve them_.

You might be faced with a new technology, but due to foundational knowledge, know how to get to the solution.

A _solution-orientated mindset_ is vital to success.

If you are interested, there are _critical thinking_ courses available.

{{< button href="https://www.edx.org/learn/critical-thinking-skills" >}}Critical Thinking courses{{< /button >}}

{{< /tab >}}

{{< tab "Humility" >}}

Again, see the <a href="https://landscape.cncf.io/" target="_blank">CNCF Landscape</a>. You are _guaranteed_ to be asked about something on there you don't know.

_Know when to ask for help if required._

{{< /tab >}}

{{< tab "Willingness to help" >}}

Balanced teams have a wide range of skills and abilities.

CNEs need to be able to help when they can and share knowledge with teammates so collectively the team can grow 🌱.

{{< /tab >}}

{{< /tabs >}}
