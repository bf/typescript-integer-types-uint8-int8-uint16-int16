#!/bin/bash

generate_uint() {
  local exp=$1
  local max=$(echo "2 ^ $exp" | bc)
  echo "exponent: $exp max value: $max"
  local file="./uint$exp.ts"
  echo "// $exp bit unsigned Integer in Typescript (uint$exp)" > $file
  echo "export type uint$exp = " >> $file
  (for ((i=1; i<=max; i++)); do echo -n "|$i"; done) >> $file
  echo finished
}

generate_int() {
  local exp=$1
  local max=$(echo "2 ^ $exp" | bc)
  local min=$(echo "-1 * $max" | bc)
  echo "exponent: $exp min value: $min max value: $max"
  local file="./int$exp.ts"
  echo "// $exp bit signed Integer in Typescript (uint$exp)" > $file
  echo "export type int$exp = " >> $file
  (for ((i=min; i<=max; i++)); do echo -n "|$i"; done) >> $file
  echo finished
}

generate_uint 8
generate_uint 16

generate_int 8
generate_int 16