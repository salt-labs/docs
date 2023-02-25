# Mermaid Chart

[MermaidJS](https://mermaid-js.github.io/) is library for generating svg charts and diagrams from text.

{{< hint info >}}

**Mermaid Initialization Config**

If you need to override the [initialization config](https://mermaid-js.github.io/mermaid/#/Setup) for Mermaid,
create a `mermaid.json` file in your `assets` folder!

{{< /hint >}}

## This example

```tpl
{{</* mermaid [class="text-center"]*/>}}
flowchart LR

    %%objects

    a[Item A]
    b[Item B]
    c[Item C]
    d[Item D]

    %%connections

    a --> b
    b --> c
    c --> d

{{</* /mermaid */>}}
```

## Renders the following

{{< mermaid >}}
flowchart LR

    %%objects

    a[Item A]
    b[Item B]
    c[Item C]
    d[Item D]

    %%connections

    a --> b
    b --> c
    c --> d

{{< /mermaid >}}
