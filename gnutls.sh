#!/bin/bash

GNUTLS_VERSION="3.2.15"

. mingw.sh

if [ ! -f gnutls-$GNUTLS_VERSION.tar.lz ] ; then
	wget ftp://ftp.gnutls.org/gcrypt/gnutls/v3.2/gnutls-$GNUTLS_VERSION.tar.lz
fi
rm -rf gnutls-$GNUTLS_VERSION
tar --lzip -xf gnutls-$GNUTLS_VERSION.tar.lz
rm -rf gnutls

pushd gnutls-$GNUTLS_VERSION

export LDFLAGS="-L$PREFIX/gmp/lib"
export PKG_CONFIG_PATH="$PREFIX/nettle/lib/pkgconfig"
export GMP_CFLAGS="-I$PREFIX/gmp/include"
export GMP_LIBS="-lgmp"
./configure --prefix=$PREFIX/gnutls --host=$TOOLCHAINPREFIX --enable-shared --disable-static
make
make install

popd

$TOOLCHAINPREFIX-dlltool --def gnutls/bin/libgnutls-28.def --dllname libgnutls-28.dll --output-lib gnutls/lib/libgnutls-28.lib

