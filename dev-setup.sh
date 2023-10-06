#!/usr/bin/env bash

# Ensure script is called correctly using source
# Ignore shellcheck warining. not accessing an index is intentional here
# shellcheck disable=SC2128 
if [ "$0" != "$BASH_SOURCE" ]; then
    echo "Performing Development setup..."
else
    echo "You need to call this script using the command source. Please execute:"
    echo "source $0"
    exit 1
fi

# Find the conda command to use (conda or mamba)
if type "mamba" >/dev/null 2>&1; then
    CONDA_CMD="mamba"
elif type "conda" >/dev/null 2>&1; then
    CONDA_CMD="conda"
else
    echo "No conda command found"
    exit 1
fi

# Extract the conda environment name from env.yml
CONDA_ENV=$(grep 'name:' env.yml | cut -f 2 -d ' ')

# Check if the conda environment already exists
if $CONDA_CMD env list | grep -q "$CONDA_ENV"; then
    $CONDA_CMD env update -f env.yml
else
    $CONDA_CMD env create -f env.yml
fi

# Activate the conda environment and execute poetry install
if $CONDA_CMD activate "$CONDA_ENV" 2>/dev/null || conda activate "$CONDA_ENV" 2>/dev/null; then
    poetry config --local virtualenvs.create false
    poetry update
    poetry install
else
    echo "Failed to activate the conda environment."
    exit 1
fi

echo "Environment setup finished successfully." 
echo "Please ensure to set python interpreter of your IDE to the conda environment $CONDA_ENV"
