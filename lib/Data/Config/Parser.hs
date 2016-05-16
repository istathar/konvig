{-# LANGUAGE OverloadedStrings #-}

module Data.Config.Parser where

{-
import Data.Text (Text)
import Data.HashMap.Strict (HashMap)
-}
import qualified Data.HashMap.Strict as Map
import Data.Text (Text)
import qualified Data.Text as T
import Text.Megaparsec
import Text.Megaparsec.Text

import Data.Config.Types


konvigParser :: Parser Config
konvigParser = do
    (name,version) <- schemaLine
    pairs <- dataLine
    return $ Config name version (Map.fromList [pairs])

buildConfig :: (Name,Version) -> [(Key,Value)] -> Parser Config
buildConfig (name,version) pairs = pure $ Config name version (Map.fromList pairs)

identifier :: Parser Name
identifier = T.pack <$> some alphaNumChar <?> "first line must start with schema name"

version :: Parser Version
version = T.pack <$> some digitChar <?> "first line must be of the form \"name vN\" where N is a number"

schemaLine :: Parser (Name,Version)
schemaLine = (,) <$> identifier <* spaceChar <* char 'v' <*> version


dataLine :: Parser (Key,Value)
dataLine = return ("word","Hi There")

