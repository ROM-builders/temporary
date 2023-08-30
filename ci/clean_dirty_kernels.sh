# Define the base directory where you want to start scanning
BASE_DIR="kernel"

# Function to check if the KernelSU directory is present and remove the folder
remove_if_kernelsu() {
  local dir="$1"
  
  # Check if KernelSU directory exists in the given folder
  if [ -d "$dir/KernelSU" ]; then
    echo "Removing $dir because KernelSU directory is present."
    rm -rf -v "$dir"
  fi
}

# Loop through all subdirectories under kernel/*/*
for dir in "$BASE_DIR"/*/*; do
  # Check if the current path is a directory
  if [ -d "$dir" ]; then
    remove_if_kernelsu "$dir"
  fi
done
