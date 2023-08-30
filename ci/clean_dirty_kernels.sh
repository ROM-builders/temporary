#!/bin/bash

# Define the base directory where you want to start scanning
BASE_DIR="kernel"

# Function to check if the KernelSU directory is present and remove subdirectories
remove_subdirs_if_kernelsu() {
  local dir="$1"

  # Check if KernelSU directory exists at any level in the given folder
  if find "$dir" -type d -name "KernelSU" | grep -q .; then
    echo "Removing subdirectories of $dir because KernelSU directory is present."
    find "$dir" -mindepth 1 -maxdepth 1 -type d -exec rm -rf -v {} \;
  fi
}

# Loop through all subdirectories under kernel
for dir in "$BASE_DIR"/*; do
  # Check if the current path is a directory
  if [ -d "$dir" ]; then
    remove_subdirs_if_kernelsu "$dir"
  fi
done

echo "Dirty kernel trees with KernelSU residues cleaned. Job complete."
