





echo "mkdir rootfs and cd busyboxy to build,please waitting..."  
mkdir rootfs 
cd busybox-1.19.4
make install
echo "busyboxy build install success.Go back to .. and cd rootfs."  
cd ..
cd rootfs  
echo "Create root,dev,etc,boot,tmp,var,sys,proc,lib,mnt,home,usr."  
mkdir root dev etc boot tmp var sys proc lib mnt home usr   
echo "Create etc/init.d etc/rc.d etc/sysconfig."  
mkdir etc/init.d etc/rc.d etc/sysconfig  
echo "Create usr/sbin usr/bin usr/lib usr/modules."  
mkdir usr/sbin usr/bin usr/lib usr/modules  
echo "make node in dev/console dev/null."  
 mknod -m 600 dev/console c 5 1  
 sudo mknod -m 600 dev/null  c 1 3  
 m mnt/etc mnt/jffs2 mnt/yaffs mnt/data mnt/temp  
mkdir var/lib var/lock var/run var/tmp  
chmod 1777 tmp  
chmod 1777 var/tmp  

echo "begin to create inittab rcS fstab..." 
touch ./etc/inittab
chmod a+x ./etc/inittab
echo "::sysinit:/etc/init.d/rcS" > ./etc/inittab  
echo "console::askfirst:-/bin/sh" >> ./etc/inittab
echo "::restart:/sbin/init" >> ./etc/inittab  
echo "::ctrlaltdel:/sbin/reboot" >> ./etc/inittab  
echo "::shutdown:/bin/umount -a -r" >> ./etc/inittab  
echo "::shutdown:/sbin/swapoff -a" >> ./etc/inittab

touch ./etc/rcS
chmod a+x ./etc/rcS
echo "echo "----------mount all.........."" >> ./etc/rcS  
echo "mount -a" >> ./etc/rcS  
echo "echo "----------Starting mdev......"" >> ./etc/rcS
echo "echo /sbin/mdev > /proc/sys/kernel/hotplug" >> ./etc/rcS
echo "mdev -s" >> ./etc/rcS 
echo "/bin/hostname -F /etc/sysconfig/HOSTNAME" >> ./etc/rcS

touch ./etc/fstab
chmod a+x ./etc/fstab
echo "#evice mount-point type  option  dump fsck order" >> ./etc/fstab
echo "proc /proc proc defaults 0 0" >> ./etc/fstab
echo "none /tmp ramfs defaults 0 0" >> ./etc/fstab
echo "mdev /dev ramfs defaults 0 0" >> ./etc/fstab 
echo "sysfs /sys sysfs defaults 0 0" >> ./etc/fstab

touch ./etc/profile
chmod a+x ./etc/profile
echo "PATH=/bin:/sbin:/usr/bin:/usr/sbin" >> ./etc/profile
echo "export PATH" >> ./etc/profile  
echo "#set hostname" >> ./etc/profile    
echo "HOSTNAME='/bin/hostname'" >> ./etc/profile    
echo "export HOSTNAME" >> ./etc/profile    
echo "# Set PS1" >> ./etc/profile
echo "PS1='[\u@\h \W]\$'" >> ./etc/profile
echo "export PS1" >> ./etc/profile

cp /etc/passwd ./etc/
cp /etc/group ./etc/

touch ./etc/sysconfig/HOSTNAME
echo "admin" >> ./etc/sysconfig/HOSTNAME
echo "end to create inittab rcS fstab..." 
echo "begin -> cp *so* to ./lib ./usr/lib." 


echo "end -> cp *so* to ./lib ./usr/lib." 


