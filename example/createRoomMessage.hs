{-# LANGUAGE OverloadedStrings #-}

import Web.ChatWork
import Control.Monad.Trans.Maybe
import Control.Monad.IO.Class

main = runMaybeT $ do
  token <- MaybeT getChatWorkTokenFromEnv
  res <- liftIO . me $ token
  let room_id' = room_id $ snd res
  liftIO $ createRoomMessage token room_id' $ CreateMessage { body = "hello" }
