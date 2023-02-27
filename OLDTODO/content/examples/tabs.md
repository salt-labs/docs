# Tabs

Tabs let you organize content by context, for example installation instructions for each supported platform.

## This example

```tpl
{{</* tabs "uniqueid" */>}}

{{</* tab "MacOS" */>}} ### MacOS Content {{</* /tab */>}}
{{</* tab "Linux" */>}} ### Linux Content {{</* /tab */>}}
{{</* tab "Windows" */>}} ### Windows Content {{</* /tab */>}}

{{</* /tabs */>}}
```

## Renders the following

{{< tabs "uniqueid" >}}

{{< tab "MacOS" >}}

### MacOS Content

{{< /tab >}}

{{< tab "Linux" >}}

### Linux Content

{{< /tab >}}

{{< tab "Windows" >}}

### Windows Content

{{< /tab >}}

{{< /tabs >}}
