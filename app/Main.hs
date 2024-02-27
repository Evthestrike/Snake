module Main (main) where

import App
import Brick
import Brick.BChan (newBChan, writeBChan)
import Control.Concurrent (forkIO, threadDelay)
import Control.Monad
import DataTypes
import System.Random

main :: IO ()
main = do
  eventChan <- newBChan 10
  _ <- forkIO . forever $ do
    writeBChan eventChan Tick
    threadDelay 100000
  initGen <- initStdGen
  _ <- customMainWithDefaultVty (Just eventChan) app . initialState $ initGen
  return ()
