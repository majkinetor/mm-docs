# MM-DOCS

[![](https://img.shields.io/docker/v/majkinetor/mm-docs/0.3.6?label=mm-docs)](https://hub.docker.com/r/majkinetor/mm-docs) ![](https://img.shields.io/docker/pulls/majkinetor/mm-docs) [TEMPLATE](https://github.com/majkinetor/mm-docs-template)

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

- Docker to build, serve and develop
- PowerShell for the convenient task system (optional)

## Usage

To start writing, clone/use [mm-docs-template](https://github.com/majkinetor/mm-docs-template.git) - this repository is not used directly when writing documentation. This repository is used to improve the mm-docs itself.

The project uses cross-platform PowerShell build system [Invoke-Build](https://github.com/nightroman/Invoke-Build).

|                       Command                       |                  Description                   |
| --------------------------------------------------- | ---------------------------------------------- |
| `ib Build`                                          | Build docker image                             |
| `ib Build, GetVersions -aLatestModules -aTag 0.2.1` | Build docker image with all components updated |

Run `Invoke-Build ?` to get the list of other available tasks.
