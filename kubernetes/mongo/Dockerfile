FROM mongo:latest

COPY data/ /home
COPY entrypoint.sh /home

WORKDIR /home

CMD ["/bin/bash", "/home/entrypoint.sh"]

EXPOSE 27017
