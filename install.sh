# подключаем репозиторий
echo "ip" >> /etc/hosts

# установка крипто про 4.0 R3
rm -f /opt/linux-amd64-R3.tar.gz && rm -Rf /opt/linux-amd64 && yum remove ifd-ru* rtSu* cprocsp-* lsb-* opensc-* pcsc* openct-* -y && rm -Rf /var/opt/cprocsp/ && rm -Rf /opt/cprocsp/ && cd /opt/ && wget ftp://10.0.29.228/cryptopro/linux-amd64/linux-amd64-R3.tar.gz && tar -xvf linux-amd64-R3.tar.gz && cd linux-amd64-R3 && yum install opensc pcsc-lite* motif* -y && yum remove openct -y && ./install.sh && rpm -Uvh cprocsp-rdr-gui-gtk-* ifd-rutokens-1.0.4* cprocsp-rdr-pcsc-* cprocsp-rdr-rutoken-* cprocsp-pki-* lsb-cprocsp-devel* && /etc/init.d/pcscd restart && sed -i '/^\[Parameters\]/a \warning_time_gen_2001 = ll:9223372036854775807' /etc/opt/cprocsp/config64.ini && sed -i '/^warning_time_gen_2001 = ll:9223372036854775807/a \warning_time_sign_2001 = ll:9223372036854775807' /etc/opt/cprocsp/config64.ini
rpm -Uvh ftp://ip/cryptopro/cpfix-4.0-0.4-1.el7.noarch.rpm && cpfix-4.0-R4

#расшарить принтер
cupsctl --remote-admin --remote-any --share-printers
rm /etc/samba/smb.conf
cp /home/smb.conf /etc/samba/smb.conf
systemctl daemon-reload
systemctl restart smb
systemctl enable smb
systemctl enable smb.service
systemctl restart smb

mkdir /etc/polkit-1/rules.d 2> /dev/null
cp /home/IC6/60-mount-other-seat.rules /etc/polkit-1/rules.d  #Блокировака USB


cp /home/IC6/smb.conf /etc/samba

# установка VNC
cd /home/IC6
yum install xorg-x11-server-Xvfb libvncserver tk -y
rpm -Uhv x11vnc-0.9.13-1.el7.rf.x86_64.rpm
x11vnc -storepasswd "123" /etc/vncpasswd
rm -fr /lib/systemd/system/x11vnc.service
echo '[Unit]' >> /lib/systemd/system/x11vnc.service
echo 'Description=Start x11vnc at startup.' >> /lib/systemd/system/x11vnc.service
echo 'After=multi-user.target' >> /lib/systemd/system/x11vnc.service
echo '[Service]' >> /lib/systemd/system/x11vnc.service
echo 'Type=simple' >> /lib/systemd/system/x11vnc.service
echo 'ExecStart=/usr/bin/x11vnc --reopen --forever -rfbauth /etc/vncpasswd' >> /lib/systemd/system/x11vnc.service
echo '[Install]' >> /lib/systemd/system/x11vnc.service
echo 'WantedBy=multi-user.target' >> /lib/systemd/system/x11vnc.service
systemctl daemon-reload
systemctl enable x11vnc.service
systemctl start x11vnc.service
systemctl status x11vnc.service
# хранилище сертификатов
cd /home/IC6
chmod +x store_access.sh
./store_access.sh user
chown -R user:user /var/opt/cprocsp/users/stores/
# java
wget ftp://ip/jre/jre-8u241-linux-x64.rpm
chmod +x jre-8u241-linux-x64.rpm
rpm -i jre-8u241-linux-x64.rpm
# update-alternatives --config java
# установка screenshot
yum install gnome-screenshot -y

sed -i "s/exit 0//g" /etc/gdm/Init/Default
echo "sleep 5 && mount -a exit 0" >> /etc/gdm/Init/Default

echo "sleep 5 && mount -a" >> /etc/rc.local
echo "systemctl daemon-reload" >> /etc/rc.local
echo "systemctl restart smb" >> /etc/rc.local
cd /etc
chmod +x rc.local
# монтирование сетевых ресурсов
cd /mnt
mkdir pksp obmen
echo "//ip/pksp /mnt/pksp/ cifs username=,password=,dir_mode=0777,file_mode=0777,vers=1.0,rw 0 0 " >> /etc/fstab
echo "//ip/obmen /mnt/obmen/ cifs username=,password=,dir_mode=0777,file_mode=0777,vers=1.0,rw 0 0 " >> /etc/fstab
echo "" >> /etc/fstab
mount -a
# wine cons.exe /Linux /group /yes
# hostnamectl set-hostname 3221049795
# systemctl restart systemd-hostnamed

systemctl stop  ip6tables 
systemctl disable ip6tables.service
yum install gstreamer* -y
yum install screen -y
yum install tree* -y
yum install token-manager -y
yum install ghostscript -y
yum install gparted -y
yum install gnome-system-monitor -y
yum install unrar -y
yum install ark -y
# установка libreoffice 
yum install libreoffice -y
yum remove firefox -y
yum install firefox -y
yum update -y

systemctl daemon-reload


