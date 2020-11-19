FROM mongo:latest

COPY data/ /home
COPY entrypoint.sh /home

WORKDIR /home/data

CMD ["/bin/bash", "/home/entrypoint.sh"]

EXPOSE 27017
