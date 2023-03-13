---
title: "DevOps"
date: 2021-04-19T00:00:00+00:00
icon: "fa-solid fa-credit-card"
description: "DevOps is a culture, not a title."
type: "docs"
weight: 100
draft: true
---

## Overview

DevOps is a _culture_, not a title.

Like a lot of industry terms, every organisation defines DevOps differently.

Taking one definition;

> DevOps is a set of practices that combines software development and IT operations. It aims to shorten the systems development lifecycle and provide continuous delivery with high quality software.

DevOps is often conflated with Agile but in truth, compliments it.

### Are we DevOps yet?

Ask yourself the following questions to find out...

{{< notice tip >}}

**Checklist**

This checklist is an extended version based on the fine work over at [DevOps Checklist](https://devopschecklist.com) and is intended to be used to gauge the maturity level of software delivery competency and form a baseline to be able to measure future improvements.

It's not meant to say that you're failing DevOps but rather to surface the areas that need improvement.

{{</ notice >}}

#### Alignment

Unifying group and individual direction and goals around the singular vision of the organization.

| Question                                                                      | Answer |
| :---------------------------------------------------------------------------- | :----: |
| We prioritise according to business objectives                                | YES/NO |
| We volunteer for tasks rather than have them assigned                         | YES/NO |
| Our team has clear objectives the correspond with our company vision          | YES/NO |
| Our product team is focused on sustainable velocity rather than current speed | YES/NO |
| We focus on time to repair rather than time between issues                    | YES/NO |
| DevOps is not isolated to a specific role in our organisation                 | YES/NO |
| DevOps is not isolated to a specific team in our organisation                 | YES/NO |
| Our operational functions are seen as a source of competitive advantage       | YES/NO |

#### Learning

Empowering personal growth and fostering understanding through continuous improvement.

| Question                                                                          | Answer |
| :-------------------------------------------------------------------------------- | :----: |
| We cultivate an environment of continuous learning                                | YES/NO |
| We regularly celebrate our product team's learnings and success internally        | YES/NO |
| We identify skills needed to improve or address future objectives                 | YES/NO |
| We strive to examine how we complete our work, and how effictively we complete it | YES/NO |
| We estimate based on measurement and past experience                              | YES/NO |
| We provide security training to developers                                        | YES/NO |

#### Lifecycle

Focus on software as a product deserving of care, attention and reflection, within and ever changing ecosystem.

| Question                                                                                | Answer |
| :-------------------------------------------------------------------------------------- | :----: |
| Our software development cycle is two weeks or less                                     | YES/NO |
| Our software development cycle is defined by releasing a working change into production | YES/NO |
| We stop development upon discovering a defect and prioritise it's repair                | YES/NO |
| Developers or product owners are able to deploy our product to production               | YES/NO |
| We have automated testing prior to automated production deployment                      | YES/NO |
| Our configuration of systems is automated                                               | YES/NO |
| Our deployed system configuration is immutable                                          | YES/NO |
| Our release and deployment automation is environment agnostic                           | YES/NO |
| We make security part of the entire development process                                 | YES/NO |
| We test security throughout the development lifecycle                                   | YES/NO |
| We automate as many processes as possible                                               | YES/NO |
| We monitor processes, infrastructure and applications                                   | YES/NO |
| We generate actionable alerts when there are issues                                     | YES/NO |

#### Organisation

Providing structure for interaction and cohesion supporting collaboration and productivity.

| Question                                                                       | Answer |
| :----------------------------------------------------------------------------- | :----: |
| Our organisation is configured around cross-functional teams                   | YES/NO |
| Our teams are customer and product orientated                                  | YES/NO |
| Our developers have access to production-like systems to work and test on      | YES/NO |
| Our developers have access to production-like data to work and test against    | YES/NO |
| Our developers have access to dependencies required to build and test software | YES/NO |
| We encourage secure employee behavior                                          | YES/NO |
| We check employee behavior                                                     | YES/NO |
| We do regular spear-phishing campaigns                                         | YES/NO |

#### Process

Rituals crafted to foster consistency and confidence, providing a framework for continuous improvement.

| Question                                                                | Answer |
| :---------------------------------------------------------------------- | :----: |
| Our organisation follows agile development practices.                   | YES/NO |
| We regularly examine constraints in our delivery process                | YES/NO |
| Our system configuration is commited into version control               | YES/NO |
| We practice test or behavior driven development                         | YES/NO |
| We test our changes against a merge with our mainline code              | YES/NO |
| We test out changes against production-equivilent load and use patterns | YES/NO |

#### Protection

Protecting resources before, during and after development.

| Question                                                   | Answer |
| :--------------------------------------------------------- | :----: |
| We use security best practices and tools                   | YES/NO |
| We detect and block unusual behavior                       | YES/NO |
| We automate security testing and protection                | YES/NO |
| We automate data policy management                         | YES/NO |
| We complement automatic testing with creative manual tests | YES/NO |
| We follow post-production protection best practices        | YES/NO |
| We limit our attack surface                                | YES/NO |
| We use security tools than continue to evolve              | YES/NO |

#### Code

Securing the entire toolchain.

| Question                                                  | Answer |
| :-------------------------------------------------------- | :----: |
| We code security into our applications                    | YES/NO |
| We continuously review code at every stage                | YES/NO |
| We introduce chaos into the comfort zone                  | YES/NO |
| We maintain inventory of all applications and components  | YES/NO |
| We scan and secure open source and third-party components | YES/NO |
| We run security analytics programs against all code       | YES/NO |

#### APIs

Monitoring and securing APIs.

| Question                                                 | Answer |
| :------------------------------------------------------- | :----: |
| We secure all APIs                                       | YES/NO |
| We authenticate and authorize all API users              | YES/NO |
| We apply security policies to APIs                       | YES/NO |
| All transmission paths are secured                       | YES/NO |
| We validate all input data, responses and content types  | YES/NO |
| We use RBAC to manage access to resources and operations | YES/NO |
| We prevent API parameter tampering, hijacks and attacks  | YES/NO |

#### The Joel Test

The classic interview questionnaire is _still_ relevant over 20 years on.

| Question | Answer |
| :------- | :----: |
| Do you use source control? | YES/NO |
| Can you make a build in one step? | YES/NO |
| Do you make daily builds? | YES/NO |
| Do you have a bug database? | YES/NO |
| Do you fix bugs before writing new code? | YES/NO |
| Do you have an up-to-date schedule? | YES/NO |
| Do you have spec? | YES/NO |
| Do programmers have quiet workinng conditions? | YES/NO |
| Do you use the best tools that money can buy? | YES/NO |
| Do you have testers? | YES/NO |
| Do new candidates write code during their interview? | YES/NO |
| Do you do hallway usability testing? | YES/NO |

### Quotes

Some of my favorite DevOps quotes.

>
> To me, the goal of DevOps is to automate your s**t to the point of boredom and then keep the infrastructure up-to date with new tech._
>
> DevOps is about getting away from monkeying servers with the goal of monkeying systems that monkey the servers for you.
>
> DevOps is about using these sexy toolchains to build testable, repeatable, automated infrastructure in such a way that you never have to actually touch a server again (ie you can disable SSH)
>
> DevOps is about being able to look at your infrastructure not as a fleet of servers but as a bunch of code in a repository.
>
> Tools come and ago, but how you approach the work makes the difference. If your approach is "I want to learn DevOps, what tool do I need" you are doomed to disappointment, because you are asking the wrong question from the start.
>

### Resources

-   [The Phoenix Project](https://itrevolution.com/the-phoenix-project/)
-   [Velocity: 10+ deploys a day](https://itrevolution.com/the-phoenix-project/)
-   [Continuous Integration](https://www.thoughtworks.com/continuous-integration)
-   [Continuous Delivery](https://continuousdelivery.com/)
-   [DevOps Cafe](http://devopscafe.org/)
-   [The Ship Show](https://theshipshow.com/)
-   [Food Fight](http://foodfightshow.org/)
-   [Arrested DevOps](https://www.arresteddevops.com/)
-   [Scrum guides](https://scrumguides.org/)
-   [DevOps Checklist](https://devopschecklist.com/)
-   [12 Factor Apps](https://12factor.net/)
-   [The Joel Test](https://www.joelonsoftware.com/2000/08/09/the-joel-test-12-steps-to-better-code/)
