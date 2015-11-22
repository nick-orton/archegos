module Main where

import System.Process
import Control.Exception
import Data.Char
import qualified UI.HSCurses.Curses as Curses
import qualified UI.HSCurses.CursesHelper as CursesH



selections = [("Drop to term", "foo"),
              ("Xmonad", "bar")]
internalMargin = 3

addSelectionsToWindow w ctr [] = return ()
addSelectionsToWindow w ctr ((s,_):selections) = do
  let display = (show ctr) ++ ": " ++ s
  Curses.mvWAddStr w (2+ctr) internalMargin display
  addSelectionsToWindow w (ctr+1) selections
 
eventLoop  = do
  drawWindow
  k <- Curses.getCh
  case k of
    Curses.KeyChar c -> process c
    _ -> eventLoop
  where process x = 
          do if (isDigit x) && length selections > (digitToInt x) 
               then do let (_,v) = (selections!!(digitToInt x))
                       p <- createProcess (proc "echo" [v])
                       return ()
               else eventLoop

mkWindow = do
  let height = (length selections + 4)
      width = 76
      lMargin = 2
      tMargin = 2
  w <- Curses.newWin height width lMargin tMargin
  Curses.wBorder w Curses.defaultBorder
  Curses.wAddStr w "Choose WM: "
  addSelectionsToWindow w 0 selections
  return w


drawWindow = do
    w <- mkWindow
    Curses.wRefresh w
    return w
 
runCurses = do
  CursesH.start
  Curses.cursSet Curses.CursorInvisible
  eventLoop


main = do
  runCurses `finally` CursesH.end
  return 0

