#!/usr/bin/env bash

data_provider_for_test_foo="$(mktemp)"
cat > "${data_provider_for_test_foo}" <<EOF
foo
bar
baz
EOF
_test_foo() {
    test "${1}" = "${1}"
}

data_provider_for_test_bar="$(mktemp)"
cat > "${data_provider_for_test_bar}" <<EOF
foo
bar
baz
EOF
_test_bar() {
    test "${1}" = "${1}"
}
