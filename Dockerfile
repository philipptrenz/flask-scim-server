FROM python:3.8-buster

ENV TZ=Europe/Berlin
RUN useradd -m -r user

RUN pip install uwsgi

COPY requirements.txt /home/
RUN cd /home && pip install -r requirements.txt

USER user
COPY ./src /home
WORKDIR /home/

EXPOSE 5000

CMD [ "uwsgi", "--http", "0.0.0.0:5000", "--master", "-p", "2", "-w", "app:app" ]