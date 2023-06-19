---
title: "Actor Model"
date: 2021-04-19T00:00:00+00:00
icon: "fa-solid fa-credit-card"
description: "A pattern using 'Actors' as the fundamental agents of computing. Commonly seen with serverless systems."
type: "docs"
weight: 112
draft: false
---

## Overview

The Actor Model is a computational pattern that uses "Actors" as the fundamental agents of computing. In this model, Actors are independent, concurrent entities that communicate and interact solely through asynchronous message passing. This approach is well-suited for distributed and parallel systems, including serverless architectures, and can help improve scalability, fault tolerance, and resilience.

## Key Concepts of the Actor Model

1. **Actors**: Actors are the primary building blocks of the Actor Model. Each Actor is an independent, concurrent entity with a unique address and a private internal state.
2. **Message Passing**: Actors communicate exclusively through asynchronous message passing, which decouples them from each other and allows them to interact without sharing state or data.
3. **Concurrency**: The Actor Model enables concurrent execution of Actors, making it a suitable approach for parallel and distributed systems.
4. **Fault Tolerance**: In the Actor Model, errors and failures are contained within individual Actors, reducing the risk of cascading failures and improving overall system resilience.

## Advantages of the Actor Model

1. **Scalability**: The Actor Model's inherent concurrency and asynchronous communication make it highly scalable and well-suited for large-scale distributed systems.
2. **Resilience**: By isolating failures within individual Actors, the Actor Model can improve system resilience and facilitate error recovery.
3. **Simplicity**: The Actor Model simplifies concurrent programming by providing a clear, easy-to-understand abstraction for managing concurrency and parallelism.
4. **Adaptability**: The Actor Model can be easily adapted to various architectures and platforms, including serverless systems.

## Disadvantages of the Actor Model

1. **Complexity**: The Actor Model's reliance on message passing and asynchronous communication can introduce complexity, making it more difficult to reason about the system's state and behavior.
2. **Debugging**: Debugging and diagnosing issues in an Actor-based system can be challenging due to the distributed and concurrent nature of the Actors.

## Related Links

- [Actor Model (Wikipedia)](https://en.wikipedia.org/wiki/Actor_model)
- [The Actor Model in 10mins](https://www.brianstorti.com/the-actor-model/)
- [The Actor Model, everything you wanted to know (YouTube)](https://www.youtube.com/watch?v=7erJ1DV_Tlo&feature=emb_logo)
