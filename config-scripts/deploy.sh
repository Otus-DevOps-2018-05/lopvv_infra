#!/bin/bash
set -e

HOME_DIR=${1:-$HOME}
cd $HOME_DIR && git clone -b monolith https://github.com/express42/reddit.git
cd $HOME_DIR/reddit && bundle install
puma -d
