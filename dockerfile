FROM python:3.7.7-slim-stretch
RUN mkdir -p /opt/program
COPY bloom_trainer.py /opt/program

COPY requirements.txt /
RUN pip3 install --no-cache-dir -r requirements.txt
WORKDIR /opt/program

ENTRYPOINT [ "python3", "/opt/program/bloom_trainer.py" ]