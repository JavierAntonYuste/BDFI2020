FROM ubuntu:20.04

RUN apt update && apt -y install python3-pip

WORKDIR /home

COPY requirements.txt /home/requirements.txt
COPY resources /home/resources

ENV PROJECT_HOME=/home

RUN pip3 install -r requirements.txt

EXPOSE 5000

CMD python3 resources/web/predict_flask.py
