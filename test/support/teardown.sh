#!/usr/bin/env bash

after() {
  echo "from after"
}

test_nothing() {
  [[ 1 == 1 ]]
}
