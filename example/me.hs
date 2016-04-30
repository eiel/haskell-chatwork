import Web.ChatWork
import Control.Monad.Trans.Maybe
import Control.Monad.IO.Class

main = runMaybeT $ do
  token <- MaybeT getChatWorkTokenFromEnv
  res <- liftIO . me $ token
  liftIO . print $ res
