{-# LANGUAGE OverloadedStrings #-}
{-# OPTIONS -fno-warn-unused-imports #-}

module Main where

import Data.Aeson
import Data.Aeson.Encode.Pretty
import qualified Data.ByteString.Lazy.Char8 as L
import Data.Config.Parser
import qualified Data.Text.IO as T
import Text.Trifecta

main :: IO ()
main = do
    parseTest konvigParser "fortune v1\nfunny=\"true\"\n"