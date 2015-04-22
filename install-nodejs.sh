#!/bin/bash

die() {
    exit 1
}

cd /tmp/ || die
wget http://nodejs.org/dist/node-latest.tar.gz || die
tar xvzf node-latest.tar.gz || die
rm -f node-latest.tar.gz || die
cd node-v* || die
./configure || die
CXX="g++ -Wno-unused-local-typedefs" make -j7 || die
CXX="g++ -Wno-unused-local-typedefs" make install || die
cd /tmp/ || die
rm -rf /tmp/node-v* || die
npm install -g npm || die
printf '\n# Node.js\nexport PATH="node_modules/.bin:$PATH"' >> /root/.bashrc || die
