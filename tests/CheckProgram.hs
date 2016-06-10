{-# LANGUAGE OverloadedStrings #-}

module Main where

import Data.Text (Text)
import Test.Hspec
import Test.Hspec.Attoparsec

import Data.Config.Parser

main :: IO ()
main = hspec suite

suite :: Spec
suite = do
    describe "Basic structure" $ do
        it "minimal file requires schema line" $ do
            ("dhcpcd v1\n" :: Text) ~> schemaLine `shouldParse` ("dhcpcd", "1")
