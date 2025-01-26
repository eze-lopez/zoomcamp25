FROM python:3.12

RUN pip install pandas

WORKDIR /app

ENTRYPOINT [ "bash" ]
