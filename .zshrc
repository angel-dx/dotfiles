nvim-clean() {
  echo "Cleaning Neovim and Lazy.nvim caches and packages..."

  # Define Neovim and Lazy.nvim directories
  NVIM_CACHE="${XDG_CACHE_HOME:-$HOME/.cache}/nvim"
  NVIM_STATE="${XDG_STATE_HOME:-$HOME/.local/state}/nvim"
  NVIM_DATA="${XDG_DATA_HOME:-$HOME/.local/share}/nvim"

  # Lazy.nvim usually stores plugins here
  LAZY_DIR="$NVIM_DATA/lazy"

  # Remove caches
  echo "Removing Neovim cache: $NVIM_CACHE"
  rm -rf "$NVIM_CACHE"

  # Remove Lazy.nvim installed plugins
  echo "Removing Lazy.nvim plugins: $LAZY_DIR"
  rm -rf "$LAZY_DIR"

  # Optionally remove Neovim state and data (uncomment if needed)
  # echo "Removing Neovim state: $NVIM_STATE"
  # rm -rf "$NVIM_STATE"

  # echo "Removing Neovim data (excluding plugins): $NVIM_DATA"
  # rm -rf "$NVIM_DATA"

  echo "Cleanup complete ✅"
}
