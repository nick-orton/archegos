{-# LANGUAGE OverloadedStrings #-}
module ConfigReader where

import System.Environment
import Data.Yaml
import Control.Applicative
import Data.List.Split
import qualified Data.ByteString.Char8 as BS

tuplefy :: [a] -> (a,a)
tuplefy [x,y] = (x,y)

splitToTuple :: String-> (String, String)
splitToTuple s = tuplefy (splitOn "," s)

data ArcConfig = ArcConfig {title :: String,
                            selections :: [String]} deriving (Show)

instance FromJSON ArcConfig where
    parseJSON (Object v) = ArcConfig <$>
                           v .: "title" <*>
                           v .: "selections"
    -- A non-Object value is of the wrong type, so fail.
    parseJSON _ = error "Can't parse MyUser from YAML/JSON"

readArcConfig = do
  homeDir <- (getEnv "HOME") 
  let configFileLocation =  homeDir ++ "/.config/archegos/archegos.conf"
  ymlData <- BS.readFile configFileLocation
  let Just config = Data.Yaml.decode ymlData :: Maybe ArcConfig
  return config
 

readSelections = do
  config <- readArcConfig
  let sels = selections config
      splitSelections = map splitToTuple sels
  return splitSelections
