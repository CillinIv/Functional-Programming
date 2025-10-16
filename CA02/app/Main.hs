module Main where

import Lib
import qualified Data.ByteString.Lazy as BL
import qualified Data.ByteString as B
import qualified Data.Vector as V
import Data.Foldable (toList)
import Data.Text (unpack)
import Data.Time (Day)
import CovidData
import HTMLReport
import StatReport
import Data.Csv

extractTarget :: V.Vector CovidData -> [Double]
extractTarget x = V.toList (V.map getDouble x) where 
  getDouble = \x -> toDouble (new_cases x)

extractComparison :: V.Vector CovidData -> [Double]
extractComparison x = V.toList (V.map getDouble x) where 
  getDouble = \x -> toDouble (total_vaccinations x)


generateReports :: (Functor t, Foldable t) =>
                 String ->  t CovidData -> Double -> Double -> Double -> Double -> Double -> IO ()
generateReports htmlFl covidData percentile20 percentile60 percentile80 standardDev skew = do
  putStr textRpt
  BL.writeFile htmlFl htmlRpt
 where
   statInfo' = statInfo covidData
   textRpt = textReport statInfo'
   htmlRpt = htmlReport  covidData statInfo' percentile20 percentile60 percentile80 standardDev skew


main ::  IO ()
main  = do
  putStrLn "Please enter the filepath/name of the csv file:"
  fname <- getLine 
  putStrLn "Please enter the name of the html target file"
  htmlFile <- getLine

  csvData <- BL.readFile fname
  case decodeByName csvData of
    Left err -> putStrLn err
    Right (_, covidData) -> do
      let target = extractTarget covidData
      let percentile20 = percentile target 20
      let percentile60 = percentile target 60
      let percentile80 = percentile target 80
      let standardDev = standardDeviation target
      let skew = skewness target standardDev
      generateReports htmlFile covidData percentile20 percentile60 percentile80 standardDev skew



