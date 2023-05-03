FROM nginx:1.23.3-alpine
COPY ./index.html /usr/share/nginx/html/index.html
