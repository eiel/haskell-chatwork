{-# LANGUAGE DeriveGeneric #-}

module Web.ChatWork.Endpoints.Me (
    endpoint
    , Me(..)
  ) where

import Data.Aeson
import GHC.Generics

import Web.ChatWork.Endpoints.Base

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

endpoint = baseURL ++ "/me"
