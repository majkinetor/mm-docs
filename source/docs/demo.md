# Demonstration page

For more details see:

- [Mkdcos Material Extensions](https://squidfunk.github.io/mkdocs-material/extensions/admonition)

## Typography

- **Bold text**
- *Italic text*
- ~~Strike Through~~
- __underline__
- ==Colored text==
- `Inline code`
- Hotkeys: ++enter++, ++"PgDown"++ ++"Non Existent Key"++
- Unicode: Мислим дакле постојим

## Links, footnotes and comments

- [I'm an inline-style link](https://www.google.com)
- [I'm an inline-style link with title](https://www.google.com "Google's Homepage")
- [I'm a reference-style link][arbitrary reference text]
- [I'm a relative reference to a repository file](./index)
- [You can use numbers for reference-style link definitions][1]
- You can leave a link empty and use the [link text itself]
- I am a text with footnote[^wiki].

**Magic links and emails:** turned to links as recognized

- http://www.google.com
- majkinetor@gmail.com
- www.google.com

The text contains 2 comments bellow this line which should not be visible.
[comment]: # (Developed using Visual Studio Code with plantuml extension: cinst visualstudiocode; code --install-extension jebbs.plantuml)
[comment]: # (PlantUML version may influence diagrams. This document is developped with 1.2017.15: cinst plantuml --version 1.2017.15)

[arbitrary reference text]: https://www.mozilla.org
[1]: http://slashdot.org
[link text itself]: http://www.reddit.com
[^wiki]: https://en.wikipedia.org/wiki/Note_(typography)

## Citations

> Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla et euismod nulla. Curabitur feugiat, tortor non consequat finibus, justo purus auctor  massa, nec semper lorem quam in massa.
> Inline:
> > Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla et euismod nulla. Curabitur feugiat, tortor non consequat finibus, justo purus auctor  massa, nec semper lorem quam in massa.
> ```
> code in citations
> ```
> Another citation line

## Critic and comments

Here is some {--*incorrect*--} Markdown.  I am adding this{++ here++}.  Here is some more {--text that I am removing--}text.  And here is even more {++text that I  am ++}adding.
{~~

~>  ~~}Paragraph was deleted and replaced with some spaces.{~~  ~>

~~}Spaces were removed and a paragraph was added.

And here is a comment on {==some text==}{>>This works quite well. I just wanted to comment on it.<<}. Substitutions {~~is~>are~~} great!

General block handling:

{--

* test remove
* test remove

--}

{++

* test add
* test add

++}


## Emoji

[More info](https://www.emojicopy.com/)

- `:tada`: :tada:
- `:jack_o_lantern:` :jack_o_lantern: 
- `:alien:` :alien: 
- `:robot_face:` :robot_face: 
- `:smile:` :smile: 
- `:heart:` :heart: 
- `:thumbsup:` :thumbsup:

## Lists

### Ordered list

1. List item 1
2. List item 2
    1. List item 2.1
    2. List item 2.2
        1. List item 2.2.1
        2. List item 2.2.2
    3. List item 2.3
3. List item 4

### Unordered, mixed

- List item 1
- List item 2
    - List item 2.1
    - List item 2.2
        1. List item 2.2.1
        1. List item 2.2.2
    - List item 2.3
- List item 4

## Tables

|  Col1  |         Col2         |
| ------ | -------------------- |
| row1.1 | row1.2               |
| row2.1 | row2.2-1<br>row2.2-2 |

## Plantuml

```plantuml format="svg"
title Hijerarhija
(1) --> (1)
(2) --> (1)
(4) --> (1)
(5) --> (1)
(7) --> (7)
(8) --> (8)
(6) --> (6)
```

## MathJax

$$
\frac{n!}{k!(n-k)!} = \binom{n}{k}
$$

Lorem ipsum dolor sit amet: $p(x|y) = \frac{p(y|x)p(x)}{p(y)}$

## Admonition

[More info](https://squidfunk.github.io/mkdocs-material/extensions/admonition/)

!!! note
    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla et euismod
    nulla. Curabitur feugiat, tortor non consequat finibus, justo purus auctor
    massa, nec semper lorem quam in massa.

??? question "Collapsed closed"
    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla et euismod
    nulla. Curabitur feugiat, tortor non consequat finibus, justo purus auctor
    massa, nec semper lorem quam in massa.    

???+ question "Collapsed open"
    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla et euismod
    nulla. Curabitur feugiat, tortor non consequat finibus, justo purus auctor
    massa, nec semper lorem quam in massa.        

!!! danger "Extreme danger"
    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla et euismod
    nulla. Curabitur feugiat, tortor non consequat finibus, justo purus auctor
    massa, nec semper lorem quam in massa.

    ```
    some code
    ```

    > Some citation

## Code Highlight

```python
import tensorflow as tf
```

With tabs:

```bash tab="Bash"
#!/bin/bash

echo "Hello world!"
```

```powershell tab="PowerShell"
"Hello world!"
```

```plantuml tab="UML"
Bob -> Alice : Hello world!
```

```c tab="C"
#include <stdio.h>

int main(void) {
  printf("Hello world!\n");
}
```

```c++ tab="C++"
#include <iostream>

int main() {
  std::cout << "Hello world!" << std::endl;
  return 0;
}
```

```c# tab="C#"
using System;

class Program {
  static void Main(string[] args) {
    Console.WriteLine("Hello world!");
  }
}
```

## Abbreviations

- IT, XML, JSON

## Smart symbols

- `(tm)` (tm)
- `(c)`	(c)
- `c/o`	c/o
- `+/-` +/-
- `-->` -->
- `<--` <--
- `<-->` <-->
- `=/=` =/=
- `1/4` 1/4
- `1st` 1st

## Task list

* [x] Lorem ipsum dolor sit amet, consectetur adipiscing elit
* [x] Curabitur elit nibh, euismod et ullamcorper at, iaculis feugiat est
* [ ] Vestibulum convallis sit amet nisi a tincidunt
    * [x] In hac habitasse platea dictumst
    * [ ] Praesent sed risus massa
* [ ] Nulla vel eros venenatis, imperdiet enim id, faucibus nisi

{!_inc/footer.md!}
