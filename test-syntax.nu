#!/usr/bin/env nu

# This is a comment

# Multiple
# Comments

# Variables
let $foo
let $foo = "foo"

echo $foo

# Function
def greet [name] {
  echo "hello" $name
}

greet "world"

# Negation
if not foo {
    bar arg
}

# Commands
foo & bar

# For loops
for $x in 1..3 { $x }

# Conditional
if 5 < 3 {
    'yes!'
    } else {
    'no!'
}
