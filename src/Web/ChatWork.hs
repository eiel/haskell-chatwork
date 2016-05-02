{-# OPTIONS -Wall #-}
{-# LANGUAGE OverloadedStrings #-}

module Web.ChatWork (
  me,
  getChatWorkTokenFromEnv
  ) where

import Data.ByteString.Char8 as BS
import Data.CaseInsensitive
import qualified Data.Map as Map
import Data.Maybe
import Network.HTTP.Client
import Network.HTTP.Client.TLS
import Network.HTTP.Types.Status ( statusCode )
import Network.HTTP.Types.Header
import System.Environment ( lookupEnv )

data RateLimit = RateLimit {
  limit :: Int,
  remaining :: Int,
  reset :: Int
  } deriving (Show)

me token = get token meURL

meURL = baseURL ++ "/me"

get token path = do
  manager <- newManager tlsManagerSettings

  initRequest <- parseUrl meURL
  let req = initRequest {
        requestHeaders = [header token]
      }
  res <- httpLbs req manager
  let resHeaders = responseHeaders res
  return (RateLimit { limit = 1, remaining = 1, reset = 1 }, responseBody res)

headerToRateLimit :: RequestHeaders -> Maybe RateLimit
headerToRateLimit headers = do
  loo <- lookupInt' "X-RateLimit-Limit"
  rem <- lookupInt' "X-RateLimit-Remaining"
  res <- lookupInt' "X-RateLimit-Reset"
  return $ RateLimit {
    limit = loo,
    remaining = rem,
    reset = res
  }
  where
    headerMap :: Map.Map (CI ByteString) ByteString
    headerMap = Map.fromList headers

    lookup' :: CI ByteString -> Maybe ByteString
    lookup' key = Map.lookup key headerMap

    lookupInt' :: CI ByteString -> Maybe Int
    lookupInt' = fmap (read . BS.unpack) . lookup'

header token = ("X-ChatWorkToken", token)

baseURL = "https://api.chatwork.com/v1"

getChatWorkTokenFromEnv :: IO (Maybe ByteString)
getChatWorkTokenFromEnv = fmap (fmap BS.pack) $ lookupEnv "CHATWORK_TOKEN"
