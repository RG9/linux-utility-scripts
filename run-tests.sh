#!/bin/bash

MY_PATH=$(dirname "$(realpath "$0")")

# Check if script to test is provided as an argument
if [ -z "$1" ]; then
    echo "Error: No script specified to test."
    echo "Usage: $0 <script_to_test>"
    exit 1
fi

script_to_test="$1"
script_to_test_full_path="$MY_PATH/$1"
expected_output_file="$MY_PATH/tests/output/expected/${script_to_test}.txt"
actual_output_file="$MY_PATH/tests/output/actual/${script_to_test}.txt"
test_folder="$MY_PATH/tests/data/${script_to_test}"

# Check if script exists
if [ ! -f "$script_to_test_full_path" ]; then
    echo "Error: Script '$script_to_test' does not exist"
    exit 1
fi

# Create files and folders if missing
mkdir -p "$test_folder"
if [ ! -f "$expected_output_file" ]; then
    touch "$expected_output_file"
fi

# Run the script and save the output to actual_output_file
(cd "$test_folder" && bash "$script_to_test_full_path" > "$actual_output_file")

# Compare the expected output with the actual output
if diff -q "$expected_output_file" "$actual_output_file" > /dev/null; then
    echo "Test passed: Expected output matches actual."
else
    echo "Test failed: Expected output differs from actual."
    echo "Differences:"
    diff "$expected_output_file" "$actual_output_file"
fi

