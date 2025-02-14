# My Hammerspoon Hotkeys

This README provides an overview of the custom hotkeys set up in the `init.lua` file for Hammerspoon on this system. Hammerspoon is a tool for powerful automation of macOS. It bridges various system-level APIs into a Lua scripting engine, allowing you to manipulate applications, windows, and other system objects with simple Lua scripts.

## Hotkey Bindings

Below is a list of all the hotkeys configured in the `init.lua` file, along with their descriptions:

### Screen and Window Management

- **Toggle Window Grid** (`⇧ + ⌥ + F`): Displays a grid on the screen to assist with window resizing and moving.
- **Hotkeys Toggle** (`⌘ + ESCAPE`): Toggles the display of hotkeys for the active application.

### Application Shortcuts

- **Switch to WebStorm** (`⌘ + ⇧ + E`): Activates the WebStorm application, bringing it to the foreground if it is already open.

### Mode Switching

- **Toggle Screen Mode** (`⌘ + ⌥ + ⇧ + M`): Toggles the screen mode between predefined resolutions and refresh rates, specifically optimized for either detailed work or general usage.

### Debugging and Information

- **Print Active Screen Info** (`⌘ + ⌥ + ⇧ + A`): Prints information about the currently active screen, including its UUID and name.
- **Print Screen ID** (`⌘ + ⌥ + ⇧ + I`): Outputs the UUID of the main screen to the console, useful for debugging screen-specific scripts.

### Security and Quick Actions

- **Quick Password Type** (`⌘ + ⌥ + ⇧ + Q/W`): Types predefined passwords into the current text field, useful for quick logins (ensure security when using this feature).

## Installation

To use these configurations, ensure that Hammerspoon is installed on your Mac. Then, place the `init.lua` file in your `~/.hammerspoon/` directory. Restart Hammerspoon to load the new configurations.

## Additional Notes

- It's important to handle sensitive data such as passwords with care. Avoid hardcoding sensitive information directly into scripts.
- Modify and extend these hotkeys based on personal productivity needs and security considerations.

For more information on Hammerspoon and its capabilities, visit [Hammerspoon's official website](http://www.hammerspoon.org).
