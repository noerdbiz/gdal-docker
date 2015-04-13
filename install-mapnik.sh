#!/bin/bash


die() {
    exit 1
}

cd /tmp/ || die
git clone https://github.com/mapnik/mapnik  || die
cd mapnik || die
./configure || die
make -j7 || die
sudo make install || die

rm /tmp/mapnik -r || die
