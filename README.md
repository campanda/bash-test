# bash-test

[![Build Status](https://travis-ci.org/campanda/bash-test.svg?branch=master)](https://travis-ci.org/campanda/bash-test)
[![Code Climate](https://codeclimate.com/github/campanda/bash-test/badges/gpa.svg)](https://codeclimate.com/github/campanda/bash-test)
[![Issue Count](https://codeclimate.com/github/campanda/bash-test/badges/issue_count.svg)](https://codeclimate.com/github/campanda/bash-test/issues)

Simple test runner for [Bash][0].

## Installation

Just download the file (preferably somewhere in your `$PATH`) and give it
execution permissions:

    $ curl https://git.io/bash-test > /usr/local/bin/bash-test &&\
      chmod +x /usr/local/bin/bash-test

## Usage

Write test cases as [Shell Functions][1], starting with `test_` and export the
variable `SOURCE` with the relative path to the directory where your scripts
are located.

Example:

    #!/usr/bin/env bash

    export SOURCE='../src'

    test_something() {
      echo "foo" | grep "bar"
    }

    test_something_else() {
      test 2 -eq 2
    }

    test_my_script() {
      test $(my-script 'some input') -eq 'some output'
    }

To run the tests, simply:

    $ bash-test path/to/tests.sh
    bash-test v0.1.0 by Campanda GmbH and contributors.

    tests.sh
      ✓ test_my_script
      ✗ test_something
      ✓ test_something_else

     1 of 3 tests failed.

## License

bash-test is released under the [MIT License][2].

[0]: https://www.gnu.org/software/bash/
[1]: https://www.gnu.org/software/bash/manual/bash.html#Shell-Functions
[2]: http://www.opensource.org/licenses/MIT
