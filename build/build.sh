#!/bin/bash

RELEASE="10.7"
PREFIX="/opt/sagemath"

CURUSER="$(whoami)"

wget "https://github.com/sagemath/sage/archive/refs/tags/${RELEASE}.tar.gz" -O sage.tar.gz
mkdir -p src
tar zxvf sage.tar.gz -C src
cd src
make configure
sudo mkdir -p ${PREFIX}
sudo chown ${CURUSER}:${CURUSER} ${PREFIX} 
./configure ./configure --prefix=${PREFIX} --disable-editable
make 
mv ${PREFIX} ../deb/${PREFIX}
sudo chown root:root -R ../deb/${PREFIX}
echo -e "#!/bin/bash\nln -sf ${PREFIX}/bin/sage /usr/bin/sage" > ../deb/DEBIAN/postinst
dpkg-deb -b ../deb ../sagemath_${RELEASE}.deb
