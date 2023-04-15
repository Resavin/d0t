#!/bin/bash

mv ~/.config/awesome ~/.config/awesome__
mv ~/.config/alacritty ~/.config/alacritty__
mv ~/.config/fish ~/.config/fish__
mv ~/.config/picom ~/.config/picom__
mv ~/.config/rofi ~/.config/rofi__
mv ~/.config/starship.toml ~/.config/starship.toml__
mv ~/.config/i3 ~/.config/i3__

ln -s ~/d0t/awesome ~/.config/awesome
ln -s ~/d0t/awesome_new ~/.config/awesome_new
ln -s ~/d0t/alacritty ~/.config/alacritty
ln -s ~/d0t/fish ~/.config/fish
ln -s ~/d0t/picom ~/.config/picom
ln -s ~/d0t/rofi ~/.config/rofi
ln -s ~/d0t/rofi_new ~/.config/rofi_new
ln -s ~/d0t/starship.toml ~/.config/starship.toml

