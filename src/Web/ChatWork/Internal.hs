{-# OPTIONS -Wall #-}
{-# LANGUAGE OverloadedStrings #-}

module Web.ChatWork.Internal (
  get
  ) where

import Data.ByteString.Char8 as BS
import Data.CaseInsensitive
import qualified Data.Map as Map
import Data.Maybe
import Network.HTTP.Client
import Network.HTTP.Client.TLS
import Network.HTTP.Types.Status ( statusCode )
import Network.HTTP.Types.Header

data RateLimit = RateLimit {
  limit :: Int,
  remaining :: Int,
  reset :: Int -- TODO unix time
  } deriving (Show)

get token url = do
  manager <- newManager tlsManagerSettings

  initRequest <- parseUrl url
  let req = initRequest {
        requestHeaders = [header token]
      }
  res <- httpLbs req manager
  let resHeaders = responseHeaders res
  let rateLimit = readRateLimit resHeaders
  return (rateLimit, responseBody res)

header token = ("X-ChatWorkToken", token)

readRateLimit :: RequestHeaders -> Maybe RateLimit
readRateLimit headers = do
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
