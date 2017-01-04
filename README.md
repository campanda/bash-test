# bash-test

[![Build Status](https://travis-ci.org/campanda/bash-test.svg?branch=master)](https://travis-ci.org/campanda/bash-test)
[![Code Climate](https://codeclimate.com/github/campanda/bash-test/badges/gpa.svg)](https://codeclimate.com/github/campanda/bash-test)
[![Issue Count](https://codeclimate.com/github/campanda/bash-test/badges/issue_count.svg)](https://codeclimate.com/github/campanda/bash-test)

Simple test runner for [Bash][0].

## Installation

Just download the file (preferably somewhere in your `$PATH`) and give it execution permissions:

    $ curl https://raw.githubusercontent.com/campanda/bash-test/master/bash-test > /usr/local/bin/bash-test
    $ chmod +x /usr/local/bin/bash-test

## Usage

Write test cases as [Shell Functions][1], starting with `test_`. Example:

    #!/usr/bin/env bash

    test_something() {
      echo "foo" | grep "bar"
    }

    test_something_else() {
      test 2 -eq 2
    }

To run the tests, simply:

    $ bash-test path/to/tests.sh

## License

bash-test is released under the [MIT License][2].

[0]: https://www.gnu.org/software/bash/
[1]: https://www.gnu.org/software/bash/manual/bash.html#Shell-Functions
[2]: http://www.opensource.org/licenses/MIT
