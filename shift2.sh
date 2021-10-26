#!/bin/bash

var_nameserver="192.168.122.1"
var_loguetown="192.212.2.2"
var_alabasta="192.212.2.3"
var_enieslobby="192.212.3.2"
var_water7="192.212.3.3"
var_skypie="192.212.3.4"

echo nameserver 192.168.122.1 > /etc/resolv.conf
echo 'nameserver 192.168.122.1 > /etc/resolv.conf' >> /root/.bashrc
echo 'apt-get update' >> /root/.bashrc
echo 'apt-get install nano' >> /root/.bashrc
echo 'apt-get install wget' >> /root/.bashrc
echo 'wget https://github.com/dvjhr/Jarkom-script/blob/main/shift2.sh -O /root/shift2.sh' >> /root/.bashrc
bash /root/shift2.sh

Lock() {
rm /var/lib/apt/lists/lock
rm /var/cache/apt/archives/lock
rm /var/lib/dpkg/lock*

dpkg --configure -a

apt-get update

}

Foosha() {
echo "Executing $HOSTNAME script"

apt-get update
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE -s 192.212.0.0/16
cat /etc/resolv.conf

echo "Finish executing $HOSTNAME script"
}

Loguetown() {
echo "Executing $HOSTNAME script"
echo nameserver 192.168.122.1 > /etc/resolv.conf
apt-get update && apt-get install nano

echo "#nameserver $var_enieslobby
nameserver $var_water7
#nameserver 192.168.122.1" > /etc/resolv.conf

apt-get update && apt-get install lynx -y
apt-get update && apt-get install libapache2-mod-php7.0 -y

echo "Finish executing $HOSTNAME script"
}

Alabasta() {
echo "Executing $HOSTNAME script"
echo nameserver 192.168.122.1 > /etc/resolv.conf
apt-get update && apt-get install nano

echo "#nameserver $var_enieslobby
nameserver $var_water7
#nameserver 192.168.122.1" > /etc/resolv.conf

apt-get update && apt-get install libapache2-mod-php7.0 -y
apt-get update && apt-get install lynx -y

echo "Finish executing $HOSTNAME script"
}

EniesLobby() {
echo "Executing $HOSTNAME script"
echo nameserver 192.168.122.1 > /etc/resolv.conf
apt-get update && apt-get install nano
apt-get update && apt-get install bind9 -y

echo "zone \"jarkom2021.com\" {
    type master;
    notify yes;
    also-notify { $var_water7; };
    allow-transfer { $var_water7; };
    file \"/etc/bind/jarkom/jarkom2021.com\";
};" > /etc/bind/named.conf.local

mkdir /etc/bind/jarkom
cp /etc/bind/db.local /etc/bind/jarkom/jarkom2021.com

echo ";
; BIND data file for local loopback interface
;
\$TTL    604800
@       IN      SOA     jarkom2021.com. root.jarkom2021.com. (
                        2021102601         ; Serial
                        604800         ; Refresh
                        86400         ; Retry
                        2419200         ; Expire
                        604800 )       ; Negative Cache TTL
;
@       IN      NS      jarkom2021.com.
;@      IN      A       $var_enieslobby ;IP EniesLobby
@       IN      AAAA    ::1
" > /etc/bind/jarkom/jarkom2021.com

service bind9 restart

echo "Finish executing $HOSTNAME script"
}

Water7() {
echo "Executing $HOSTNAME script"
echo nameserver 192.168.122.1 > /etc/resolv.conf
apt-get update && apt-get install nano
apt-get update && apt-get install bind9 -y

echo "zone \"jarkom2021.com\" {
    type slave;
    masters { $var_enieslobby; };
    file \"var/lib/bind/jarkom2021.com\"
};" > /etc/bind/named.conf.local

echo "Finish executing $HOSTNAME script"
}

Skypie() {
echo "Executing $HOSTNAME script"
echo nameserver 192.168.122.1 > /etc/resolv.conf
apt-get update && apt-get install nano

apt-get update && apt-get install apache2 -y
service apache2 start
apt-get update && apt-get install php -y
php -v
apache -v

echo "<VirtualHost *:80>
    # The ServerName directive sets the request scheme, hostname and port t$
    # the server uses to identify itself. This is used when creating
    # redirection URLs. In the context of virtual hosts, the ServerName
    # specifies what hostname must appear in the request's Host: header to
    # match this virtual host. For the default virtual host (this file) this
    # value is not decisive as it is used as a last resort host regardless.
    # However, you must set it for any further virtual host explicitly.
    #ServerName www.example.com

    ServerAdmin webmaster@localhost
    DocumentRoot /var/www/html

    # Available loglevels: trace8, ..., trace1, debug, info, notice, warn,
    # error, crit, alert, emerg.
    # It is also possible to configure the loglevel for particular
    # modules, e.g.
    #LogLevel info ssl:warn

    ErrorLog \${APACHE_LOG_DIR}/error.log
    CustomLog \${APACHE_LOG_DIR}/access.log combined

    # For most configuration files from conf-available/, which are
    # enabled or disabled at a global level, it is possible to
    # include a line for only one particular virtual host. For example the
    # following line enables the CGI configuration for this host only
    # after it has been globally disabled with \"a2disconf\".
    #Include conf-available/serve-cgi-bin.conf
</VirtualHost>" > /etc/apache2/sites-available/000-default.conf

mkdir /var/www/html
echo "<?php

    phpinfo();

?>" > /var/www/html/index.php

echo "Finish executing $HOSTNAME script"
}

if [ $HOSTNAME == "Foosha" ]
then
    echo $HOSTNAME
    Foosha
elif [ $HOSTNAME == "EniesLobby" ]
then
    echo $HOSTNAME
    EniesLobby
elif [ $HOSTNAME == "Water7" ]
then
    echo $HOSTNAME
    Water7
elif [ $HOSTNAME == "Loguetown" ]
then
    echo $HOSTNAME
    Loguetown
elif [ $HOSTNAME == "Alabasta" ]
then
    echo $HOSTNAME
    Alabasta
elif [ $HOSTNAME == "Skypie" ]
then
    echo $HOSTNAME
    Skypie
elif [ $1 == lock ]
then
    echo Unlocking
    Lock
fi