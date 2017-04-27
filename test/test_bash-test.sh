#!/usr/bin/env bash

export SOURCE=".."

function exclude_header {
  echo "$1" | tail -n +3
}

function test_help_option_displays_help {
  bash-test -h | grep -q 'Usage'
}

function test_help_option_exits_with_code_0 {
  bash-test -h >/dev/null
  test $? -eq 0
}

function test_version_option_displays_version {
  bash-test -v | grep -qE "v[0-9]+\.[0-9]+\.[0-9]+"
}

function test_version_option_exits_with_code_0 {
  bash-test -v >/dev/null
  test $? -eq 0
}

function test_invalid_option_displays_help {
  bash-test -z | grep -q 'Usage'
}

function test_invalid_option_exits_with_code_1 {
  bash-test -z >/dev/null
  test $? -eq 1
}

curr_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

function test_run_all_tests_present_on_input_file {
  expected=$(cat "$curr_dir"/support/sample-tests-1.expected_output.txt)
  actual=$(bash-test "$curr_dir"/support/sample-tests-1.sh 2>/dev/null)
  diff <(exclude_header "$actual") <(echo -e "$expected")
}

function test_accepts_multiple_input_files {
  expected=$(cat "$curr_dir"/support/multiple-files.expected_output.txt)
  actual=$(bash-test "$curr_dir"/support/sample-tests-{1,2}.sh 2>/dev/null)
  diff <(exclude_header "$actual") <(echo -e "$expected")
}

function test_elapsed_time_of_tests_execution_is_displayed {
  actual=$(bash-test "$curr_dir"/support/*.sh 2>&1 >/dev/null)
  echo "$actual" | grep -q "real" &&\
  echo "$actual" | grep -q "user" &&\
  echo "$actual" | grep -q "sys"
}

function test_all_tests_passing_exits_with_code_0 {
  bash-test "$curr_dir"/support/sample-tests-2.sh >/dev/null 2>&1
  test $? -eq 0
}

function test_at_least_one_test_failing_exits_with_code_greater_than_0 {
  bash-test "$curr_dir"/support/*.sh >/dev/null 2>&1
  test $? -gt 0
}

function test_invalid_input_file_displays_error_message {
  invalid_input_file="$curr_dir/non/existent/file.sh"
  bash-test "$invalid_input_file" \
    | grep 'ERROR' \
    | grep 'Invalid input file' \
    | grep -q "$invalid_input_file"
}

function test_invalid_input_file_exits_with_code_1 {
  bash-test "$curr_dir"/non/existent/file.sh >/dev/null 2>&1
  test $? -eq 1
}

function test_should_locate_scripts_according_to_relative_path {
  bash-test "$curr_dir/support/test-script-relative-path.sh" >/dev/null 2>&1
  test $? -eq 0
}

function test_generator_runs_one_test_case_per_line_on_data_provider {
  expected=$(cat "$curr_dir"/support/sample-test-generator.expected_output.txt)
  actual=$(bash-test "$curr_dir"/support/sample-test-generator.sh 2>/dev/null)
  diff <(exclude_header "$actual") <(echo -e "$expected")
}

# reproducing reported issue #6
function test_clean_data_provider_after_running_its_correspondent_tests {
  err="$(mktemp)"
  bash-test "$curr_dir"/support/sample-tests-{with-data-providers,1}.sh >/dev/null 2>"$err"
  grep 'bad substitution' "$err"
  test $? -ne 0
}
