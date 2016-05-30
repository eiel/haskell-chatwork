{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveGeneric #-}

module Web.ChatWork.Endpoints.Room (
  createRoomMessage
  , CreateMessage(..)
  ) where

import Data.Aeson
import Data.ByteString
import Data.Text
import Data.Text.Encoding as E
import GHC.Generics

import Web.ChatWork.Endpoints.Base
import Web.ChatWork.Internal as I

data MessageId = MessageId {
    messageId :: Int
  } deriving (Show, Generic)

instance FromJSON MessageId where
  parseJSON = I.parseJSON


data CreateMessage = CreateMessage {
    body :: Text
  } deriving (Show, Generic)

createRoomMessage :: ByteString ->
                     Int ->
                     CreateMessage ->
                     IO (ChatWorkAPI MessageId)
createRoomMessage token roomId request =
  post token (createMessageEndpoint roomId) [("body", E.encodeUtf8 $ body request)]

createMessageEndpoint roomId =
  baseURL ++ "/rooms/" ++ show roomId ++ "/messages"
