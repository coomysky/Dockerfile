#!/bin/bash

docker build -t coomy/beanstalk:1.10 ./

[ "$1" == "push" ] && docker push coomy/beanstalk:1.10
