cd $HOME
git clone https://github.com/qtumproject/FsLibc
cd FsLibc
cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_TOOLCHAIN_FILE=cross-toolchain.cmake -DCMAKE_INSTALL_PREFIX=$SYSROOT/usr .
make -C libc
make -C libc install
