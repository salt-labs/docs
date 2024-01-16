---
title: "Hard"
date: 2024-01-01T00:00:00+00:00
icon: "fa-solid fa-box"
description: "Create a Carvel package the hard way"
type: "docs"
weight: 3700
draft: false
---

## Overview

For those new to Carvel packaging, this is an example walk through taking you through the manual steps for the creation of a _Carvel Package_ "the hard way".

It is assumed that the reader already has an understanding of Kubernetes concepts and has knowledge of the carvel components prior to following this.

In a production setting, there are utilities, tools and CI that are used to make this process easier, but this walkthrough is designed to show the manual steps to help understand the process and see _"how the sausage is made"_.

The following pages will take you through the steps that a `Package Author` would take to create a package that is then consumed by a `Package Consumer`.

We will work through an example process one might take in order to package an application ready for localised testing. The process will vary based on the type of package being created and how you will customise it, but the general process is the same.

By the end, you will be glad to know that we have tools and automation to help you with the process. 😄

The sample application used in this process is called `pacman`. _I wonder what it does?_

**Let's find out!**

## Steps

To give you an idea on what to expect, here is a high level overview of the steps we will work through.

1. [Prepare](prepare)
2. [Define variables](variables)
3. [Create folder structure](structure)
4. [Run vendir](vendir)
5. [Run ytt](ytt)
6. [Run kbld](kbld)
7. [Create the Package](package)
8. [Run imgpkg](imgpkg)
9. [Kapp Controller](kapp-controller)
10. [Create the Repository](repository)
11. [Celebrate](congratulations)

## Time

_How long will this take?_

Unfortunately I can't give you a definitive answer.

It really depends on your experience with the tools, level of kubernetes knowledge and familiarity with the concepts. We have heard from users ranging from taking 1 hour, to others taking 1 day to complete the process start to finish.
