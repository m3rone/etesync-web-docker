FROM node:alpine AS build

# Below is the variable for the default server
ENV REACT_APP_DEFAULT_API_PATH="https://api.etebase.com/partner/etesync/"
ENV NODE_OPTIONS=--openssl-legacy-provider

RUN apk update && apk upgrade
RUN apk add yarn

COPY package.json yarn.lock ./
RUN yarn
COPY . .
RUN yarn build

###

FROM nginx:alpine-slim

COPY --from=build /build /usr/share/nginx/html
