{-# LANGUAGE OverloadedStrings          #-}

module Web.ChatWork ( baseURL ) where

baseURL :: String
baseURL = "https://api.chatwork.com/v1"

meURL :: String
meURL = baseURL ++ "/me"
