# Columns

Columns help organize shorter pieces of content horizontally for readability.

## This example

```html
{{</* columns */>}} <!-- begin columns block -->

# Left Content

This is on the left...

<---> <!-- magic separator, between columns -->

# Mid Content

This is in the middle...

<---> <!-- magic separator, between columns -->

# Right Content

This is on the right...

{{</* /columns */>}}
```

## Renders the following

{{< columns >}}

This is on the left...

<--->

This is in the middle...
<--->

This is on the right...

{{< /columns >}}
