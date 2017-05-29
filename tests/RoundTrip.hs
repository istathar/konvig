{-# LANGUAGE OverloadedStrings #-}
{-# OPTIONS -fno-warn-unused-imports #-}

module Main where

import Control.Monad (unless)
import qualified Data.ByteString.Lazy.Char8 as L
import Data.Config.Parser
import Data.Config.Types (Config)
import Data.Config.Pretty (pretty)
import Data.Text (Text)
import qualified Data.Text.IO as T
import Data.Attoparsec.Text
import System.Environment (getArgs)
import System.Exit (die)

main :: IO ()
main = do
    args <- getArgs
    let file = case length args of
            1 -> head args
            _ -> error "Die a horrible death"

    body <- T.readFile file

    let result = parseOnly konvigParser body

    let text = case result of
            Right config -> pretty config
            Left msg -> error msg

    T.putStr text
     
