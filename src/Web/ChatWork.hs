{-# OPTIONS -Wall #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveGeneric #-}

module Web.ChatWork (
  me,
  Me,
  RateLimit,
  getChatWorkTokenFromEnv
  ) where

import Data.Aeson
import Data.ByteString.Char8 as BS
import Data.Maybe
import GHC.Generics
import System.Environment ( lookupEnv )

import Web.ChatWork.Internal

data Me = Me {
      account_id :: Int
    , room_id :: Int
    , name :: String
    , chatwork_id :: String
    , organization_id :: Int
    , organization_name :: String
    , department :: String
    , title :: String
    , url :: String
    , introduction :: String
    , mail :: String
    , tel_organization :: String
    , tel_extension :: String
    , tel_mobile :: String
    , skype :: String
    , facebook :: String
    , twitter :: String
    , avatar_image_url :: String
    } deriving (Generic, Show)

instance FromJSON Me

meURL = baseURL ++ "/me"

me token = get token meURL

baseURL = "https://api.chatwork.com/v1"

getChatWorkTokenFromEnv :: IO (Maybe ByteString)
getChatWorkTokenFromEnv = fmap (fmap BS.pack) $ lookupEnv "CHATWORK_TOKEN"
