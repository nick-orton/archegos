This intends to be a ncurses based Display Manager much like CDM for Arch
But I want to write it in haskell, so there.


## Config
By default, archegos looks in $HOME/.config/archegos/archegos.conf for it's 
configuration file.  You can find an example config file in 
config/archegos.example.config

The config file has the format of:

    title:     "My Menu Title"
    executable: echo
    selections:
     - "SelectionDisplay1, Target1"
     - "SelectionDisplay2, Target2"

# PLANS

- ncurses based front end that allows user to choose one of the display-names,
  and launches startx with the init file
- option 0 is always drop back into terminal

# Bonus Points
- color schemes in config file

#TODOS
Choose the program to use to startx
use $XDG_CONFIG_HOME if present
write YAML parser to split tuples
