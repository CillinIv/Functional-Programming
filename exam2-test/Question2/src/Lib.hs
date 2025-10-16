module Lib
    ( tReplace
    ) where

import qualified Data.Text as T

tReplace :: T.Text -> T.Text -> T.Text -> T.Text -- replaces first occurrence of needle by replacement in haystack
tReplace needle replacement haystack = 
    T.intercalate replacement (T.splitOn needle haystack)
