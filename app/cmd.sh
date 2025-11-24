#!/bin/bash

gunicorn --env DJANGO_SETTINGS_MODULE=myapp.settings -b 127.0.0.1:9000 myapp.wsgi &
nginx
