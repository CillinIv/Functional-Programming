module Main where

import Lib
import Data.Set ( fromList, difference, findIndex, elemAt, insert, toList )
import Data.Text.IO
import Data.Text
import Data.List
import System.IO (hSetBuffering, stdin, BufferMode(NoBuffering))
import Control.Monad.Reader (replicateM)
import Control.Monad.RWS.Lazy (unless)
import Control.Monad.RWS.Strict (when)
import GHC.Base (IO(IO))


main :: IO ()
main =
    do
        hSetBuffering stdin NoBuffering
        Prelude.putStrLn "Please enter the name of the file which the words are located : "
        flName <- Prelude.getLine

        textVar <- Data.Text.IO.readFile flName
        dict <- Data.Text.IO.readFile "english.txt"

        let sentence = extractWords textVar
        let dictList = extractWords dict

        let mispelled = spellCheck sentence dictList
        let errCount = Data.List.length mispelled

        --newWord <- Prelude.getLine
        --replaceValue (Data.List.head mispelled) (pack newWord) sentence

        print mispelled
        print errCount

        Prelude.putStrLn "Please enter the replacements : "
        --newWords <- Data.List.take errCount (repeat Prelude.getLine)

        replacement <- replicateM errCount $ do
            Prelude.getLine

        --errorIndex <- replicateM errCount $ do
        do 
            let x = findReplace (Data.List.head mispelled) (pack (Data.List.head replacement)) sentence
            let sentence = x

            let y = removeFirst mispelled
            let mispelled = y

            let y = removeFirst replacement
            let replacment = y
            while (Data.List.length mispelled /= 0)

        let x = findReplace (Data.List.last mispelled) (pack (Data.List.last replacement)) sentence
        let sentence = x



        print sentence















