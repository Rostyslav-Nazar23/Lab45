FROM ubuntu
RUN apt-get -y update && apt-get -y install nginx
COPY ./index.html /usr/share/nginx/html/index.html
