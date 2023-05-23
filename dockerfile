FROM python:3.7.7-slim-stretch
COPY requirements.txt /
RUN pip install --no-cache-dir -r requirements.txt
