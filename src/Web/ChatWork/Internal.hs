{-# OPTIONS -Wall #-}
{-# LANGUAGE OverloadedStrings #-}

module Web.ChatWork.Internal (
  get,
  post,
  RateLimit(..)
  ) where

import           Data.ByteString.Char8 as BS
import           Data.CaseInsensitive
import qualified Data.Map as Map
import           Data.UnixTime
import           Network.HTTP.Client
import           Network.HTTP.Types.Header
import           Network.HTTP.Types.Method
import           Network.HTTP.Simple

data RateLimit = RateLimit {
  limit :: Int,
  remaining :: Int,
  reset :: UnixTime
  } deriving (Show)

get token url = do
  initRequest <- parseUrl url
  let req = initRequest {
        method = methodGet,
        requestHeaders = [header token]
      }
  request req

post token url body = do
  initRequest <- parseUrl url
  let req = initRequest {
        method = methodPost,
        requestHeaders = [header token]
      }
  request $ urlEncodedBody body req

request req = do
  res <- httpJSON req
  let resHeaders = responseHeaders res
  let rateLimit = readRateLimit resHeaders
  return (rateLimit, getResponseBody res)

header token = ("X-ChatWorkToken", token)

readRateLimit :: RequestHeaders -> Maybe RateLimit
readRateLimit headers = do
  loo <- lookupInt' "X-RateLimit-Limit"
  remain <- lookupInt' "X-RateLimit-Remaining"
  res <- lookupInt' "X-RateLimit-Reset"
  return RateLimit {
    limit = loo,
    remaining = remain,
    reset = UnixTime (fromIntegral res) 0
  }
  where
    headerMap :: Map.Map (CI ByteString) ByteString
    headerMap = Map.fromList headers

    lookup' :: CI ByteString -> Maybe ByteString
    lookup' key = Map.lookup key headerMap

    lookupInt' :: CI ByteString -> Maybe Int
    lookupInt' = fmap (read . BS.unpack) . lookup'
