ARG FROM_TAG

FROM php:$FROM_TAG

# install additional php extensions
COPY --from=mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/bin/
RUN install-php-extensions \
    gd \
    intl \
    mysqli \
    pdo_mysql 