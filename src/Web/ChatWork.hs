{-# LANGUAGE OverloadedStrings #-}

module Web.ChatWork (
  me,
  getChatWorkTokenFromEnv
  ) where

import Data.CaseInsensitive
import Data.ByteString.Char8 as BS
import Network.HTTP.Client
import Network.HTTP.Client.TLS
import Network.HTTP.Types.Status ( statusCode )
import Network.HTTP.Types.Header
import System.Environment ( lookupEnv )

me token = get token meURL

meURL = baseURL ++ "/me"

get token path = do
  manager <- newManager tlsManagerSettings

  initRequest <- parseUrl meURL
  let req = initRequest {
        requestHeaders = [header token]
      }
  httpLbs req manager

header token = ("X-ChatWorkToken", token)

baseURL = "https://api.chatwork.com/v1"

getChatWorkTokenFromEnv :: IO (Maybe ByteString)
getChatWorkTokenFromEnv = fmap (fmap BS.pack) $ lookupEnv "CHATWORK_TOKEN"
