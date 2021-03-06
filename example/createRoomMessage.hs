{-# LANGUAGE OverloadedStrings #-}

import Web.ChatWork
import Web.ChatWork.Endpoints.Me
import Control.Monad.Trans.Maybe
import Control.Monad.IO.Class

main = runMaybeT $ do
  token <- MaybeT getChatWorkTokenFromEnv
  res <- liftIO . me $ token
  let room_id' = roomId $ snd res
  liftIO $ createRoomMessage token room_id' $ CreateMessage { body = "hello" }
