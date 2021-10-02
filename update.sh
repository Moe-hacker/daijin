if [[ ! -e /data/data/com.termux/files/usr/etc/container.conf.d ]];then
  mkdir /data/data/com.termux/files/usr/etc/container.conf.d
  echo NAME=Default >> /data/data/com.termux/files/usr/etc/container.conf
  echo CUSOR=block >> /data/data/com.termux/files/usr/etc/container.conf
  mv /data/data/com.termux/files/usr/etc/container.conf /data/data/com.termux/files/usr/etc/container.conf.d/container-1.conf
  echo CONTAINER=1 >>/data/data/com.termux/files/usr/etc/container.conf
  touch /data/data/com.termux/files/usr/share/termux-container/.updated
fi
