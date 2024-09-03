#!/bin/bash

# List of directories to process
directories=("1365" "3146" "1512" "2325")

# Iterate over each directory
for dir in "${directories[@]}"; do
  echo "Processing directory: $dir"
  
  # Change to the target directory
  cd "$dir" || { echo "Directory $dir not found!"; exit 1; }
  
  # Initialize with forge
  forge init contracts --no-commit
  
  # Change to the contracts directory
  cd contracts || { echo "Contracts directory not found in $dir!"; exit 1; }
  
  # Remove specified files
  rm -rf src/Counter.sol
  rm -rf test/Counter.t.sol
  rm -rf script/Counter.s.sol
  
  # Return to the parent directory
  cd ../..
  
  # Print current working directory
  echo "Current directory: $(pwd)"
  
  # Indicate completion of the directory processing
  echo "Completed processing directory: $dir"
done

# Final message after all directories are processed
echo "All directories processed."
