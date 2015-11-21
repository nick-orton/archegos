module Main where

import System.Process
import qualified UI.HSCurses.Curses as Curses
import qualified UI.HSCurses.CursesHelper as CursesH


selections = ["0: Drop to term",
              "1: Xmonad"]
internalMargin = 3

addSelectionsToWindow w ctr [] = return ()
addSelectionsToWindow w ctr (s:selections) = do
  Curses.mvWAddStr w (2+ctr) internalMargin s
  addSelectionsToWindow w (ctr+1) selections
  


-- TODO make this return window instead of IO window
mkWindow = do
  let height = 6
      width = 76
      lMargin = 2
      tMargin = 2
      internalMargin = 3
  w <- Curses.newWin height width lMargin tMargin
  Curses.wBorder w Curses.defaultBorder
  Curses.wAddStr w "Choose WM: "
  addSelectionsToWindow w 0 selections
  return w


drawWindow = do
    w <- mkWindow
    Curses.wRefresh w
  

main = do
  CursesH.start
  Curses.refresh
  drawWindow
  Curses.getCh
  p <- createProcess (proc "echo" ["foo"])
  CursesH.end
  return 0

