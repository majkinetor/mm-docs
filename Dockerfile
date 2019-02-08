# https://github.com/anapsix/docker-alpine-java
FROM anapsix/alpine-java:latest 

ARG PLANTUML_VERSION=1.2019.0
ARG PLANTUML_DIR=/opt/plantuml
ARG PLANTUML_BIN=/usr/local/bin/plantuml
ARG PLANTUML_URL=https://sourceforge.net/projects/plantuml/files/plantuml.${PLANTUML_VERSION}.jar/download
ARG PLANTUML_SCRIPT='#!/bin/sh \njava -jar -Dfile.encoding=$PLANTUML_ENCODING /opt/plantuml/plantuml.jar ${@}\n'

ENV PLANTUML_ENCODING=en_US.UTF-8

RUN apk update

RUN apk add \
        curl git \
# weasyprint stuff                                                                
        gcc musl-dev jpeg-dev zlib-dev libffi-dev cairo-dev pango-dev gdk-pixbuf-dev

RUN apk add graphviz ttf-droid ttf-droid-nonlatin \
    && mkdir $PLANTUML_DIR \
    && curl -L $PLANTUML_URL -o $PLANTUML_DIR/plantuml.jar \
    && printf "$PLANTUML_SCRIPT" >> $PLANTUML_BIN \
    && chmod +x $PLANTUML_BIN

RUN apk add python3 python3-dev \
    && python3 -m pip install --upgrade pip setuptools

RUN pip install mkdocs mkdocs-material plantuml-markdown

RUN pip install \
    markdown-include \
    mkdocs-exclude  \
    mkdocs-macros-plugin \
    mkdocs-pdf-export-plugin \
    git+https://github.com/exaroth/mdx_custom_span_class.git

RUN rm /var/cache/apk/*

EXPOSE 8000
WORKDIR /docs/source

CMD [ "sh" ]