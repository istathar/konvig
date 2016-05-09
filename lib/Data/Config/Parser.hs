{-# LANGUAGE OverloadedStrings #-}

module Data.Config.Parser where

import Data.Text (Text)
import Text.Trifecta

konvigParser :: Parser Text
konvigParser = return "Hello"

