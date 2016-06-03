{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveGeneric #-}

module Web.ChatWork.Endpoints.My (
    statusEndpoint
  , MyStatus(..)
  , Task(..)
  , tasksEndpoint
 ) where

import Data.Aeson
import Data.ByteString.Char8
import GHC.Generics

import Web.ChatWork.Endpoints.Base
import Web.ChatWork.Internal as I
import Web.ChatWork.Endpoints.TaskAccount

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

data Status = Open | Done
  deriving (Show, Generic)
instance FromJSON Status where
  parseJSON value = case value of
    String "open" -> return Open
    String "done" -> return Done

instance ToJSON Status where
  toJSON n = case n of
    Open -> String "open"
    Done -> String "done"

data Task = Task {
    taskId :: Int
  , room :: TaskRoom
  , assignedByAccount :: TaskAccount
  , messageId :: Int
  , body :: String
  , limitTime :: Int
  , status :: Status
  } deriving (Show, Generic)
instance FromJSON Task where
  parseJSON = I.parseJSON

data TaskRoom = TaskRoom {
    roomId :: Int
  , name :: String
  , iconPath :: String
  } deriving (Show, Generic)
instance FromJSON TaskRoom where
  parseJSON = I.parseJSON

tasksEndpoint :: String
tasksEndpoint = baseURL ++ "/my/tasks"
