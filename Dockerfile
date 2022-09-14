FROM node:alpine

RUN npm install -g localtunnel

ENTRYPOINT ["lt"]
