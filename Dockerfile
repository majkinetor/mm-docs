# https://github.com/anapsix/docker-alpine-java
FROM anapsix/alpine-java:latest 

ENV PLANTUML_VERSION 1.2019.0
ENV PLANTUML_ENCODING en_US.UTF-8

ENV PLANTUML_BIN /usr/local/bin/plantuml
COPY bin/plantuml /usr/local/bin/plantuml

RUN apk update

RUN apk add curl git

RUN apk add graphviz ttf-droid ttf-droid-nonlatin \
    && mkdir /app \
    && curl -L https://sourceforge.net/projects/plantuml/files/plantuml.${PLANTUML_VERSION}.jar/download -o /app/plantuml.jar \
    && chmod +x /usr/local/bin/plantuml

RUN apk add python3 \
    && python3 -m pip install --upgrade pip

RUN pip install                 \
        mkdocs                  \
        mkdocs-material         \
        markdown-include        \
        git+https://github.com/exaroth/mdx_custom_span_class.git

RUN rm /var/cache/apk/*

CMD [ "sh" ]