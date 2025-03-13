#!/bin/bash

# TXT to JSON Converter Runner
# This script runs the txt_to_json.py Python script

echo "TXT to JSON Converter Runner"
echo "==========================="
echo

# Check if Python is installed
if ! command -v python &> /dev/null; then
    if command -v python3 &> /dev/null; then
        PYTHON_CMD="python3"
    else
        echo "Error: Python is not installed or not in PATH"
        exit 1
    fi
else
    PYTHON_CMD="python"
fi

# Create directories if they don't exist
mkdir -p input output completed

# Check if there are any .txt files in the input directory
if [ -z "$(ls -A input/*.txt 2>/dev/null)" ]; then
    echo "No .txt files found in the input directory."
    echo "Please place your .txt files in the 'input' directory and run this script again."
    exit 0
fi

# Run the Python script
echo "Running converter script..."
$PYTHON_CMD txt_to_json.py

# Check if the script ran successfully
if [ $? -eq 0 ]; then
    echo
    echo "Conversion completed successfully!"
    echo "JSON files are in the 'output' directory."
    echo "Processed text files are in the 'completed' directory."
else
    echo
    echo "Error: Conversion failed. Please check the error messages above."
fi 