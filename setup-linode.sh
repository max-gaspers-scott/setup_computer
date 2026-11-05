#!/bin/bash
if [ ! -d .linode-env ]; then
    uv venv .linode-env
fi
source .linode-env/bin/activate
uv pip install linode-cli
