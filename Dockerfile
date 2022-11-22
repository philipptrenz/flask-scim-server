FROM python:3.8-buster

ENV TZ=Europe/Berlin
RUN useradd -m -r user

COPY requirements.txt /home/
RUN cd /home && pip install -r requirements.txt

USER user
# COPY ./src /home
WORKDIR /home/

# CMD ["python", "app.py"]
