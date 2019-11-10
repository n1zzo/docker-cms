#!/bin/sh

# Script to check requirements and install cms from sources

set -e

if [ "$1" = 'cms' ]; then
    pip install -r requirements.txt
    python3 setup.py build
    python3 setup.py install
    cmsResourceService -a
fi

exec "$@"
