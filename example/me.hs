{-# LANGUAGE OverloadedStrings #-}
import Web.ChatWork
import Data.UnixTime
import Control.Monad.Trans.Maybe
import Data.ByteString as BS
import Control.Monad.IO.Class

main = runMaybeT $ do
  token <- MaybeT getChatWorkTokenFromEnv
  res@(limit, me) <- liftIO . me $ token
  liftIO . print $ me
  resetStr <- liftIO $ case limit of
    Just n -> formatUnixTime webDateFormat . reset $ n
    _ -> return ""
  liftIO . BS.putStrLn $ resetStr
  return res
