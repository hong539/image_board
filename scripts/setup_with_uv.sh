#!/usr/bin/env bash
set -euxo pipefail

#How to migrate from Poetry to UV package manager?
# uvx migrate-to-uv

#run with uv
uv run main/manage.py help

#Creating a superuser for Django CMS system
uv run main/manage.py createsuperuser

#run devserver
uv run  main/manage.py runserver 18080