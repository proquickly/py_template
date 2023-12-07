FROM python:3.11-slim-bullseye

RUN apt-get update \
    && apt-get install -y gcc python3-dev \
    && rm -rf /var/cache/apt/archives /var/lib/apt/lists
ENV VIRTUAL_ENV=/opt/venv
RUN python3 -m venv $VIRTUAL_ENV
ENV PATH="$VIRTUAL_ENV/bin:$PATH"
COPY requirements.txt .
RUN /opt/venv/bin/pip install certifi setuptools wheel \
    && /opt/venv/bin/pip install -r requirements.txt \
    && /opt/venv/bin/pip install --upgrade pip

WORKDIR /product


COPY . .


ARG GIT_HASH
ENV GIT_HASH=${GIT_HASH:-dev}
CMD ["python", "-m", "app.main"]
