# Change to Minimus Python base
FROM reg.mini.dev/python:3.13.9-dev

ARG MINIMUS_TOKEN=$MINIMUS_TOKEN

ENV VIRTUAL_ENV /env
ENV PATH /env/bin:$PATH

USER 0
# Add repository credentials
RUN echo "https://minimus:${MINIMUS_TOKEN}@packages.mini.dev/os" > /etc/apk/repositories
RUN apk add --no-cache nginx build-base ffmpeg gcc openssl-dev opus-dev pkgconf bash py3.13-cryptography py3.13-django py3.13-jwt py3.13-requests py3.13-urllib3 py3.13-gunicorn linux-headers

WORKDIR /app
COPY app /app
COPY config/nginx.conf /etc/nginx/nginx.conf

RUN set -ex && \
    python -m venv /env && \
    source /env/bin/activate && \
    /env/bin/pip install -r requirements.txt --no-cache-dir


