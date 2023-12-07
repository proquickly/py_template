FROM python:3.11-slim-bookworm

RUN apt-get update \
    && apt-get install -y \
    && gcc python3-dev libssl libssl-dev openssl libffi-dev python3-openssl apt-utils \
    && rm -rf /var/cache/apt/archives /var/lib/apt/lists
ENV VIRTUAL_ENV=/opt/venv
RUN python3 -m venv $VIRTUAL_ENV
ENV PATH="$VIRTUAL_ENV/bin:$PATH"
COPY requirements.txt .
RUN pip install setuptools wheel \
    && pip install -r requirements.txt \
    && pip install --upgrade pip

WORKDIR /product

RUN useradd -m -r apprun && \
    chown apprun /product

COPY . .

USER apprun

ARG GIT_HASH
ENV GIT_HASH=${GIT_HASH:-dev}
CMD ["python", "-m", "app.main"]
