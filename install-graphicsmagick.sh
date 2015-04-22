#!/bin/bash
cd /opt/
wget http://ftp.icm.edu.pl/pub/unix/graphics/GraphicsMagick/1.3/GraphicsMagick-1.3.21.tar.gz
tar xf GraphicsMagick-1.3.21.tar.gz
cd GraphicsMagick-1.3.21/
./configure
make -j 7
make install