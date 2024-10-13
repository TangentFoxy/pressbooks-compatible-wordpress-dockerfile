# I know this is bad practise, but I couldn't get it working with a specified version
FROM wordpress:latest

LABEL maintainer = "Tangent/Rose <tangent@tangentfox.com>"

RUN apt update && apt install -y \
  libxml2-utils \
  openjdk-17-jre \
  unzip \
  && rm -rf /var/lib/apt/lists/*

RUN curl -L -o /tmp/epubcheck.zip https://github.com/w3c/epubcheck/releases/download/v5.1.0/epubcheck-5.1.0.zip \
  && unzip /tmp/epubcheck.zip -d /tmp \
  && mkdir /opt/epubcheck \
  && cp -r /tmp/epubcheck-5.1.0/* /opt/epubcheck/ \
  && rm -r /tmp/*

RUN curl -L -o /tmp/prince.deb https://www.princexml.com/download/prince_15.4.1-1_debian12_amd64.deb \
  && apt install -y /tmp/prince.deb \
  && rm -r /tmp/*

RUN curl -L -o /tmp/saxonhe.zip https://sourceforge.net/projects/saxon/files/Saxon-HE/9.7/SaxonHE9-7-0-10J.zip/download \
  && mkdir /opt/saxon-he \
  && unzip /tmp/saxonhe.zip -d /opt/saxon-he \
  && mv /opt/saxon-he/saxon9he.jar /opt/saxon-he/saxon-he.jar \
  && rm -r /tmp/*
