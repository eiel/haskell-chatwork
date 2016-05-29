{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveGeneric #-}

module Web.ChatWork.Endpoints.My (
    statusEndpoint
  , MyStatus(..)
 ) where

import Data.Aeson
import Data.Aeson.Types
import GHC.Generics

import Web.ChatWork.Endpoints.Base
import Web.ChatWork.Internal

data MyStatus = MyStatus {
    unreadRoomNum :: Int
  , mentionRoomNum :: Int
  , mytaskRoomNum :: Int
  , unreadNum :: Int
  , mytaskNum :: Int
  } deriving (Show, Generic)

instance FromJSON MyStatus where
  parseJSON = genericParseJSON $ defaultOptions {
    fieldLabelModifier = fromField
    }

statusEndpoint :: String
statusEndpoint = baseURL ++ "/my/status"
