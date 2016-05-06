{-# LANGUAGE OverloadedStrings #-}

module Main where

import Test.Hspec

import Data.Config.Parser

main :: IO ()
main = hspec suite

suite :: Spec
suite = do
    describe "Things" $ do
        it "can be done with stuff" $ do
            True `shouldbe` True
