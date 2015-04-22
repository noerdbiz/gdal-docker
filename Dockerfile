##
# systemapic/gis
#
# GDAL 1.11.2, released 2015/02/10
# Mapnik v3.0.0-pre
# Boost v1.58.0
# Node.js v.0.12.2
# GraphicsMagick 1.3.21 2015-02-28 Q8 http://www.GraphicsMagick.org/
# PhantomJS 2.0.1-development
# HPN SSH OpenSSH_6.6.1p1-hpn14v5 Ubuntu-5hpn14v5~wrouesnel~trusty2, OpenSSL 1.0.1f 6 Jan 2014

# Ubuntu 14.04 Trusty Tahyr
FROM ubuntu:trusty

MAINTAINER Knut Ole Sjøli <knutole@systemapic.com>

# Install basic dependencies
RUN apt-get update -y && apt-get install -y \
    software-properties-common \
    python-software-properties \
    build-essential \
    wget \
    subversion \
    openjdk-7-jdk \
    mysql-client \
    mysql-server \
    unzip nmap pigz zip fish htop nano


# Install Postgresql
ADD ./install-postgres.sh /tmp/
RUN sh /tmp/install-postgres.sh

# Install Postgis
ADD ./install-postgis.sh /tmp/
RUN sh /tmp/install-postgis.sh

# Get the GDAL source
ADD ./gdal-checkout.txt /tmp/gdal-checkout.txt
ADD ./get-gdal.sh /tmp/
RUN sh /tmp/get-gdal.sh

# Install the GDAL source dependencies
ADD ./install-gdal-deps.sh /tmp/
RUN sh /tmp/install-gdal-deps.sh

# Install GDAL itself
ADD ./install-gdal.sh /tmp/
RUN sh /tmp/install-gdal.sh

# Install Mapnik dependencies
# RUN apt-add-repository ppa:boost-latest/ppa
RUN apt-add-repository ppa:mapnik/boost
# RUN echo 'deb http://ppa.launchpad.net/boost-latest/ppa/ubuntu saucy main ' >> /etc/apt/sources.list
RUN apt-get update -y && apt-get install -y \ 
    libboost-dev \
    software-properties-common python-software-properties \
    libboost-filesystem-dev libboost-program-options-dev \
    libboost-python-dev libboost-regex-dev libboost-system-dev libboost-thread-dev \
    libboost-filesystem-dev \
    libboost-program-options-dev \
    libboost-python-dev libboost-regex-dev \
    libboost-system-dev libboost-thread-dev libtiff5 libtiff5-dev \
    libicu-dev \
    python-dev libxml2 libxml2-dev \
    libfreetype6 libfreetype6-dev \
    libjpeg-dev \
    libpng-dev \
    libproj-dev \
    libtiff-dev \
    libcairo2 libcairo2-dev python-cairo python-cairo-dev \
    libcairomm-1.0-1 libcairomm-1.0-dev \
    ttf-unifont ttf-dejavu ttf-dejavu-core ttf-dejavu-extra \
    git build-essential python-nose \
    libgdal1-dev libsqlite3-dev || die

# Install latest boost
ADD ./install-boost.sh /tmp/
RUN sh /tmp/install-boost.sh

# Install Mapnik dependencies
ADD ./install-mapnik-dependencies.sh /tmp/
RUN sh /tmp/install-mapnik-dependencies.sh

# Install Mapnik
ADD ./install-mapnik.sh /tmp/
RUN sh /tmp/install-mapnik.sh

# Install Node.js
ADD ./install-nodejs.sh /tmp/
RUN sh /tmp/install-nodejs.sh

# Install npm extras
RUN npm install grunt-cli -g
RUN npm install nodemon -g
RUN npm install forever -g

# Install PhanomJS
ADD ./install-phantomjs.sh /tmp/install-phantomjs.sh
RUN sh /tmp/install-phantomjs.sh

# Install Graphics Magick
ADD ./install-graphicsmagick.sh /tmp/install-graphicsmagick.sh
RUN sh /tmp/install-graphicsmagick.sh

# Run the tests
ADD ./test-gdal.sh /tmp/
RUN sh /tmp/test-gdal.sh

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Externally accessible data is by default put in /data
WORKDIR /data
VOLUME ["/data"]

# Execute the gdal utilities as root
USER root

# Output version and capabilities by default.
CMD gdalinfo --version && gdalinfo --formats && ogrinfo --formats
