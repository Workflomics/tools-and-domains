#!/bin/bash

# Set the base directory
base_dir="cwl-tools"

# Create arrays and counters for passed, failed tests, and missing scripts
declare -a failed_tests
passed_tests_count=0
failed_tests_count=0
missing_script_count=0

# Iterate over all directories (tool-names) in the base directory
for tool_dir in "$base_dir"/*/; do
    # Define the path to the 'test' directory for the current tool
    script_dir="${tool_dir}test"

    # Check if the 'run-cwl.sh' script exists
    if [ -f "$script_dir/run-cwl.sh" ]; then
        echo "Testing $script_dir..."

        (cd "$script_dir" && bash "./run-cwl.sh")
        if [ $? -eq 0 ]; then
            ((passed_tests_count++))  # Increment passed tests counter
        else
            failed_tests+=("$script_dir/run-cwl.sh")
            ((failed_tests_count++))  # Increment failed tests counter
        fi

    else
        echo "❗ Script not found in directory: $script_dir"
        ((missing_script_count++))  # Increment the missing script counter
    fi
done

# Print missing test script count
if [ $missing_script_count -gt 0 ]; then
    echo "❗ $missing_script_count tools did not have a test script"
fi

# Print a summary of test results
if [ $failed_tests_count -eq 0 ]; then
    echo "✅ $passed_tests_count tests passed successfully"
    exit 0
else
    echo "The following tests failed:"
    for test in "${failed_tests[@]}"; do
        echo "🚨 $test"
    done
    exit 1
fi
