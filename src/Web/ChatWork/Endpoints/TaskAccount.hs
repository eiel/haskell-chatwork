{-# LANGUAGE DeriveGeneric #-}

module Web.ChatWork.Endpoints.TaskAccount
  (
    TaskAccount(..)
  ) where

import Data.Aeson
import GHC.Generics
import Web.ChatWork.Endpoints.Base
import Web.ChatWork.Internal as I

data TaskAccount = TaskAccount {
    accountId :: Int
  , name :: String
  , avatarImageUrl :: String
  } deriving (Show, Generic)
instance FromJSON TaskAccount where
  parseJSON = I.parseJSON
