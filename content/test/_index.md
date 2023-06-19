---
title: Test
date: 2023-02-26T00:00:00+00:00
icon: "far fa-credit-card"
description: "Testing the site short codes."
type: "docs"
weight: 1
draft: false
---

## Table of Contents

<!-- TOC -->

- [Table of Contents](#table-of-contents)
- [Overview](#overview)
- [Images](#images)
- [Shortcodes](#shortcodes)
  - [Collapse](#collapse)
  - [Buttons](#buttons)
  - [Notices](#notices)
  - [Tabs](#tabs)
  - [Highlights](#highlights)
  - [gist](#gist)
  - [YouTube](#youtube)
  - [Vimeo](#vimeo)
  - [Twitter](#twitter)

<!-- /TOC -->

## Overview

_Testing all the things._

## Images

{{< image src="getting-started.jpg" class="h-auto" alt="image" zoomable="true" width="500px" height="380px">}}

## Shortcodes

### Collapse

{{< collapse "this is a simple collapse" >}}
This is the content that collapses
{{</ collapse >}}

### Buttons

<!-- internal link -->

{{< button label="Internal link" link="contact/" >}}

<!-- external link -->

{{< button label="External link" link="https://google.com/" >}}

### Notices

{{< notice note >}}This is a simple note{{</ notice >}}

{{< notice warning >}}This is a warning{{</ notice >}}

{{< notice tip >}}This is a tip{{</ notice >}}

{{< notice info >}}This is info{{</ notice >}}

### Tabs

{{< tabs >}}

{{< tab "first tab" >}}
This is first Tab Content
{{</ tab >}}

{{< tab "second tab" >}}
This is second Tab Content
{{</ tab >}}

{{< /tabs >}}

### Highlights

{{< highlight html >}}

<section class="section">
  <div class="container">
    <h1>Hello World!</h1>
  </div>
</section>
{{< /highlight >}}

{{< highlight shell >}}
cd hello-world

ls -lartH
{{< /highlight >}}

{{< highlight yaml >}}
key: value
another: - item1 - item2 - item3
{{< /highlight >}}

### gist

{{< gist MAHDTech 03806be9b5109e1bdd2d28e5d5d1ac10 >}}

### YouTube

{{< youtube w7Ft2ymGmfc >}}

### Vimeo

{{< vimeo 146022717 >}}

### Twitter

{{< tweet 877500564405444608 >}}
