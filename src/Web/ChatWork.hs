{-# OPTIONS -Wall #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveGeneric #-}

module Web.ChatWork (
  me,
  Me(..),
  createRoomMessage,
  CreateMessage(..),
  RateLimit,
  getChatWorkTokenFromEnv
  ) where

import Data.Aeson
import Data.ByteString.Char8 as BS
import GHC.Generics
import Data.Maybe
import Data.Text
import Data.Text.Encoding as E
import System.Environment ( lookupEnv )

import Web.ChatWork.Internal
import Web.ChatWork.Endpoints.Base
import Web.ChatWork.Endpoints.Me as Me

type ChatWorkAPI a = (Maybe RateLimit, a)

me :: ByteString -> IO (ChatWorkAPI Me)
me token = get token Me.endpoint

data MessageId = MessageId {
    message_id :: Int
  } deriving (Show, Generic)
instance FromJSON MessageId

data CreateMessage = CreateMessage {
    body :: Text
  } deriving (Show, Generic)

createRoomMessage :: ByteString -> Int -> CreateMessage -> IO (ChatWorkAPI MessageId)
createRoomMessage token roomId request = post token (createMessageURL roomId) [("body", E.encodeUtf8 $ body request)]

createMessageURL room_id = baseURL ++ "/rooms/" ++ show room_id ++ "/messages"

getChatWorkTokenFromEnv :: IO (Maybe ByteString)
getChatWorkTokenFromEnv = fmap (fmap BS.pack) $ lookupEnv "CHATWORK_TOKEN"
