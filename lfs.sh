#!/bin/bash

#remember to create the /mnt/lfs directory

export LFS=/mnt/lfs #variable delcared
export LFS_TGT=x86_64-lfs-linux-gnu #triple for 64 bit, on linux, from gnu license
export LFS_DISK=/dev/sdb #find device name with sudo dmesg

#avoid formatting disk several times and avoid downloaing
#everything again well check this mount

if ! grep -q "$LFS" /proc/mounts; then  #what systems are mounterd
  source setupdisk.sh "$LFS_DISK"
  sudo mount "${LFS_DISK}2" "$LFS"
  sudo chown -v $USER "$LFS"
fi

mkdir -pv $LFS/sources #downloaded from lfs into here
mkdir -pv $LFS/tools #requires root priv but we put our own user as god

mkdir -pv $LFS/boot
mkdir -pv $LFS/etc
mkdir -pv $LFS/bin
mkdir -pv $LFS/lib
mkdir -pv $LFS/sbin
mkdir -pv $LFS/usr
mkdir -pv $LFS/var

#echo $LFS_TGT | greo -qs '64'; then #just to check if its 64 bit
#leave if  u want or not, idc
#  mkdir4 -pv $LFS/lib64
#fi
#another way to do whats before
#cross tool check that still runs on a

case $(uname -m) in

   x86_64) mkdir -pv $LFS/lib64;;

esac

#do we really want to work in the sd? no but it is what it is

cp -rf *.sh packages.csv "$LFS/sources"
cd "$LFS/sources"

#for the cross compiler
export PATH="$LFS/tool/bin:$PATH"

source download.sh
