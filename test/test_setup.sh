#!/usr/bin/env bash

before() {
  export TEST_VAR_1='uno'
}

test_passes_if_setup_is_executed() {
  [[ $TEST_VAR_1 == 'uno' ]]
}
