module Palindrome where

isPalindrome :: String -> String
isPalindrome xs =
    if xs == reverse xs
        then "It is a palindrome" else  "It is not a palindrome"
