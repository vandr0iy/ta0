# syntax=docker/dockerfile:1.2
FROM klakegg/hugo:latest as build

COPY ./ /ta0
WORKDIR /ta0
RUN hugo

#Copy static files to Nginx
FROM nginx:alpine
COPY --from=build /ta0/public /usr/share/nginx/html

USER nginx
WORKDIR /usr/share/nginx/html

