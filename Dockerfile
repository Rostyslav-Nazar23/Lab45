FROM nginx:latest
COPY ./css /usr/share/nginx/html/css
COPY ./index.html /usr/share/nginx/html/index.html
