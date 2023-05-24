FROM python:3.7.7-slim-stretch
COPY requirements.txt /
COPY bloom_trainer.py /
RUN pip install --no-cache-dir -r requirements.txt
ENV PYTHONUNBUFFERED=TRUE

ENTRYPOINT ["python3"]