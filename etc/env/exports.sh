#!/bin/bash
#
export LC_ALL=en_US.UTF-8
export EDITOR="vim"
export ECR_URL=012629307706.dkr.ecr.us-east-1.amazonaws.com/marvin


if [ -f "$DOT_DATA/etc/env/exports.sh" ]; then 
    source $DOT_DATA/etc/env/exports.sh
fi
