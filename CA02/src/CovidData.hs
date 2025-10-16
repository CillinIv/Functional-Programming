{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DeriveAnyClass #-}
{-#LANGUAGE OverloadedStrings #-}

module CovidData where

import Data.Time (Day, parseTimeM, defaultTimeLocale)
import Data.ByteString.Char8 (unpack)
import GHC.Generics (Generic)
import Data.Csv (FromNamedRecord, FromField (..), parseNamedRecord, runParser, (.:))

newtype DefaultToZero = DTZ Double
  deriving (Show,Eq,Ord)

instance FromField DefaultToZero where
  parseField s = case runParser(parseField s) of
    Left err -> pure $ DTZ 0
    Right n -> pure $ DTZ n

toDouble :: DefaultToZero -> Double
toDouble (DTZ d) = d

instance FromField Day where
  parseField = parseTimeM True defaultTimeLocale "%Y-%m-%d" . Data.ByteString.Char8.unpack

data CovidData = CovidData {
        iso_code :: String,
        continent :: String,
        location :: String,
        date :: Day,
        total_cases :: DefaultToZero,
        new_cases :: DefaultToZero,
        total_deaths :: DefaultToZero,
        new_deaths :: DefaultToZero,
        reproduction_rate :: DefaultToZero,
        icu_patients :: DefaultToZero,
        total_vaccinations :: DefaultToZero,
        people_vaccinated :: DefaultToZero,
        people_fully_vaccinated :: DefaultToZero,
        new_vaccinations :: DefaultToZero
    }
  deriving (Ord, Eq, Show, Generic)

instance FromNamedRecord CovidData where
  parseNamedRecord r =
    CovidData
    <$> r .: "iso_code"
    <*> r .: "continent"
    <*> r .: "location"
    <*> r .: "date"
    <*> r .: "total_cases"
    <*> r .: "new_cases"
    <*> r .: "total_deaths"
    <*> r .: "new_deaths"
    <*> r .: "reproduction_rate"
    <*> r .: "icu_patients"
    <*> r .: "total_vaccinations"
    <*> r .: "people_vaccinated"
    <*> r .: "people_fully_vaccinated"
    <*> r .: "new_vaccinations"


data QField = Total_cases | New_cases | Total_deaths | New_deaths | Reproduction_rate | Icu_patients | Total_vaccinations | People_vaccinated | People_fully_vaccinated | New_vaccinations
  deriving (Eq, Ord, Show, Enum, Bounded)


field2fun :: QField -> CovidData -> Double
field2fun Total_cases = toDouble . total_cases
field2fun New_cases = toDouble . new_cases
field2fun Total_deaths = toDouble . total_deaths
field2fun New_deaths = toDouble . new_deaths
field2fun Reproduction_rate = toDouble . reproduction_rate
field2fun Icu_patients = toDouble . icu_patients
field2fun Total_vaccinations = toDouble . total_vaccinations
field2fun People_vaccinated = toDouble . people_vaccinated
field2fun People_fully_vaccinated = toDouble . people_fully_vaccinated
field2fun New_vaccinations = toDouble . new_vaccinations





