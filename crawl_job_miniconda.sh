#!/bin/bash

#export PATH="/home/pi/miniconda3/bin:$PATH"

# USAGE
# Run 'y | ./crawl_job.sh' to automatically create the virtual environment (if not yet created)
# otherwise './crawl_job.sh' is sufficient

# Functions are not exported by default to be made available in subshells
# source ~/miniconda3/etc/profile.d/conda.sh

# conda venv name
VENV=env-comunio

VENV_CREATED=$(conda env list | grep $VENV)

sudo apt-get install python3 python3-dev python3-pip libxml2-dev libxslt1-dev zlib1g-dev libffi-dev libssl-dev

if [ -z "$VENV_CREATED" ]
then
echo "virtual environment $VENV does not exist, so I create it..."
conda create -n $VENV python=3.6
source activate $VENV
conda install anaconda-client
pip install --upgrade pip
pip install scrapy
else
# simply activate already existing conda venv
source activate $VENV
fi


timestamp=$(date +%s)

# run crawler
scrapy crawl crawl-clubs -o ${timestamp}_bundesliga_player.json

# deactivate conda venv
source deactivate
