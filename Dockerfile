ARG FROM_TAG

FROM php:$FROM_TAG

# install packages via apt-get
RUN set -eux; \
	apt-get update; \
	apt-get install -y --no-install-recommends \
		git \
        wget \
	; \
	rm -rf /var/lib/apt/lists/*

# install php extensions
COPY --from=mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/local/bin/
RUN set -eux; \
    install-php-extensions \
        gd \
        intl \
        mysqli \
        pdo_mysql 

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