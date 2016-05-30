{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveGeneric #-}

module Web.ChatWork.Endpoints.My (
    statusEndpoint
  , MyStatus(..)
 ) where

import Data.Aeson
import GHC.Generics

import Web.ChatWork.Endpoints.Base
import Web.ChatWork.Internal as I

data MyStatus = MyStatus {
    unreadRoomNum :: Int
  , mentionRoomNum :: Int
  , mytaskRoomNum :: Int
  , unreadNum :: Int
  , mytaskNum :: Int
  } deriving (Show, Generic)

instance FromJSON MyStatus where
  parseJSON = I.parseJSON

statusEndpoint :: String
statusEndpoint = baseURL ++ "/my/status"
