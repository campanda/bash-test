#!/usr/bin/env bash

curr_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# shellcheck disable=SC2034
data_provider_for_test_even_or_odd="$curr_dir/numbers.txt"
function _test_even_or_odd {
  number="$1"
  expected="$2"

  actual=$(test $((number%2)) -eq 0 && echo "even" || echo "odd")
  test "$actual" = "$expected"
}
