FROM ubuntu
RUN apt-get -y update && apt-get -y install nginx
COPY ./index.html /usr/share/nginx/html/index.html
EXPOSE 80/tcp
CMD ["/usr/sbin/nginx", "-g", "daemon off;"]
