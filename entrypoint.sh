#!/bin/sh

# Script to check requirements and install cms from sources

pip install -r requirements.txt
python3 setup.py build
python3 setup.py install
