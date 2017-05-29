module Data.Config.Pretty where

import Data.HashMap.Strict (HashMap, foldrWithKey)
import Data.Text (Text)
import Data.Text.Lazy (toStrict)
import Data.Text.Lazy.Builder

import Data.Config.Types

pretty :: Config -> Text
pretty = toStrict . toLazyText . renderConfig

renderConfig :: Config -> Builder
renderConfig config = mconcat
    [ fromText schema
    , fromString " v"
    , fromText version
    , singleton '\n'
    , renderPairs pairs
    ]
  where
    schema = configSchema config
    version = configVersion config 
    pairs = configPairs config


renderPairs :: HashMap Key Value -> Builder
renderPairs pairs =
    foldrWithKey renderPair mempty pairs 

renderPair :: Key -> Value -> Builder -> Builder
renderPair key value built = mconcat
    [ built
    , fromText key
    , fromString " \""
    , fromText value
    , fromString "\"\n"
    ]

