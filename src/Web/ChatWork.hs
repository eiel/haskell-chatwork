{-# LANGUAGE OverloadedStrings          #-}

module Web.ChatWork ( baseURL ) where

import System.Environment ( lookupEnv )

baseURL :: String
baseURL = "https://api.chatwork.com/v1"

meURL :: String
meURL = baseURL ++ "/me"

getChatWorkTokenFromEnv :: IO Maybe String
getChatWorkTokenFromEnv = lookupEnv "CHATWORK_TOKEN"
