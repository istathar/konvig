module Data.Config.Types where

import Data.HashMap.Strict (HashMap)
import Data.Text (Text)

type Name = Text
type Version = Int      -- TODO use versions package

type Key = Text
type Value = Text

data Config = Config {
    configSchema  :: Name,
    configVersion :: Version,
    configPairs   :: HashMap Key Value
} deriving Show


