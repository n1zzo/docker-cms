#!/usr/bin/env bash

# Script to check requirements and install cms from sources

set -e

if [ "$1" = 'cms' ]; then
    # Download CMS (if necessary) and install dependencies
    git clone https://github.com/cms-dev/cms --recursive /cms || echo "The /cms folder isn't empty, skipping git-clone..."
    curl -L https://github.com/cms-dev/cms/pull/1143.diff | patch -p1 || true
    python3 -m ensurepip
    python3 -m pip install -r requirements.txt

    # Make sure directories exist
    mkdir -p /var/local/cache/cms

    # Install CMS
    python3 setup.py build
    python3 setup.py install

    # Use default config
    cp config/cms.conf.sample config/cms.conf
    sed -i 's/localhost:5432/cms_db:5432/' config/cms.conf

    # Initialize schema (create tables), if necessary
    cmsInitDB 2>&1 >/dev/null || true

    # Import some example contest
    git clone https://github.com/cms-dev/con_test /cms/con_test || echo "The /con_test folder isn't empty, skipping git-clone..."
    cd /cms/con_test
    cmsImportUser --all || true
    cmsImportContest --import-tasks . || true

    # Create "cmsuser" group because apparently CMS needs it
    addgroup -S cmsuser

    # Create an admin user in the database (admin / admin)
    cmsAddAdmin admin -p admin
fi

cmsResourceService -a ALL
