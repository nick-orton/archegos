{-# LANGUAGE OverloadedStrings #-}
module ConfigReader where

import System.Environment
import Data.Yaml
import Control.Applicative
import qualified Data.ByteString.Char8 as BS

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
  let config = Data.Yaml.decode ymlData :: Maybe ArcConfig
  return config


