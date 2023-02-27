# KaTeX

KaTeX shortcode let you render math typesetting in markdown document. See [KaTeX](https://katex.org/)

## This example

```latex
{{</* katex [display] [class="text-center"]  */>}}

f(x) = \int_{-\infty}^\infty\hat f(\xi)\,e^{2 \pi i \xi x}\,d\xi

{{</* /katex */>}}
```

## Renders the following

- Using `display`

{{< katex display >}}

f(x) = \int_{-\infty}^\infty\hat f(\xi)\,e^{2 \pi i \xi x}\,d\xi

{{< /katex >}}

- Using `class`

{{< katex class="text-center" >}}

f(x) = \int_{-\infty}^\infty\hat f(\xi)\,e^{2 \pi i \xi x}\,d\xi

{{< /katex >}}

## Inline

You can also use it like this {{< katex >}}\pi(x){{< /katex >}}, to have it render on the same line.
