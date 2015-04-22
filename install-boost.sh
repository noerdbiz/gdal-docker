#!/bin/bash

cd /tmp/
wget http://downloads.sourceforge.net/project/boost/boost/1.57.0/boost_1_57_0.tar.gz
tar xf boost_1_57_0.tar.gz
cd boost_1_57_0
./bootstrap.sh
./b2 install -j8 --prefix=/opt/boost --exec-prefix=/opt/boost --libdir=/opt/boost --include-dir=/opt/boost --build-dir=/opt/boost
cd ..
rm boost_1_57_0 -r
