FROM ubuntu:20.04

ENV DEBIAN_FRONTEND noninteractive
ENV LANG C.UTF-8

RUN apt-get update && apt-get -y dist-upgrade

# Install required tools
RUN apt-get install -y wget unzip

# Install Chrome
RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb

RUN apt-get install -y ./google-chrome-stable_current_amd64.deb

# Install matching chromedriver
COPY install_chromedriver.sh /opt/install_chromedriver.sh
RUN bash /opt/install_chromedriver.sh

# Cleanup
RUN apt-get -y purge unzip \
    && apt-get -y --purge autoremove \
	&& apt-get -y autoclean \
	&& apt-get -y clean \
	&& rm -rf /var/lib/apt/lists/* \
    && rm /opt/install_chromedriver.sh

RUN groupadd -g 1000 localuser \
	&& useradd -u 1000 -g 1000 -m localuser

USER localuser

# Make chromedriver container stop faster
STOPSIGNAL SIGKILL

# Start chromdriver with no access restrictions!
ENTRYPOINT ["/usr/local/bin/chrome-linux64/chrome", "--allowed-ips", "--allowed-origins=*"]

EXPOSE 9515
