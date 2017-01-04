#!/usr/bin/env bash

curr_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cmd="$curr_dir/../bash-test"

function exclude_header {
  echo "$1" | tail -n +3
}

function test_help_option_displays_help {
  $cmd -h | grep -q 'Usage'
}

function test_help_option_exits_with_code_0 {
  $cmd -h >/dev/null
  test $? -eq 0
}

function test_version_option_displays_version {
  $cmd -v | grep -qE "v[0-9]+\.[0-9]+\.[0-9]+"
}

function test_version_option_exits_with_code_0 {
  $cmd -v >/dev/null
  test $? -eq 0
}

function test_invalid_option_displays_help {
  $cmd -z | grep -q 'Usage'
}

function test_invalid_option_exits_with_code_1 {
  $cmd -z >/dev/null
  test $? -eq 1
}

function test_run_all_tests_present_on_input_file {
  expected=$(cat "$curr_dir"/support/sample-tests-1.expected_output.txt)
  actual=$($cmd "$curr_dir"/support/sample-tests-1.sh 2>/dev/null)
  diff <(exclude_header "$actual") <(echo -e "$expected")
}

function test_accepts_multiple_input_files {
  expected=$(cat "$curr_dir"/support/multiple-files.expected_output.txt)
  actual=$($cmd "$curr_dir"/support/*.sh 2>/dev/null)
  diff <(exclude_header "$actual") <(echo -e "$expected")
}

function test_elapsed_time_of_tests_execution_is_displayed {
  actual=$($cmd "$curr_dir"/support/*.sh 2>&1 >/dev/null)
  echo "$actual" | grep -q "real" &&\
  echo "$actual" | grep -q "user" &&\
  echo "$actual" | grep -q "sys"
}

function test_all_tests_passing_exits_with_code_0 {
  $cmd "$curr_dir"/support/sample-tests-2.sh >/dev/null 2>&1
  test $? -eq 0
}

function test_at_least_one_test_failing_exits_with_code_greater_than_0 {
  $cmd "$curr_dir"/support/*.sh >/dev/null 2>&1
  test $? -gt 0
}

function test_invalid_input_file_displays_error_message {
  invalid_input_file="$curr_dir/non/existent/file.sh"
  $cmd "$invalid_input_file" \
    | grep 'ERROR' \
    | grep 'Invalid input file' \
    | grep -q "$invalid_input_file"
}

function test_invalid_input_file_exits_with_code_1 {
  $cmd "$curr_dir"/non/existent/file.sh >/dev/null 2>&1
  test $? -eq 1
}
