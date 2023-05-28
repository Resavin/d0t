import os
import keyboard
import subprocess
import time

# Directory path where the wallpaper files are stored
wallpaper_directory = "/home/byakuya/Pictures/Cats"

# List to store the wallpaper file names
wallpaper_list = []

# Populate the wallpaper_list with file names from the directory
for file_name in sorted(os.listdir(wallpaper_directory)):
    if file_name.lower().endswith((".jpg", ".jpeg", ".png")):
        wallpaper_list.append(os.path.join(wallpaper_directory, file_name))

# Index to keep track of the current wallpaper in the list
current_wallpaper_index = 0

# Flag to indicate if the script is currently listening for hotkey events
is_listening = True

# Function to change the wallpaper and add filename overlay
def change_wallpaper():
    global current_wallpaper_index, is_listening
    wallpaper_path = wallpaper_list[current_wallpaper_index]
    # subprocess.run(["feh", "--bg-fill", wallpaper_path])
    current_wallpaper_index = (current_wallpaper_index + 1) % len(wallpaper_list)
    
    # Remove the temporary image file
    os.remove(temp_image_path)
    # Extract the filename from the wallpaper path
    filename = os.path.basename(wallpaper_path)
    
    # Generate a temporary image file with the filename overlay
    temp_image_path = "/tmp/wallpaper_temp.png"
    subprocess.run([
        "convert",
        wallpaper_path,
        "-gravity", "northwest",
        "-pointsize", "24",
        "-fill", "white",
        "-annotate", "+10+10", filename,
        "-channel", "RGBA",
        "-gaussian-blur", "0x6",
        temp_image_path
    ])
    
    # Set the wallpaper with the filename overlay
    subprocess.run(["feh", "--bg-fill", temp_image_path])
    
    
    is_listening = False
    time.sleep(1)  # Delay for 1 second
    is_listening = True

# Keyboard event handler
def on_key_event(event):
    global is_listening
    if event.name == "right" and event.event_type == "down" and is_listening:
        change_wallpaper()

# Register the keyboard event handler for the Win+; combination
keyboard.add_hotkey("win+;", change_wallpaper)

# Start listening for keyboard events
keyboard.wait()

