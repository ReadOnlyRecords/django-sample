# Change to Minimus Python base
FROM reg.mini.dev/python:3.13.9

ENV VIRTUAL_ENV /env
ENV PATH /env/bin:$PATH

USER 0
RUN apk add --no-cache nginx build-base ffmpeg gcc openssl-dev opus-dev pkgconf bash py3-cryptography py3-django py3-jwt py3-requests py3-urllib3 py3-gunicorn linux-headers

WORKDIR /app
COPY app /app
COPY config/nginx.conf /etc/nginx/nginx.conf

# Add repository credentials
RUN echo "https://minimus:${MINIMUS_TOKEN}@packages.mini.dev/os" > /etc/apk/repositories
RUN set -ex && \
    python -m venv /env && \
    source /env/bin/activate && \
    /env/bin/pip install -r requirements.txt --no-cache-dir


