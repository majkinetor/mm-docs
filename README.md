# MM-DOCS

[![](https://img.shields.io/docker/v/majkinetor/mm-docs/0.6.2?label=mm-docs)](https://hub.docker.com/r/majkinetor/mm-docs)  ![](https://img.shields.io/docker/pulls/majkinetor/mm-docs) &nbsp;&nbsp;&nbsp;&nbsp; [TEMPLATE](https://github.com/majkinetor/mm-docs-template)

This is a docker image that setups and runs documentation system designed for all types of project documentation and can be used in cross-platform manner. This repository is not used directly when writing documentation and its purpose is to improve the mm-docs itself. 

**To start writing, clone/use [mm-docs-template](https://github.com/majkinetor/mm-docs-template.git)**.

## About docker image

The image is built upon Alpine linux and:

- [mkdocs](https://www.mkdocs.org/)<br>
Documentation system based on python and markdown
- [mkdocs-material](https://squidfunk.github.io/mkdocs-material/)<br>
Beautiful mkdos theme with number of extensions
- [plantuml](http://plantuml.com)<br>
Markup to make UML diagrams from text files
- [Headless Chrome with Puppeter](https://developers.google.com/web/tools/puppeteer/)<br>
Automation system for generating PDF export and can be used in general
- [Broken Link Checker](https://github.com/stevenvachon/broken-link-checker)<br>
Command line tool to check for broken links
- Number of mkdocs and markdown extensions and plugins

## Prerequisites

- Docker to build, serve and develop
  - On Windows: `choco install docker-desktop`
- PowerShell for the convenient task system (optional)
    - [Invoke-Build](https://github.com/nightroman/Invoke-Build): `Install-Module InvokeBuild`

## Usage

Run `Invoke-Build ?` to get the list of available tasks. Most important ones are given bellow.

|                       Command            |                  Description                   |
| ---------------------------------------- | ---------------------------------------------- |
| `ib Build`                               | Build docker image                             |
| `ib Build, GetVersions -aLatestModules ` | Build docker image with all components updated |

where `ib` is alias to Invoke-Build.
