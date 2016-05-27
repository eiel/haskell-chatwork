{-# LANGUAGE OverloadedStrings #-}

module Web.ChatWork.Endpoints.My (
    statusEndpoint
  , MyStatus(..)
 ) where

import Data.Aeson

import Web.ChatWork.Endpoints.Base

data MyStatus = MyStatus {
    unreadRoomNum :: Int
  , mentionRoomNum :: Int
  , mytaskRoomNum :: Int
  , unreadNum :: Int
  , mytaskNum :: Int
  } deriving (Show)

instance FromJSON MyStatus where
  parseJSON (Object o) = MyStatus <$>
    o .: "unread_room_num" <*>
    o .: "mention_room_num" <*>
    o .: "mytask_room_num" <*>
    o .: "unread_num" <*>
    o .: "mytask_num"

statusEndpoint :: String
statusEndpoint = baseURL ++ "/my/status"
