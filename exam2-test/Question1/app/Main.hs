module Main where

import qualified Data.Text as T
import Lib

aWord :: T.Text
aWord = T.pack "Choose" -- T.pack returns the Text version of a String

tReplace :: T.Text -> T.Text -> T.Text -> T.Text -- replaces first occurrence of needle by replacement in haystack
tReplace needle replacement haystack = 
    T.intercalate replacement (T.splitOn needle haystack)

main :: IO ()
main = do
    let newWord = tReplace (T.pack "oo") (T.pack "ee") aWord in print newWord