module Main where

import System.Process (createProcess, proc)
import Control.Exception (finally)
import Data.Char (digitToInt, isDigit)
import qualified ConfigReader as CR
import qualified UI.HSCurses.Curses as Curses
import qualified UI.HSCurses.CursesHelper as CursesH


-- Selections are a collection of tuples.  The first member of the tuple is the
-- string to display in the menue.  The second member is the target to execute.
-- selections = [("Drop to term", "foo"),
--               ("Xmonad", "bar")]

-- Styling constants for the menu
padding = 3
topPadding = 2
menuWidth = 76
margin = 2

-- This writes the display strings from the selections list into the menu
addSelectionsToMenu menu ctr [] = return ()
addSelectionsToMenu menu ctr ((s,_):selections) = do
  let display = show ctr ++ ": " ++ s
  Curses.mvWAddStr menu (topPadding+ctr) padding display
  addSelectionsToMenu menu (ctr+1) selections
 
-- Draw the menu acording to the size of the selections list and the constants
-- listed above.
drawMenu selections = do
  let height = length selections + 4
  menu <- Curses.newWin height menuWidth margin margin
  Curses.wBorder menu Curses.defaultBorder
  Curses.wAddStr menu "Choose WM: "
  addSelectionsToMenu menu 0 selections
  Curses.wRefresh menu
  return menu

-- The main event loop.  This draws the menu and then waits for a keypress.
-- If the key pressed is a value for one of the selections, it echos out the
-- target for the selection
eventLoop selections = do
  drawMenu selections
  k <- Curses.getCh
  case k of
    Curses.KeyChar c -> process c
    _ -> eventLoop selections
  where process c = 
          if isDigit c && length selections > digitToInt c 
          then do let (_,target) = selections !! digitToInt c
                  p <- createProcess (proc "echo" [target])
                  return ()
          else eventLoop selections




-- Initialize the curses, set the cursor invisible and start the event loop.
runCurses = do
  CursesH.start
  Curses.cursSet Curses.CursorInvisible
  selections <- CR.readSelections
  eventLoop selections


-- Runs the curses and always safely shuts down
main = runCurses `finally` CursesH.end

