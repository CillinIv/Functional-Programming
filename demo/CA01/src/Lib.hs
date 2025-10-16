module Lib
    (extractWords
    ,allWordsReport
    ,spellCheck
    ,findReplace
    ) where

import qualified Data.Text as T
import qualified Data.Text.Internal.Builder
import Data.Char
import Data.Text.IO
import Data.Text
import Data.List
import Data.Set ( fromList, difference, findIndex, elemAt, insert, toList )
import Fmt


-- takes one Text (e.g. unprocessed input from file) and returns a list of text. Note the use of 'as pattern' here (later)
extractWords :: Text -> [Text]
extractWords t =  ws
  where
    ws = Prelude.map Data.Text.toCaseFold $ Data.List.filter (not . T.null)
         $ Prelude.map cleanWord $ Data.Text.words t
    cleanWord = T.dropAround (not . isLetter)

-- This uses the Format library and the fmt function. It is a formatting library. in this case it attaches a name (msg) to a list(of Text), line by line.
allWordsReport :: String -> [Text] -> Text
allWordsReport msg words =
  fmt $ nameF (Data.Text.Internal.Builder.fromString msg)  $ unlinesF words

-- replaceAt :: Int -> Text -> [Text] -> [Text]
-- replaceAt pos newText setToChange = 
--     do
--         let (x,_ :ys) =  Data.Text.splitAt pos setToChange
--         let x = pop x
--         x ++ newText : ys


spellCheck :: [Text] -> [Text] -> [Text]
spellCheck words dict = ms
    where
        ms = toList ( difference (fromList words) (fromList dict))

findReplace :: Text -> Text -> [Text] -> [Text]
findReplace x y = Prelude.map (\h -> if h == x then y else h)