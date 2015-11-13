# See: https://github.com/leanix/docker-phantomjs-2
FROM leanix/phantomjs2:master

CMD /bin/bash

ENV PATH ./node_modules/.bin:$PATH
ADD package.json /ff/
    # Install NodeJS & Java
RUN curl --silent --location https://deb.nodesource.com/setup_4.x | bash - && \
    wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && \
    sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list' && \
    apt-get update && \
    apt-get install -y nodejs build-essential openjdk-7-jre-headless xvfb google-chrome-stable firefox && \
    ln -s /usr/bin/nodejs /usr/sbin/node && \
    # Install Node packages
    cd ff && npm install && \
    # Download Selenium & webdriver
    ./node_modules/.bin/webdriver-manager update && \
    # Clean-up
    apt-get purge -y build-essential && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
