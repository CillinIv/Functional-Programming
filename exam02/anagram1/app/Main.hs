module Main where

import Data.List
isAnagram :: String-> String ->  Bool
isAnagram tstr1 tstr2 = sort tstr1 == sort tstr2

main :: IO ()
main = do
  putStrLn "Please enter the first word: "
  str1 <-  getLine

  putStrLn "Please enter the second word: "
  str2 <-  getLine

  putStr "\n"
  if isAnagram str1 str2
    then putStrLn "these strings are anagrams of each other"
    else putStrLn "they are not!"
