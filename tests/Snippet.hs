{-# LANGUAGE OverloadedStrings #-}
{-# OPTIONS -fno-warn-unused-imports #-}

module Main where

import qualified Data.ByteString.Lazy.Char8 as L
import Data.Config.Parser
import Data.Text (Text)
import qualified Data.Text.IO as T
import Data.Attoparsec.Text

example :: Text
example = "fortune v1\nfunny \"true\"\nwe@t$her \"dry\"\n"

main :: IO ()
main = do
    print $ parseOnly konvigParser example
