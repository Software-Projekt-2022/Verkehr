# syntax=docker/dockerfile:1

FROM node:18-alpine3.14

WORKDIR /app

COPY ./ ./

RUN npm install
EXPOSE 3000
CMD node server.js