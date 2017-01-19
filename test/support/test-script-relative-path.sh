#!/usr/bin/env bash

export SOURCE='.'

function test_using_a_local_script {
  test "$(local-script)" = '42'
}
