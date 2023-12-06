FROM python:3.11-slim-bookworm

RUN apt-get update \
    && apt-get install -y gcc python3-dev \
    && rm -rf /var/cache/apt/archives /var/lib/apt/lists \
    && python -m pip install --user setuptools wheel \
    && python -m pip install --user --upgrade pip

WORKDIR /product


RUN useradd -m -r apprun && \
    chown apprun /product

ENV PATH "/root/.local/bin:${PATH}"

COPY requirements.txt ./
RUN pip install --user -r requirements.txt

COPY . .

USER apprun

ARG GIT_HASH
ENV GIT_HASH=${GIT_HASH:-dev}
CMD ["python", "-m", "app.main"]
