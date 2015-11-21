module Main where

import System.Process
import qualified UI.HSCurses.Curses as Curses
import qualified UI.HSCurses.CursesHelper as CursesH

drawWindow = do
  let height = 6
      width = 76
      lMargin = 2
      tMargin = 2
      internalMargin = 3
  w <- Curses.newWin height width lMargin tMargin
  Curses.wBorder w Curses.defaultBorder
  Curses.wAddStr w "Choose WM: "
  Curses.mvWAddStr w 2 internalMargin "0: Drop to term"
  Curses.mvWAddStr w 3 internalMargin "1: Xmonad"
  Curses.wRefresh w
  

main = do
  CursesH.start
  Curses.refresh
  drawWindow
  Curses.getCh
  p <- createProcess (proc "echo" ["foo"])
  CursesH.end
  return 0

