# MM-DOCS

[![](https://images.microbadger.com/badges/image/majkinetor/mm-docs.svg)](https://microbadger.com/images/majkinetor/mm-docs "Get your own image badge on microbadger.com") [![](https://images.microbadger.com/badges/version/majkinetor/mm-docs:0.2.svg)](https://microbadger.com/images/majkinetor/mm-docs:0.2 "Get your own version badge on microbadger.com")

This is a docker image that setups and runs documentation system designed for all types of project documentation and can be used in cross-platform manner.

The image is built upon Alpine linux and:

- [mkdocs](https://www.mkdocs.org/)<br>
Documentation system based on python and markdown
- [mkdocs-material](https://squidfunk.github.io/mkdocs-material/)<br>
Beautiful mkdos theme with number of extensions
- [plantuml](http://plantuml.com)<br>
Markup to make UML diagrams from text files
- Number of extensions and plugins.

## Prerequisites

- Requires docker to build and run
- Build system requires PowerShell

## Usage

To start writing, clone/use [mm-docs-template](https://github.com/majkinetor/mm-docs-template.git).

The PowerShell build system requires [Invoke-Build](https://github.com/nightroman/Invoke-Build) (alias `ib`, a cross-platform Powershell module).

|                       Command                       |                  Description                   |
| --------------------------------------------------- | ---------------------------------------------- |
| `ib Build`                                          | Build docker image                             |
| `ib Build, GetVersions -aLatestModules -aTag 0.2.1` | Build docker image with all components updated |

Run `Invoke-Build ?` to get the list of other available tasks.

