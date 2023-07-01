---
title: "Package Author"
date: 2021-03-01T00:00:00+00:00
icon: "fa-solid fa-box"
description: "Tutorial Steps for the Package Author"
type: "docs"
weight: 3500
draft: false
---

## Overview

Carvel packaging steps from the perspective of a **_Package Author_** persona.

The following pages will take you through the steps that a **_Package Author_** would take to create a package that is then consumed by a **_Package Consumer_**.

We will work through an example process one might take in order to package an application ready for localised testing. The process will vary based on the type of package being created and how you will customise it, but the general process is the same.

By the end, you will be glad to know that we have tools and automation to help you with the process. 😄

The sample application used in this process is called `pacman`. _I wonder what it does? Let's find out!_

## Steps

To give you an idea on what to expect, here is a high level overview of the steps we will work through.

1. Define variables
2. Create folder structure
3. Run vendir
4. Run ytt
5. Run kbld
6. Run imgpkg
7. Create custom resources

## Time

_How long will this take?_

Unfortunately I can't give you a definitive answer.

It really depends on your experience with the tools, level of kubernetes knowledge and familiarity with the concepts. We have heard from users ranging from taking 1 hour, to others taking 1 day to complete the process start to finish.
