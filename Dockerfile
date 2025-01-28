FROM python:3.10

RUN pip install --upgrade pip

WORKDIR /app

ENTRYPOINT [ "bash" ]
