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
import Data.Maybe
import Data.Text
import Data.Text.Encoding as E
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

type ChatWorkAPI a = (Maybe RateLimit, a)

me :: ByteString -> IO (ChatWorkAPI Me)
me token = get token meURL

meURL = baseURL ++ "/me"

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

baseURL = "https://api.chatwork.com/v1"

getChatWorkTokenFromEnv :: IO (Maybe ByteString)
getChatWorkTokenFromEnv = fmap (fmap BS.pack) $ lookupEnv "CHATWORK_TOKEN"
