FROM python:3.8-buster

WORKDIR /srv/app

ENV PYTHONPATH /srv/app

RUN apt-get update -y && \
    apt-get install -y -- python3-pip git build-essential libc-dev && \
    curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/install-poetry.py | POETRY_HOME=/opt/poetry python && \
    cd /usr/local/bin && \
    ln -s /opt/poetry/bin/poetry && \
    poetry config virtualenvs.create false && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY requirements.txt requirements.txt

RUN pip3 install --upgrade pip && \
    pip3 install -r requirements.txt

COPY . /srv/app

RUN poetry install