module Lib
    ( titleString
    ) where

import Data.Text.Titlecase
import qualified Data.Text as T

titleString :: String -> String
titleString x = titlecase x

--pperCase :: String -> String
--upperCase x = T.toUpper T.pack x
