Docker PHP 7.0-fpm with Apache on Ubuntu 16.04
===================================

A simple Docker container based on Ubuntu 16.04 running PHP 7.0 FPM with Apache server. Basic setup for local development with preinstalled Composer and paired with MariaDB through docker-compose.yml file.

Usage
------

Containers set-up:
```bash
$ docker-compose up -d
```

You can also modify Dockerfile and rebuild the image with your tag:
```bash
$ docker build -t eolant/php7.0-fpm:0.1 .
```

Direct database connection:
```bash
$ mysql -P 8889 -h 0.0.0.0 -uroot -p
```

Shell into the container:
```bash
$ docker ps
$ docker exec -it your_container_id bash
```

Reload apache and php from container shell when you update config files:
```bash
$ service apache2 reload
$ service php7.0-fpm reload
```

Installed packages
-------------------
* Ubuntu 16.04
* apache2
* libapache2-mod-fastcgi
* php7.0-fpm
* php7.0
* php7.0-mysql
* php7.0-curl
* php7.0-gd
* php7.0-common
* php7.0-intl
* php7.0-imap
* php7.0-mcrypt
* php7.0-sqlite
* php7.0-xmlrpc
* php7.0-xsl
* php7.0-mbstring
* php7.0-xml
* php7.0-zip
* curl
* nano
* git
* unzip
* supervisor
* Composer
