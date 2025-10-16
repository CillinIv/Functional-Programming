module Main where

import qualified Data.Text as T
import Lib

main :: IO ()
main = do
    putStrLn "Please enter words: "
    input <- getLine
    print $titleString input

