{-# OPTIONS -Wall #-}
{-# LANGUAGE OverloadedStrings #-}


module Web.ChatWork (
  me,
  Me(..),
  createRoomMessage,
  CreateMessage(..),
  RateLimit(..),
  getChatWorkTokenFromEnv
  ) where

import Data.ByteString.Char8 as BS
import System.Environment ( lookupEnv )

import Web.ChatWork.Internal
import Web.ChatWork.Endpoints.Base
import Web.ChatWork.Endpoints.Me as Me
import Web.ChatWork.Endpoints.Room

me :: ByteString -> IO (ChatWorkAPI Me)
me token = get token Me.endpoint

getChatWorkTokenFromEnv :: IO (Maybe ByteString)
getChatWorkTokenFromEnv = fmap (fmap BS.pack) $ lookupEnv "CHATWORK_TOKEN"
