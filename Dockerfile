FROM php:8-fpm

# Install dependencies
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y \
    build-essential \
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    locales \
    zip \
    jpegoptim optipng pngquant gifsicle \
    vim \
    unzip \
    git \
    curl

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Copy existing application directory contents
RUN mkdir /app
COPY ./ /app

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
RUN php composer-setup.php
RUN php -r "unlink('composer-setup.php');"
RUN mv composer.phar /usr/local/bin/composer
RUN cd /app && composer install && php artisan key:generate

# Expose port 9000 and start php-fpm server
EXPOSE 9000
CMD ["php-fpm"]
