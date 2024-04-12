#!usr/bin/env bash

# initializing wallpaper daemon
swww init &
# setting wallpaper
swww img ~/Wallpapers/1.jpg &
swww img ~/Wallpapers/2.jpg &
swww img ~/Wallpapers/3.png &
swww img ~/Wallpapers/4.png &
swww img ~/Wallpapers/5.jpg &
swww img ~/Wallpapers/6.png &
swww img ~/Wallpapers/7.jpg &
swww img ~/Wallpapers/8.jpg &

waybar &

dunst
