{-# LANGUAGE OverloadedStrings #-}

module HTMLReport where

import Text.Blaze.Html5 as H
import Text.Blaze.Html5.Attributes (src)
import Text.Blaze.Html.Renderer.Utf8 (renderHtml)
import CovidData
import StatReport
import Data.ByteString.Lazy (ByteString)
import Colonnade
import Text.Blaze.Colonnade
import Fmt (pretty, Buildable)
import Data.Foldable (traverse_)
import Control.Monad (unless)

viaFmt :: Buildable a => a -> Html
viaFmt = text . pretty

colStats :: Colonnade Headed StatEntry Html
colStats = mconcat
      [ headed "Quote Field" (i . string . show . qfield)
      , headed "Mean" (viaFmt . meanVal)
      , headed "Min" (viaFmt . minVal)
      , headed "Max" (viaFmt . maxVal)
      , headed "Days between Min/Max" (viaFmt . daysBetweenMinMax)
      ]

colData :: Colonnade Headed CovidData Html
colData = mconcat
      [ headed "date" (viaFmt . date)
      , headed "total_cases" (viaFmt . showValue . total_cases)
      , headed "new_cases" (viaFmt . showValue . new_cases)
      , headed "total_deaths" (viaFmt . showValue . total_deaths)
      , headed "new_deaths" (viaFmt . showValue . new_deaths)
      , headed "reproduction_rate" (viaFmt . showValue . reproduction_rate)
      , headed "icu_patients" (viaFmt . showValue . icu_patients)
      , headed "total_vaccinations" (viaFmt . showValue . total_vaccinations)
      , headed "people_vaccinated" (viaFmt . showValue . people_vaccinated)
      , headed "people_fully_vaccinated" (viaFmt . showValue . people_fully_vaccinated)
      , headed "new_vaccinations" (viaFmt . showValue . new_vaccinations)

      ]

htmlReport :: (Functor t, Foldable t) =>
             t CovidData -> [StatEntry] -> Double -> Double -> Double -> Double -> Double -> ByteString
htmlReport quotes statEntries percentile20 percentile60 percentile80 sd skew = renderHtml $ docTypeHtml $ do
     H.head $ do
       style tableStyle

     body $ do

       h1 "Statistics Report"
       encodeHtmlTable mempty colStats statEntries

       h1 "20% percentile"
       h2 $ viaFmt percentile20

       h1 "60% percentile"
       h2 $ viaFmt percentile60

       h1 "80% percentile"
       h2 $ viaFmt percentile80

       h1 "Standard Deviation"
       h2 $ viaFmt sd

       h1 "Skew"
       h2 $ viaFmt skew

       h1 "Covid Data"
       encodeHtmlTable mempty colData quotes
  where
    tableStyle = "table {border-collapse: collapse}" <>
            "td, th {border: 1px solid black; padding: 5px}"