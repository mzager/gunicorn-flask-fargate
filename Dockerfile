# gunicorn-flask-fargate

FROM ubuntu:16.04
MAINTAINER Michael Zager <michael@zager.co>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get install -y python3 python3-dev python3-pip python3-venv python3-wheel gunicorn

#python3.6 python3.6-dev python3-pip python3-virtualenv gunicorn

# Setup flask application
RUN mkdir -p /deploy/app
COPY gunicorn_config.py /deploy/gunicorn_config.py
COPY app /deploy/app
RUN pip3 install -r /deploy/app/requirements.txt
WORKDIR /deploy/app

EXPOSE 5000

# Start gunicorn
CMD ["/usr/bin/gunicorn", "--config", "/deploy/gunicorn_config.py", "main:app"]
