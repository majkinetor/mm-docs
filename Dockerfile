FROM openjdk:8-jre-alpine

ARG PLANTUML_VERSION=1.2021.14
ARG PLANTUML_DIR=/opt/plantuml
ARG PLANTUML_BIN=/usr/local/bin/plantuml
ARG PLANTUML_URL=https://sourceforge.net/projects/plantuml/files/plantuml.${PLANTUML_VERSION}.jar/download
ARG PLANTUML_SCRIPT='#!/bin/sh \njava -jar -Dfile.encoding=$PLANTUML_ENCODING /opt/plantuml/plantuml.jar ${@}\n'

ENV PLANTUML_ENCODING=en_US.UTF-8

RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/main" > /etc/apk/repositories \
    && echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories \
    && echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
    && echo "http://dl-cdn.alpinelinux.org/alpine/v3.12/main" >> /etc/apk/repositories \
    && apk update && apk upgrade -U -a

RUN apk add python3 python3-dev py3-pip nodejs npm \
    && python3 -m pip install --upgrade pip setuptools wheel \
    && npm install broken-link-checker -g

RUN apk add libstdc++ chromium harfbuzz nss freetype ttf-freefont font-noto-emoji wqy-zenhei
COPY local.conf /etc/fonts/local.conf

RUN apk add \
        curl git \
# weasyprint stuff
        gcc musl-dev jpeg-dev zlib-dev libffi-dev cairo-dev pango-dev gdk-pixbuf-dev g++

RUN apk add graphviz ttf-droid ttf-droid-nonlatin \
    && mkdir $PLANTUML_DIR \
    && curl -L $PLANTUML_URL -o $PLANTUML_DIR/plantuml.jar \
    && printf "$PLANTUML_SCRIPT" >> $PLANTUML_BIN \
    && chmod +x $PLANTUML_BIN

# Install chromium and puppeteer
ENV CHROME_BIN="/usr/bin/chromium-browser" \
    PUPPETEER_SKIP_CHROMIUM_DOWNLOAD="true" \
    CHROME_PATH=/usr/lib/chromium/

RUN set -x \
    && apk add udev ttf-freefont chromium \
    && npm install puppeteer --save

WORKDIR /docs
COPY requirements.txt .
RUN pip install -r requirements.txt
RUN rm /var/cache/apk/* && rm -rf /docs

WORKDIR /docs/source
CMD [ "mkdocs" ]
