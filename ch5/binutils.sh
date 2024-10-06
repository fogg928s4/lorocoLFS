#these are from the book which says u shouldnt just copy
mkdir -v build
cd build
pwd

../configure --prefix=$LFS/tools \
    --with-sysroot=$LFS \
    --target=$LFS_TGT \
    --disable-nls \
    --enable-gprofng=no \
    --disable-werror \
    --enable-default-hash-style=gnu \
&& make \
&& make install

#make compiles and installas. 
#disable-nls is for internationalization cus its not needed