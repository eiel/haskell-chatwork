module Web.ChatWork.Endpoints.Base (
  baseURL,
  ChatWorkAPI
  ) where

import Web.ChatWork.Internal
type ChatWorkAPI a = (Maybe RateLimit, a)

baseURL :: String
baseURL = "https://api.chatwork.com/v1"
