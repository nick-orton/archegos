{-# LANGUAGE OverloadedStrings #-}
module ConfigReader where

import System.Environment
import Data.Yaml
import Control.Applicative
import Data.List.Split
import qualified Data.ByteString.Char8 as BS

data ArcConfig = ArcConfig {title :: String,
                            selections :: [String]} deriving (Show)

instance FromJSON ArcConfig where
    parseJSON (Object v) = ArcConfig <$>
                           v .: "title" <*>
                           v .: "selections"
    -- A non-Object value is of the wrong type, so fail.
    parseJSON _ = error "Can't parse MyUser from YAML/JSON"

readArcConfig :: IO ArcConfig
readArcConfig = do
  let homeDir = getEnv "HOME" 
      configFileLocation = (++) <$> homeDir <*> pure "/.config/archegos/archegos.conf" :: IO String
  byteString <- configFileLocation >>= BS.readFile
  let Just config = Data.Yaml.decode byteString
  return config
 
readSelections :: ArcConfig -> [(String,String)]
readSelections arcConfig = 
   map (\s -> tuplefy (splitOn "," s)) raw
   where 
     raw = selections arcConfig
     tuplefy [x,y] = (x,y)
