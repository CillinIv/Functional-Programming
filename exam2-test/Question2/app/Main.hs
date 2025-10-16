module Main where

import qualified Data.Text as T
import Lib


aWord :: T.Text
aWord = T.pack "Choose" -- T.pack returns the Text version of a String



main :: IO ()
main = do
    let newWord = tReplace (T.pack "oo") (T.pack "ee") aWord in print newWord