#!/bin/bash
apt-get update -y && apt-get install -y build-essential \ 
	g++ \
	flex \
	bison \
	gperf \
	ruby \
	perl \
  	libsqlite3-dev \
  	libfontconfig1-dev \
  	libicu-dev \
  	libfreetype6 \
  	libssl-dev \
  	libpng-dev \
  	libjpeg-dev

cd /opt/
mkdir phantomJS
cd phantomJS
git clone git://github.com/ariya/phantomjs.git
cd phantomjs
git checkout 2.0
./build.sh --confirm --jobs 8
ln -s /opt/phantomJS/phantomjs/bin/phantomjs /usr/bin/phantomjs