{-# LANGUAGE OverloadedStrings #-}

module Data.Config.Parser where

import Prelude hiding (takeWhile)
{-
import Data.Text (Text)
import Data.HashMap.Strict (HashMap)
-}
import Control.Applicative
import Data.Char
import qualified Data.HashMap.Strict as Map
import Data.Text (Text)
import qualified Data.Text as T
import Data.Attoparsec.Text

import Data.Config.Types


konvigParser :: Parser Config
konvigParser = do
    (name,version) <- schemaLine
    pairs <- many dataLine
    return $ Config name version (Map.fromList pairs)

identifier :: Parser Name
identifier = takeWhile isAlphaNum
    <?> "first line must start with schema name"

version :: Parser Version
version = takeWhile isDigit <?> "first line must be of the form \"name vN\" where N is a number"

schemaLine :: Parser (Name,Version)
schemaLine = (,) <$> identifier <* space <* char 'v' <*> version <* endOfLine

dataLine :: Parser (Key,Value)
dataLine = (,) <$> key <* skipWhile isHorizontalSpace <*> value <* endOfLine

key :: Parser Key
key = takeWhile isAlphaNum
    <?> "key must be an alpha-numeric identifier"

value :: Parser Value
value = char '"' *> quoteEscapedString <* char '"'
    <?> "values must be text, enclosed by '\"' characters"

quoteEscapedString :: Parser Text
quoteEscapedString = scan False forEscape
  where
    forEscape :: Bool -> Char -> Maybe Bool
    forEscape escape ch = case ch of
        '"' -> case escape of
                True    -> Just False
                False   -> Nothing      -- found end of string, done!
        '\\' -> case escape of
                True    -> Just False
                False   -> Just True    -- potential escaped quote following
        _   -> Just False
