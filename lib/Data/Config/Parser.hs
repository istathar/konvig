{-# LANGUAGE OverloadedStrings #-}

module Data.Config.Parser where

{-
import Data.Text (Text)
import Data.HashMap.Strict (HashMap)
-}
import qualified Data.HashMap.Strict as Map
import Text.Megaparsec
import Text.Megaparsec.String

import Data.Config.Types


konvigParser :: Parser Config
konvigParser = do
    (name,version) <- schemaLine
    pairs <- dataLine
    return $ Config name version (Map.fromList [pairs])

buildConfig :: (Name,Version) -> [(Key,Value)] -> Parser Config
buildConfig (name,version) pairs = pure $ Config name version (Map.fromList pairs)


schemaLine :: Parser (Name,Version)
schemaLine = return ("dhcp", 8)

dataLine :: Parser (Key,Value)
dataLine = return ("word","Hi There")
