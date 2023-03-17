---
title: Test
date: 2023-02-26T00:00:00+00:00
icon: "far fa-credit-card"
description: "Testing the site short codes."
type : "docs"
weight: 1
draft: true
---

_Testing all the things._

{{< collapse "this is a simple collapse" >}}
This is the content that collapse
{{</ collapse >}}

{{< notice note >}}This is a simple note{{</ notice >}}

{{< notice warning >}}This is a warning{{</ notice >}}

{{< notice tip >}}This is a tip{{</ notice >}}

{{< notice info >}}This is info{{</ notice >}}

{{< tabs >}}

  {{< tab "first tab" >}}
  This is first Tab Content
  {{< /tab >}}

  {{< tab "second tab" >}}
  This is second Tab Content
  {{< /tab >}}

{{< /tabs >}}

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
another:
    - item1
    - item2
    - item3
{{< /highlight >}}

{{< gist MAHDTech 03806be9b5109e1bdd2d28e5d5d1ac10 >}}

{{< youtube w7Ft2ymGmfc >}}

{{< vimeo 146022717 >}}

{{< instagram BQD9zQQFQZ >}}

{{< tweet 877500564405444608 >}}
