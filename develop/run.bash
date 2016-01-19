#!/bin/bash

source $HOME/.nvm/nvm.sh
nvm install v0.12.7
nvm use v0.12.7
nvm alias default v0.12.7
if [ "$NODE_PACKAGE" ]; then
    for package in $NODE_PACKAGE
    do
        if [ -z "$($package -v)" ]; then
            echo "install $package ..."
            npm install -g $package
            echo "$package version: $($package -v)"
        else
            echo "$package: $($package -v) already install."
        fi
    done
else
    echo "There is not any node package to install."
fi
sudo $SSH_RUN
