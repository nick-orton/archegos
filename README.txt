This intends to be a ncurses based Display Manager much like CDM for Arch
But I want to write it in haskell, so there.


## Config
By default, archegos looks in $HOME/.config/archegos/archegos.conf for it's 
configuration file.

The config file has the format of:

    title:     "My Menu Title"
    selections:
     - "SelectionDisplay1, Target1"
     - "SelectionDisplay2, Target2"

# PLANS

- config file written in yml sitting in .xconfig/hdm
- config file has links to welcome message and key-value pairs of display-name,
  .xinit files
- ncurses based front end that allows user to choose one of the display-names,
  and launches startx with the init file
- menu selection should be white-highlighted
- box around menu with drop-shadow
- option 0 is always drop back into terminal

# Bonus Points
- color schemes in config file

#TODOS
use $XDG_CONFIG_HOME if present
write YAML parser to split tuples
