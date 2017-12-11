FROM ubuntu:16.04
MAINTAINER Vitaly Kasymov <info@eolant.me>

# Environments vars
ENV TERM=xterm

RUN apt-get update
RUN apt-get -y upgrade

# Packages installation
RUN DEBIAN_FRONTEND=noninteractive apt-get -y --fix-missing install apache2 \
      libapache2-mod-fastcgi \
      php7.0-fpm \
      php7.0 \
      php7.0-mysql \
      php7.0-curl \
      php7.0-gd \
      php7.0-common \
      php7.0-intl \
      php7.0-imap \
      php7.0-mcrypt \
      php7.0-sqlite \
      php7.0-xmlrpc \
      php7.0-xsl \
      php7.0-mbstring \
      php7.0-xml \
      php7.0-zip \
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
ADD config/php/php.conf /etc/php/7.0/apache2/php.ini

# Enable php fpm
RUN cd /etc/apache2/conf-available/ && a2enconf php7.0-fpm.conf

RUN service apache2 restart
RUN service php7.0-fpm start

RUN chown -R www-data:www-data /var/www

WORKDIR /var/www/

# Ports: apache2
EXPOSE 80

# Supervisor
COPY config/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

CMD ["/usr/bin/supervisord"]