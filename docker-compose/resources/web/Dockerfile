FROM ubuntu:18.04

RUN apt update && apt -y install python3-pip 

WORKDIR /app

RUN pip3 install -r requirements.txt

EXPOSE 5000

WORKDIR /app/resources/web

CMD ["predict_flask.py"]

