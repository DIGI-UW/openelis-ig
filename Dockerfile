FROM eclipse-temurin:21-jre

RUN apt-get update && apt-get install -y \
  bash \
  curl \
  ruby-full \
  build-essential \
  nodejs \
  npm && rm -rf /var/lib/apt/lists/*

WORKDIR /ig

COPY _updatePublisher.sh _genonce.sh ./

RUN chmod +x _genonce.sh _updatePublisher.sh

RUN ./_updatePublisher.sh -y

RUN gem install jekyll

RUN npm install -g fsh-sushi

RUN sushi -v

COPY ./input /ig/input
COPY ./local-template /ig/local-template
COPY ig.ini /ig/ig.ini
COPY sushi-config.yaml /ig/sushi-config.yaml

VOLUME /ig/output

ENTRYPOINT ["/bin/bash", "./_genonce.sh"]
