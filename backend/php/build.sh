#!/bin/bash

docker build -t coomy/php:5.6-fpm ./

[ "$1" == "push" ] && docker push coomy/php:5.6-fpm
