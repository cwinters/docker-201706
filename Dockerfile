FROM node:8.1.1-alpine

RUN      apk add --no-cache python make g++ libsass \
           && npm install -g grunt

RUN      mkdir /app
WORKDIR  /app
COPY     package.json /app
RUN      npm install
COPY     . /app

EXPOSE   8000

CMD ["grunt", "serve"]
