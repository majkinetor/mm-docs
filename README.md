# MM-DOCS

This is a docker image that setups and runs documentation system designed for all types of project documentation.

The image is built upon:

- [mkdocs](https://www.mkdocs.org/)<br>
Documentation system based on python and markdown
- [mkdocs-material](https://squidfunk.github.io/mkdocs-material/)<br>
Beautiful mkdos theme with number of extensions
- [plantuml](http://plantuml.com)<br>
Markup to make UML diagrams from text files

There is default configuration included with bunch of extensions and plugins.

## Usage

The build requires [Invoke-Build](https://github.com/nightroman/Invoke-Build) (alias `ib`, cross-platform Powershell module).

```
PS> Invoke-Build ?

Name             Jobs                   Synopsis
----             ----                   --------
DockerBuild      {{}, DockerListImages} Build docker image
DockerListImages {}                     List docker images for docs project
Run              {}                     Run docker image interactivelly with given command
Serve            {DockerStop, {}}       Serve docs project on http://localhost:8000
Build            {}                     Build mkdocs project into static site
DockerStop       {}                     Stop docker docs container if it is running
```

## Quick start

- Edit [source/mkdocs.yml](source/mkdocs.yml) to set up static site details
- Add pages in [source/docs] folder
- Add includables in [source/inc] folder
- Run `ib Build` to compile static site or `ib Serve` to work on it real time
