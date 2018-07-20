Docker PHP 7.2-fpm with Apache on Ubuntu 16.04
===================================

A simple Docker container based on Ubuntu 16.04 running PHP 7.2 FPM with Apache server. Basic setup for local development with preinstalled Composer and paired with MariaDB through docker-compose.yml file.

Usage
------

Containers set-up:
```bash
$ docker-compose up -d
```

You can also modify Dockerfile and rebuild the image with your tag:
```bash
$ docker build -t eolant/php7-fpm:0.1 .
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
$ service php7.2-fpm reload
```

Installed packages
-------------------
* Ubuntu 16.04
* apache2
* libapache2-mod-fastcgi
* php7.2-fpm
* php7.2
* php7.2-cli
* php7.2-mysql
* php7.2-curl
* php7.2-gd
* php7.2-common
* php7.2-imap
* php7.2-sqlite3
* php7.2-mbstring
* php7.2-xml
* php7.2-zip
* curl
* nano
* git
* unzip
* supervisor
* Composer
