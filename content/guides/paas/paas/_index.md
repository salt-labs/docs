---
title: "Platform as a Service Roadmap"
date: 2020-02-13T15:00:00+02:00
icon: "fab fa-kubernetes"
description: "A roadmap for building a Kubernetes PaaS."
type: "docs"
weight: 3
draft: false
---

## Overview

Once your base Kubernetes Runtime is up and running, it's time to start extending it to provide a Platform as a Service (PaaS). This is where you start offering services that developers can consume to build their applications.

## Databases

Databases are essential components of applications that require data storage, retrieval, and manipulation. Providing managed database services allows developers to focus on application logic without worrying about database administration tasks.

Examples: VMWare Postgres Operator, CrunchyData Operator

## Streaming and Messaging

Streaming and messaging services enable asynchronous communication between microservices and facilitate real-time data processing. These services are critical for building event-driven architectures and can help ensure scalability and resiliency.

Examples: NATS, Kafka

## Application Definition and Image Build

Application definition and image build services provide tools and processes for defining application components, packaging them into container images, and managing the build process.

Examples: Kpack

## Service Discovery

Service discovery enables applications and services to locate and communicate with each other. This is crucial for dynamic environments, where the location of services can change frequently.

## Remote Procedure Call

Remote procedure call (RPC) services provide a method for invoking functions or methods on remote services or systems. They can help simplify communication between microservices and promote a more cohesive application architecture.

## Service Proxy

Service proxies are intermediaries that manage traffic between clients and services. They can provide load balancing, connection pooling, and other functionality to improve the performance and reliability of services.

## API Gateway

API gateways serve as entry points for external clients to access a system's services. They can provide authentication, authorization, rate limiting, and other functionality to protect and manage access to services.

## Service Mesh

Service meshes provide a dedicated infrastructure layer for managing service-to-service communication. They can offer features such as load balancing, traffic routing, security, and observability.

Examples; Istio, Linkerd, Consul Connect, App Mesh, Open Service Mesh.

## Serverless

Serverless services allow developers to build and deploy applications without managing the underlying infrastructure. These services automatically scale with demand and can help reduce operational overhead.

Examples: Knative, OpenFaaS, Fission, Kubeless, OpenWhisk, WasmCloud.

## Wasm

WebAssembly (Wasm) is a binary instruction format that enables the execution of high-performance, sandboxed code in web browsers and other environments. Wasm can provide a lightweight and secure way to run code in a Kubernetes environment.

## Tanzu Application Platform

The Tanzu Application Platform is an enterprise-grade platform-as-a-service (PaaS) built by VMware. It is designed to simplify the development, deployment, and management of containerized applications on Kubernetes. The Tanzu Application Platform provides a unified and consistent approach to application development, offering a suite of tools and services that enable developers to focus on writing code while the platform takes care of the underlying infrastructure.

Key features of the Tanzu Application Platform include:

- Streamlined application development workflows
- Integrated build and deployment pipelines
- Support for various programming languages and frameworks
- Secure and consistent application delivery
- Observability and monitoring capabilities
- Scalable and highly available runtime environments
- Integration with other VMware Tanzu solutions

With the Tanzu Application Platform, organizations can accelerate their application development processes, improve operational efficiency, and enhance security and compliance, ultimately driving business innovation and growth.
