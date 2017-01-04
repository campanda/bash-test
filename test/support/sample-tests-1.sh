#!/usr/bin/env bash

function test_something_that_passes {
  test 0 -eq 0
}

function test_something_that_fails {
  test 0 -eq 1
}
