ARG FROM_TAG

FROM php:$FROM_TAG

COPY --from=mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/bin/
RUN install-php-extensions \
    gd \
    intl \
    mysqli \
    pdo_mysql 

COPY build /build

RUN sh /build/install_composer.sh

RUN rm -r /build