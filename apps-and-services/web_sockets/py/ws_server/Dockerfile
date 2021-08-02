FROM python:3-slim

WORKDIR /

RUN pip install websockets
COPY app.py /app.py

STOPSIGNAL SIGINT
CMD ["python", "/app.py"]
