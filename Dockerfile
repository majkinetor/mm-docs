# https://github.com/anapsix/docker-alpine-java
FROM anapsix/alpine-java:latest 

#ENV http_proxy http://IP:8080
#ENV https_proxy http://IP:8080
ENV PLANTUML_VERSION 1.2019.0
ENV PLANTUML_ENCODING en_US.UTF-8

ENV PLANTUML_BIN /usr/local/bin/plantuml
COPY bin/plantuml /usr/local/bin/plantuml

RUN apk add --no-cache graphviz ttf-droid ttf-droid-nonlatin curl \
    && mkdir /app \
    && curl -L https://sourceforge.net/projects/plantuml/files/plantuml.${PLANTUML_VERSION}.jar/download -o /app/plantuml.jar \
    && chmod +x /usr/local/bin/plantuml

CMD [ "plantuml -h" ]
