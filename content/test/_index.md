---
title: Test
date: 2023-02-26T00:00:00+00:00
icon: "far fa-credit-card"
description: "Testing the site short codes."
type : "docs"
---

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

{{< youtube w7Ft2ymGmfc >}}

{{< vimeo 146022717 >}}

{{< tweet 877500564405444608 >}}
