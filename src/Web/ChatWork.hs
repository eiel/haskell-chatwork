{-# OPTIONS -Wall #-}
{-# LANGUAGE OverloadedStrings #-}

module Web.ChatWork (
  me,
  getChatWorkTokenFromEnv
  ) where

import Data.ByteString.Char8 as BS
import Data.Maybe
import System.Environment ( lookupEnv )

import Web.ChatWork.Internal

meURL = baseURL ++ "/me"
me token = get token meURL

baseURL = "https://api.chatwork.com/v1"

getChatWorkTokenFromEnv :: IO (Maybe ByteString)
getChatWorkTokenFromEnv = fmap (fmap BS.pack) $ lookupEnv "CHATWORK_TOKEN"
