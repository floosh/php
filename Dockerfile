

FROM php:apache

# install the PHP extensions we need
RUN set -ex; \
	\
	apt-get update; \
	apt-get install -y \
		libjpeg-dev \
		libpng12-dev \
	; \
	rm -rf /var/lib/apt/lists/*; \
	\
	docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr; \
docker-php-ext-install gd mysqli opcache

RUN apt-get update && \
  apt-get install -y ssmtp && \
  apt-get clean && \
  echo 'sendmail_path = "/usr/sbin/ssmtp -t"' > /usr/local/etc/php/conf.d/mail.ini

ADD ssmtp.conf /etc/ssmtp/ssmtp.conf

CMD ["apache2-foreground"]
