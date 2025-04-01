FROM eclipse-temurin:21-jre

RUN apt-get update && apt-get install -y \
  bash \
  curl \
  ruby-full \
  build-essential \
  nodejs \
  dos2unix \
  npm && rm -rf /var/lib/apt/lists/*

WORKDIR /ig

COPY _updatePublisher.sh /ig/_updatePublisher.sh
COPY _genonce.sh /ig/_genonce.sh

RUN dos2unix -ascii /ig/_genonce.sh /ig/_updatePublisher.sh

RUN chmod +x /ig/_genonce.sh /ig/_updatePublisher.sh

RUN /ig/_updatePublisher.sh -y

RUN gem install jekyll

RUN npm install -g fsh-sushi

RUN sushi -v

COPY ig.ini /ig/ig.ini
COPY ./local-template /ig/local-template
COPY sushi-config.yaml /ig/sushi-config.yaml
COPY ./input /ig/input

VOLUME /ig/output

ENTRYPOINT ["/bin/bash", "./_genonce.sh"]
