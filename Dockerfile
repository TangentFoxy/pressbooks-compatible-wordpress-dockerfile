# I know this is bad practise, but I couldn't get it working with a specified version
FROM wordpress:latest

LABEL maintainer = "Tangent/Rose <tangent@tangentfox.com>"

RUN apt update && apt install -y \
  openjdk-17-jre \
  unzip \
  && rm -rf /var/lib/apt/lists/*

RUN curl -L -o /tmp/epubcheck.zip https://github.com/w3c/epubcheck/releases/download/v5.1.0/epubcheck-5.1.0.zip \
  && unzip /tmp/epubcheck.zip -d /tmp \
  && mkdir /opt/epubcheck \
  && cp -r /tmp/epubcheck-5.1.0/* /opt/epubcheck/ \
  && rm -r /tmp/*
