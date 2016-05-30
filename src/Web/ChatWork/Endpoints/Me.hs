{-# LANGUAGE DeriveGeneric #-}

module Web.ChatWork.Endpoints.Me (
    endpoint
    , Me(..)
  ) where

import Data.Aeson
import GHC.Generics

import Web.ChatWork.Endpoints.Base
import Web.ChatWork.Internal as I

data Me = Me {
      accountId :: Int
    , roomId :: Int
    , name :: String
    , chatworkId :: String
    , organizationId :: Int
    , organizationName :: String
    , department :: String
    , title :: String
    , url :: String
    , introduction :: String
    , mail :: String
    , telOrganization :: String
    , telExtension :: String
    , telMobile :: String
    , skype :: String
    , facebook :: String
    , twitter :: String
    , avatarImageUrl :: String
    } deriving (Generic, Show)

instance FromJSON Me where
  parseJSON = I.parseJSON

endpoint = baseURL ++ "/me"
