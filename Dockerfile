ARG FROM_TAG

FROM php:$FROM_TAG

# install packages via apt-get
RUN set -eux; \
	apt-get update; \
    apt-get upgrade -y --with-new-pkgs; \
	apt-get install -y --no-install-recommends \
		git \
        unzip \
        vim \
        wget \
        zip \
	; \
	rm -rf /var/lib/apt/lists/*

# install php extensions
COPY --from=mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/local/bin/
RUN set -eux; \
    install-php-extensions \
        gd \
        intl \
        mysqli \
        pdo_mysql \
        zip

# confige php
RUN set -eux; \
    mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"
COPY files/php.ini $PHP_INI_DIR/conf.d/000-default.ini

# install composer
RUN set -eux; \
    EXPECTED_CHECKSUM="$(wget -q -O - https://composer.github.io/installer.sig)"; \
    php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"; \
    ACTUAL_CHECKSUM="$(php -r "echo hash_file('sha384', 'composer-setup.php');")"; \
    if [ "$EXPECTED_CHECKSUM" != "$ACTUAL_CHECKSUM" ]; then \
        >&2 echo 'ERROR: Invalid installer checksum'; \
        rm composer-setup.php; \
        exit 1; \
    fi; \
    php composer-setup.php --quiet; \
    RESULT=$?; \
    mv composer.phar /usr/local/bin/composer; \
    rm composer-setup.php; \
    exit $RESULT

# confige apache
RUN set -eux; \
    a2enmod rewrite; \
    a2enmod headers; \
    a2enmod remoteip; \
    rm -r /var/www/html; \
    mkdir -p /var/www/html/public /var/www/html_error; \
    chown -R www-data:www-data /var/www
COPY files/index.php /var/www/html/public/index.php
COPY files/error.php /var/www/html_error/error.php
COPY files/apache.conf $APACHE_CONFDIR/sites-available/000-default.conf

# docker healthcheck
COPY files/healthcheck.sh /healthcheck.sh
RUN chmod +x /healthcheck.sh
HEALTHCHECK --interval=60s --timeout=10s --start-period=10s \  
    CMD /healthcheck.sh

# docker entrypoint
COPY files/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]
CMD ["apache2-foreground"]