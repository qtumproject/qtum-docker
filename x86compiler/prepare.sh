#!/bin/bash
cd $HOME
git clone https://github.com/qtumproject/x86-toolchain.git x86-compiler
cd x86-compiler

export TARGET=i686-elf
export SYSROOT="$HOME/x86-compiler/sysroot"

mkdir build-binutils
cd build-binutils
../binutils-2.29/configure --target="$TARGET" --prefix="$PREFIX" --disable-werror
make
make install
cd ..
mkdir build-gcc
cd build-gcc
../gcc-7.2.0/configure --target="$TARGET" --prefix="$PREFIX" --enable-languages=c,c++
make all-gcc
make all-target-libgcc
make install-gcc
make install-target-libgcc

cd $HOME
git clone https://github.com/qtumproject/FsLibc
cd FsLibc
cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_TOOLCHAIN_FILE=cross-toolchain.cmake -DCMAKE_INSTALL_PREFIX=$SYSROOT/usr .
make -C libc
make -C libc install

cd $HOME
cd x86-compiler
cd crtfiles
make
cd ..
mkdir -p $SYSROOT/usr/lib
mkdir -p $SYSROOT/usr/include
cp crtfiles/*.o $SYSROOT/usr/lib/
cp -r includes/* $SYSROOT/usr/include/

cd $HOME
export TARGET=i686-qtum

cd x86-compiler
rm -rf build-binutils
mkdir build-binutils
cd build-binutils
../binutils-2.29/configure --target=$TARGET --prefix="$PREFIX" --with-sysroot="$SYSROOT" --disable-werror
make
make install


cd ..
rm -rf build-gcc
mkdir build-gcc
cd build-gcc
../gcc-7.2.0/configure --target=$TARGET --prefix="$PREFIX" --with-sysroot="$SYSROOT" --enable-languages=c,c++
make all-gcc
make all-target-libgcc
make install-gcc
make install-target-libgcc

cd ..
rm -rf build-binutils
rm -rf build-gcc

cd $HOME
git clone https://github.com/qtumproject/libqtum
cd libqtum
make
make deploy
