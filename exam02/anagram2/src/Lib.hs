module Lib
    ( isAnagram
    ) where

import Data.List

isAnagram :: String-> String ->  Bool
isAnagram tstr1 tstr2 = sort tstr1 == sort tstr2
