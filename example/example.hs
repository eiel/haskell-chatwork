{-# LANGUAGE OverloadedStrings #-}
import qualified Web.ChatWork as API
import           Data.Maybe
import           Data.UnixTime
import           Control.Monad.Trans.Maybe
import           Data.ByteString as BS
import           Control.Monad.IO.Class

me = runMaybeT $ do
  res@(limit, me) <- call API.me
  liftIO . print $ me
  resetStr <- liftIO $ case limit of
    Just n -> formatUnixTime webDateFormat . API.reset $ n
    _ -> return ""
  liftIO . BS.putStrLn $ resetStr
  return res

myStatus = runMaybeT $ do
  (_, status) <- call API.myStatus
  return status

call api = do
  token <- MaybeT API.getChatWorkTokenFromEnv
  liftIO . api $ token
