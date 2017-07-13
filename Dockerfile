FROM node:8
LABEL name="node-chrome"

# Install Chrome

RUN echo 'deb http://dl.google.com/linux/chrome/deb/ stable main' > /etc/apt/sources.list.d/chrome.list

RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -

RUN set -x \
    && apt-get update \
    && apt-get install -y \
        google-chrome-stable

ENV CHROME_BIN /usr/bin/google-chrome

# Install noto fonts

RUN set -x \
    && apt-get install -y \
        fonts-noto-cjk \
    && cp /etc/fonts/conf.avail/69-language* /etc/fonts/conf.d \
    && sed -i 's/Droid\ Sans\ Fallback\|Droid\ Sans/Noto\ Sans\ cjk\ SC\ Regular/g' 69-language*

# Log versions

RUN set -x \
    && node -v \
    && npm -v \
    && google-chrome --version
