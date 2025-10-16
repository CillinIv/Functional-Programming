{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE OverloadedStrings #-}

module StatReport where


import Data.Ord (comparing)
import Data.Foldable (minimumBy, maximumBy)
import Data.Time (diffDays)
import Data.List (sort)
import Fmt      -- used for formating text
    ( Buildable(..),
      Builder,
      (+|),
      (+||),
      pretty,
      (|+),
      (||+),
      fixedF )  

import Colonnade ( ascii, headed )
import CovidData ( field2fun, QField(Total_cases), CovidData(date), toDouble, DefaultToZero )

decimalPlacesFloating :: Int
decimalPlacesFloating = 2

data StatValue = StatValue {     --this is used to format the calculated fields
    decimalPlaces :: Int,
    value :: Double
  }

data StatEntry = StatEntry {     -- where we store our stat results
    qfield :: QField,
    meanVal :: StatValue,
    minVal :: StatValue,
    maxVal :: StatValue,
    daysBetweenMinMax :: Int
  }

mean :: (Fractional a, Foldable t) => t a -> a   --this allow us to calculate our mean for any foldable type
mean xs = sum xs / fromIntegral (length xs)

computeMinMaxDays :: (Ord a, Foldable t) =>      --this has an extra parameter 'get' whuch allows us to indicate which field of QuoteData to compute on
                                                  -- we use this in statInfo to compute for all the fields of QuoteData
                     (CovidData -> a) -> t CovidData -> (a, a, Int)
computeMinMaxDays get quotes = (get minQ, get maxQ, days)
  where
    cmp = comparing get
    minQ = minimumBy cmp quotes
    maxQ = maximumBy cmp quotes
    days = fromIntegral $ abs $ diffDays (date minQ) (date maxQ)

statInfo :: (Functor t, Foldable t) => t CovidData -> [StatEntry]
statInfo quotes = fmap qFieldStatInfo [minBound .. maxBound]        -- this says 'use all of the qField values from start to finish in that order (Open .. Volume)
                                                                    -- from 'data QField = Open | Close | High | Low | Volume' in QuoteData
  where  
    decimalPlacesByQField Total_cases = 0                                -- this is for the integral field - no fractional part
    decimalPlacesByQField _ = decimalPlacesFloating                 -- the other fields get 2 decimal places 

    qFieldStatInfo qfield =
      let
        get = field2fun qfield                                       --this brings in the field (open, close that we are working on)
        (mn, mx, daysBetweenMinMax) =
              computeMinMaxDays get quotes                          -- get would be e.g. open
        decPlaces = decimalPlacesByQField qfield
        meanVal = StatValue decimalPlacesFloating
                            (mean $ fmap get quotes)                -- extract a Foldable with one field
        minVal = StatValue decPlaces mn
        maxVal = StatValue decPlaces mx
      in StatEntry {..}                                               -- build up  a list of StatEntry as the result, usinga RecordWildCards to fill the record

divideInt :: Int -> Int -> Float
divideInt a b = (fromIntegral a) / (fromIntegral b)

divideDoubleInt :: Double -> Int -> Double
divideDoubleInt a b = (a) / (fromIntegral b)

divideFloatInt :: Float -> Int -> Float
divideFloatInt a b = (a) / (fromIntegral b)

percentile :: [Double] -> Int -> Double
percentile xs x = val where          -- n = (P/100) x N
  n = (divideInt x 100) * fromIntegral (length xs)
  val = xs !! round n

standardDeviation :: [Double] -> Double
standardDeviation xs = sd where
  mean = divideDoubleInt (sum xs) (length xs)
  mapVals = map (\x -> distance x mean ) xs
  sumVals = sum mapVals
  dataPoints = divideDoubleInt sumVals (length xs)
  sd = sqrt(dataPoints)

skewness :: [Double] -> Double -> Double
skewness xs cor = skew where
  mean = divideDoubleInt (sum xs) (length xs)
  med = (sort xs) !! round (divideInt (length xs)  2)
  skew = ( (3 * (mean - med)) / cor )

distance :: Double -> Double -> Double
distance a b = val where
   val = (a - b) ^ 2


instance Buildable StatValue where                                    -- we use instance to define the use of StatValue in statInfo
  build sv = fixedF (decimalPlaces sv) (value sv)                     -- format doubles - 'fixedF' of from fmt package

instance Buildable StatEntry where                                    -- we use instance to define how StatEntry will look. This structure will be used for text and html..   
  build StatEntry {..} =
           ""+||qfield||+": "                                         -- this code requires RecordWildCards and OverloadedStrings
             +|meanVal|+" (mean), "
             +|minVal|+" (min), "
             +|maxVal|+" (max), "
             +|daysBetweenMinMax|+" (days)"

textReport :: [StatEntry] -> String                                    -- we get a built StatEntry and format it into a String for text purposes
textReport = ascii colStats                                            -- ascii is from Colonnade 
  where
    colStats = mconcat
      [ headed "Quote Field" (show . qfield)                           -- headed is from Colonnade
      , headed "Mean" (pretty . meanVal)                               -- pretty is for formatting
      , headed "Min" (pretty . minVal)
      , headed "Max" (pretty . maxVal)
      , headed "Days between Min/Max" (pretty . daysBetweenMinMax)
      ]

showValue :: DefaultToZero -> Builder                                            -- we will use this for html formatting (auxiliary function)
showValue d = fixedF decimalPlacesFloating (toDouble d)