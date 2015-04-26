#!/bin/bash
date 1>&2

CMD=$1

case $CMD in
  (start)
    echo "Starting the web server on port [$PORT]"
    exec /usr/bin/csd-dev
    ;;
  (*)
    echo "Don't understand [$CMD]"
    ;;
esac
