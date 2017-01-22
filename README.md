# hammerspoon-config

This contains my `init.lua` script, as well as a directory of modules for easier manipulation and organization of hammerspoon configurations. To use this, you can clone the repository anywhere on your machine, and then symlink your `.hammerspoon` directory to it.

```bash
$ ln -s path/to/hammerspoon-config/ ~/.hammerspoon
```

### Quick links

* [Hammerspoon: Getting Started](http://www.hammerspoon.org/go/)
* [Hammerspoon: API Docs](http://www.hammerspoon.org/docs/index.html)
* [Hammerspoon: Examples](https://github.com/Hammerspoon/hammerspoon/wiki/Sample-Configurations)
* [Learn Lua in Y Mnutes](https://learnxinyminutes.com/docs/lua/)

## Included modules

* [Grid](modules/grid.lua) - 9 column x 9 row grid with 0 margins

## Keybindings

* "mash" refers to pressing <kbd>⌘ + ⌥ + ⌃ </kbd> at once.
* "mashshift" refers to pressing <kbd>⌘ + ⌥ + ⌃ + ⇧ </kbd> at once.

| Key Combination           | Description                                                  |
| ------------------------- | ------------------------------------------------------------ |
| mash + <kbd>G</kbd>       | Quick window navigation hints.                               |
| mashshift + <kbd>G</kbd>  | Show screen grid.                                            |
| mash + <kbd>;</kbd>       | Snaps the focused window to the grid.                        |
| mash + <kbd>'</kbd>       | Snaps *all* visible windows to the grid.                     |
| mash + <kbd>=</kbd>       | Makes active window wider by one grid column (from right).   |
| mash + <kbd>-</kbd>       | Makes active window thinner by one grid column (from right). |
| mashshift + <kbd>=</kbd>  | Makes active window taller by one grid row (bottom side).    |
| mashshift + <kbd>-</kbd>  | Makes active window shorter by one grid row (bottom side).   |
| mash + <kbd>←</kbd>       | Moves active window one grid cell left.                      |
| mash + <kbd>→</kbd>       | Moves active window one grid cell right.                     |
| mash + <kbd>↑</kbd>       | Moves active window one grid cell up.                        |
| mash + <kbd>↓</kbd>       | Moves active window one grid cell down.                      |
| mashshift + <kbd>←</kbd>  | Focuses on the window to the left of the current window.     |
| mashshift + <kbd>→</kbd>  | Focuses on the window to the right of the current window.    |
| mashshift + <kbd>↑</kbd>  | Focuses on the window above the current window.              |
| mashshift + <kbd>↓</kbd>  | Focuses on the window below the current window.              |
| mash + <kbd>M</kbd>       | Maximize the current window.                                 |
| mash + <kbd>F</kbd>       | Make the current window fullscreen.                          |
| mash + <kbd>C</kbd>       | Center the current window and make it fullscreen.            |
| mashshift + <kbd>C</kbd>  | Center the current window on screen.                         |
| mash + <kbd>J</kbd>       | Snaps the focused window to top 50%.                         |
| mash + <kbd>K</kbd>       | Snaps the focused window to bottom 50%.                      |
| mash + <kbd>L</kbd>       | Snaps the focused window to left 50%.                        |
| mash + <kbd>H</kbd>       | Snaps the focused window to right 50%.                       |
| mash + <kbd>U</kbd>       | Snaps the focused window to top left corner.                 |
| mash + <kbd>I</kbd>       | Snaps the focused window to top right corner.                |
| mash + <kbd>O</kbd>       | Snaps the focused window to bottom left corner.              |
| mash + <kbd>Y</kbd>       | Snaps the focused window to bottom right corner.             |
| mashshift + <kbd>J</kbd>  | Snaps the focused window to left 33%.                        |
| mashshift + <kbd>K</kbd>  | Snaps the focused window to left 66%.                        |
| mashshift + <kbd>L</kbd>  | Snaps the focused window to right 33%.                       |
| mashshift + <kbd>H</kbd>  | Snaps the focused window to right 66%.                       |
| mashshift + <kbd>U</kbd>  | Snaps the focused window to top 33%.                         |
| mashshift + <kbd>I</kbd>  | Snaps the focused window to top 66%.                         |
| mashshift + <kbd>O</kbd>  | Snaps the focused window to bottom 33%.                      |
| mashshift + <kbd>Y</kbd>  | Snaps the focused window to bottom 66%.                      |
| mash + <kbd>N</kbd>       | Pushes the current window to the next monitor.               |
| mash + <kbd>P</kbd>       | Pushes the current window to the previous monitor.           |

### Karabiner

If you want to make the keybindings easier, install Karabiner and Seil for key re-mapping. Here are the steps I take:

1. Disable your CapsLock key under _System Preferences > Keyboard > Keyboard : Modifier Keys_.
2. In Seil, change the CapsLock key to keycode 80 (F19 on my machine).
3. In Karabiner, enable the **F19 to Escape and Control** preference under _Custom Shortcuts_
4. Add the following XML snippet to your `private.xml` file in Karabiner. This makes your CapsLock key the mash key, which can be used with all the keybindings above.

```xml
<?xml version="1.0"?>
<root>
    <item>
        <name>Remap CapsLock to Hyper</name>
        <appendix>OS X doesn't have a Hyper. This maps Left Control to Control + Shift + Option + Command.</appendix>
        <identifier>caps_lock_to_hyper</identifier>
        <autogen>
            --KeyToKey--
            KeyCode::F19,
            KeyCode::COMMAND_L, ModifierFlag::OPTION_L | ModifierFlag::CONTROL_L
        </autogen>
    </item>
</root>
```
