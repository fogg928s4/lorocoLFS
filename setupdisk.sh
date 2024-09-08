
LFS_DISK="$1"
#this executes the fdisk program along with its commands
#use sudo fdisk /dev/sdb m to see wtf they do
sudo fdisk "$LFS_DISK" << EOF
o
n
p
1

+100M
a
n
p
2


p
w
q
EOF
#making files sys (mkfs) for the partitions
sudo mkfs -t ext2 -F "${LFS_DISK}1"
sudo mkfs -t ext2 -F "${LFS_DISK}2"
