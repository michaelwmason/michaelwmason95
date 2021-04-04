FROM node:15.13.0-slim

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get install -y --no-install-recommends chromium

ENV CHROME_BIN=chromium

WORKDIR /usr/src/app

CMD ["npm", "run", "test:headless" ]