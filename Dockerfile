FROM ubuntu:16.04
MAINTAINER Vitaly Kasymov <info@eolant.me>

# Environments vars
ENV TERM=xterm

RUN apt-get update --fix-missing
RUN apt-get -y upgrade

RUN apt-get -y install software-properties-common python-software-properties

RUN LC_ALL=C.UTF-8 add-apt-repository -y ppa:ondrej/php
RUN apt-get update --fix-missing

# Packages installation
RUN DEBIAN_FRONTEND=noninteractive apt-get -y --fix-missing --allow-unauthenticated install apache2 \
      libapache2-mod-fastcgi \
      php7.2-fpm \
      php7.2 \
      php7.2-cli \
      php7.2-mysql \
      php7.2-curl \
      php7.2-gd \
      php7.2-common \
      php7.2-imap \
      php7.2-sqlite3 \
      php7.2-mbstring \
      php7.2-xml \
      php7.2-zip \
      curl \
      nano \
      git \
      unzip \
      supervisor

RUN a2enmod actions fastcgi alias rewrite proxy proxy_http proxy_fcgi
RUN phpenmod opcache

# Composer install
RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer

# Update the default apache site with the config we created.
ADD config/apache/apache-vhosts.conf /etc/apache2/sites-enabled/000-default.conf
ADD config/apache/apache2.conf /etc/apache2/apache2.conf

# Update php.ini
ADD config/php/php7.2.conf /etc/php/7.2/apache2/php.ini

# Enable php fpm
RUN cd /etc/apache2/conf-available/ && a2enconf php7.2-fpm.conf

RUN service apache2 restart
RUN service php7.2-fpm start

RUN chown -R www-data:www-data /var/www

WORKDIR /var/www/

# Ports: apache2
EXPOSE 80

# Supervisor
COPY config/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

CMD ["/usr/bin/supervisord"]