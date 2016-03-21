# See: https://github.com/leanix/docker-phantomjs-2
FROM leanix/phantomjs2:master

CMD /bin/bash

ENV PATH ./node_modules/.bin:$PATH
ADD package.json /ff/
    # Use bash instead of shell (e.g. to support source)
RUN ln -snf /bin/bash /bin/sh
    # Install NodeJS & NPM
RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.31.0/install.sh | bash && \
    source ~/.nvm/nvm.sh && \
    nvm install 4.4.0 && \
    npm install -g npm@3.8.1 && \
    # Install Java & XVFB & browsers
    wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && \
    sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list' && \
    apt-get update && \
    apt-get install -y openjdk-7-jre-headless xvfb google-chrome-stable firefox && \
    # Install Node packages
    cd ff && npm install && \
    # Download Selenium & webdriver
    ./node_modules/.bin/webdriver-manager update && \
    # Clean-up
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
