#!/bin/bash

config_dir="$HOME/.config"
dotfiles_dir="./dot-config"
dotfiles_package="dot-config"

if [ -e $dotfiles_dir ]; then
  for file in $dotfiles_dir/*; do
      # Extract filename from the full path
      filename=$(basename "$file")
      full_filename="$config_dir/$filename"
      # Check if a corresponding file exists in ~/.config
      if [ -e "$full_filename" ]; then
         mv "$full_filename" "$full_filename.bak"
         echo "Backed up $full_filename"
      fi
  done
  git clone https://github.com/NvChad/starter $config_dir/nvim
  stow -t $config_dir -S $dotfiles_package
else
  echo "dotfiles_dir not found, check if you launch the script from d0t directory"
fi

if [ -e $HOME/.tmux.conf ] || [ -e $HOME/.tmux ]; then
  echo "tmux is already there, not doing anything with it"
else
  stow -t $HOME -S tmux
fi
