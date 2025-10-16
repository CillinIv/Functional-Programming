module Palindrome where

import Data.Char ( isSpace, isPunctuation, toLower )
import Data.Text as T ( Text, filter, pack, reverse, toLower )

isPalindrome :: String -> String
isPalindrome xs =
    if xs.toLower == reverse xs.toLower
        then "It is a palindrome" else  "It is not a palindrome"
