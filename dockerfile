FROM python:3.7.7-slim-stretch
COPY requirements.txt /
COPY bloom_trainer.py /opt
RUN pip3 install --no-cache-dir -r requirements.txt