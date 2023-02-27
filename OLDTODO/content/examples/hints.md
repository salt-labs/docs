# Hints

The `hint` shortcode can be used as hint/alerts/notification block.

There are 3 colors to choose:

1. `info`
1. `warning`
1. `danger`

## This example

```tpl
{{</* hint [info|warning|danger] */>}}

**Markdown content**

Lorem markdownum insigne. Olympo signis Delphis! Retexi Nereius nova develat
stringit, frustra Saturnius uteroque inter! Oculis non ritibus Telethusa

{{</* /hint */>}}
```

## Renders the following

{{< hint info >}}

**Markdown content**

Lorem markdownum insigne. Olympo signis Delphis! Retexi Nereius nova develat
stringit, frustra Saturnius uteroque inter! Oculis non ritibus Telethusa

{{< /hint >}}

{{< hint warning >}}

**Markdown content**

Lorem markdownum insigne. Olympo signis Delphis! Retexi Nereius nova develat
stringit, frustra Saturnius uteroque inter! Oculis non ritibus Telethusa

{{< /hint >}}

{{< hint danger >}}

**Markdown content**

Lorem markdownum insigne. Olympo signis Delphis! Retexi Nereius nova develat
stringit, frustra Saturnius uteroque inter! Oculis non ritibus Telethusa

{{< /hint >}}
