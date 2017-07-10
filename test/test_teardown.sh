#!/usr/bin/env bash

test_passes_if_teardown_is_executed() {
  output="$(mktemp)"
  ./bash-test ./test/support/teardown.sh > "${output}" 2> /dev/null
  cat "${output}" | grep -q "from after"
}
