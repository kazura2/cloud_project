FROM ubuntu:latest

RUN apt update
RUN apt install python3 -y

WORKDIR /usr/app/src

COPY main.py /usr/app/src

CMD ["python3", "/usr/app/src/main.py"]