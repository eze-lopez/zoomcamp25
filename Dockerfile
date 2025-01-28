FROM python:3.10

RUN pip install --upgrade pip

COPY ./ /app
WORKDIR /app

RUN pip install poetry
RUN poetry config virtualenvs.create false
RUN poetry install --no-root

ENTRYPOINT [ "bash" ]
