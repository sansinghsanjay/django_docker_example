# get the base ubuntu image
FROM ubuntu:18.04
# update the package manager
RUN apt-get update
# install python 3.8
RUN apt-get install software-properties-common -y
RUN add-apt-repository ppa:deadsnakes/ppa
RUN apt-get install python3.8 -y
# update the package manager
RUN apt-get update
# print the version of python
RUN python3 --version
# install pip and update it
RUN apt-get install python3-pip -y
RUN pip3 install --upgrade pip
# install django
RUN pip3 install Django
RUN pip3 install gunicorn
# update the package manager
RUN apt-get update
# install nginix
RUN apt-get install nginx -y
# update the package manager
RUN apt-get update
# copy nginx configuration file - default
COPY ./default /etc/nginx/sites-available/default
# copy source and install dependencies
RUN mkdir -p /opt/app
RUN mkdir -p /opt/app/django_app
COPY ./django_app/ /opt/app/django_app/
# copy start-server script
COPY start-server.sh /opt/app/
# declare work directory
WORKDIR /opt/app
# change user permissions
RUN chown -R www-data:www-data /opt/app
# start server
EXPOSE 8020
STOPSIGNAL SIGTERM
CMD ["/opt/app/start-server.sh"]
