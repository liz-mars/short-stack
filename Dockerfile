FROM jessie:latest


RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y curl sudo\
    && curl -sL https://deb.nodesource.com/setup_7.x | bash - \
    && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list \
    && apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y nodejs yarn build-essential inotify-tools libelf1 libelf-dev locales \
    && sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen \
    && echo 'LANG="en_US.UTF-8"'>/etc/default/locale \
    && dpkg-reconfigure --frontend=noninteractive locales \
    && /usr/sbin/update-locale LANG=en_US.UTF-8 \
    && apt-get clean \
    && apt-get autoremove \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \


ENV LANG en_US.UTF-8

VOLUME /app
WORKDIR /app
EXPOSE 4000
