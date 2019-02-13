# MM-DOCS

[![](https://images.microbadger.com/badges/image/majkinetor/mm-docs.svg)](https://microbadger.com/images/majkinetor/mm-docs "Get your own image badge on microbadger.com") [![](https://images.microbadger.com/badges/version/majkinetor/mm-docs.svg)](https://microbadger.com/images/majkinetor/mm-docs "Get your own version badge on microbadger.com")

This is a docker image that setups and runs documentation system designed for all types of project documentation and can be used in cross-platform manner.

The image is built upon Alpine linux and:

- [mkdocs](https://www.mkdocs.org/)<br>
Documentation system based on python and markdown
- [mkdocs-material](https://squidfunk.github.io/mkdocs-material/)<br>
Beautiful mkdos theme with number of extensions
- [plantuml](http://plantuml.com)<br>
Markup to make UML diagrams from text files

There is default configuration included with bunch of extensions and plugins.

## Prerequisites

- Requires docker to build and run
- Build system requires PowerShell

## Usage

You can use the system via standard docker command or via PowerShell build system Invoke-Build.

Via docker, pull the image first, then run mkdocs's command inside the image:

```powershell
docker pull majkinetor/mm-docs
docker run --name docs --rm -v ${pwd}:/docs mm-docs mkdocs build   # use `serve` to start web server
```

The PowerShell build system requires [Invoke-Build](https://github.com/nightroman/Invoke-Build) (alias `ib`, a cross-platform Powershell module).

```
PS> Invoke-Build ?

Name             Jobs                   Synopsis
----             ----                   --------
DockerBuild      {{}, DockerListImages} Build docker image
DockerListImages {}                     List docker images for docs project
DockerStop       {}                     Stop docker docs container if it is running
Run              {}                     Run docker image interactivelly with given command
Serve            {DockerStop, {}}       Serve docs project on http://localhost:8000
Build            {}                     Build mkdocs project into static site
```

## Quick start

- Edit [source/mkdocs.yml](source/mkdocs.yml) to set up static site details
- Add pages in [source/docs](source/docs) folder
- Add includables in [source/inc](source/inc) folder
- Run `ib Build` to compile static site or `ib Serve` to work on it real time

## Docker image

To build the fresh docker image run `ib DockerBuild`. 
