module Main where

import System.Process

main = do
  p <- createProcess (proc "echo" ["foo"])
  return 0

