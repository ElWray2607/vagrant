#!/bin/bash

error_in_vagrantfile=false

./installPlugins.sh

if ! vagrant validate --ignore-provider virtualbox; then
  error_in_vagrantfile=true
fi


if [ "$error_in_vagrantfile" == true ]
    then
        echo "THE VAGRANTFILE HAS AN ERROR"
        exit 1
    else
        echo "THE VAGRANTFILE IS SYNTACTICALLY CORRECT"
fi