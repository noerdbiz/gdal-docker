#!/bin/bash

die() {
    exit 1
}

cd /tmp/ || die
wget http://www.freedesktop.org/software/harfbuzz/release/harfbuzz-0.9.37.tar.bz2 || die
tar xf harfbuzz-0.9.37.tar.bz2 || die
cd harfbuzz-0.9.37 || die
./configure  || die
make -j7 || die
sudo make install || die
sudo ldconfig || die

rm /tmp/harfbuzz-* -r || die
