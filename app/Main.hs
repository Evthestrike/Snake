module Main (main) where

import Brick
import Brick.BChan (newBChan, writeBChan)
import Control.Concurrent (forkIO, threadDelay)
import Control.Monad
import Graphics.RenderGrid
import Graphics.Vty
import qualified Logic.Constants as Constants
import Logic.DataTypes
import Logic.SnakeLogic

data AppState = AppState {snake :: Snake}

data Tick = Tick

app :: App Snake Tick ()
app = App ((: []) . grid Constants.width Constants.height) (\_ _ -> Nothing) handleEvent (return ()) (const . attrMap defAttr $ [])

handleEvent :: BrickEvent n Tick -> EventM n Snake ()
handleEvent e = do
  (Snake direction coords) <- get
  let newSnake = case e of
        AppEvent Tick -> moveSnake . Snake direction $ coords
        VtyEvent (EvKey KUp _) ->
          if direction == South
            then Snake direction coords
            else Snake North coords
        VtyEvent (EvKey KDown _) ->
          if direction == North
            then Snake direction coords
            else Snake South coords
        VtyEvent (EvKey KRight _) ->
          if direction == West
            then Snake direction coords
            else Snake East coords
        VtyEvent (EvKey KLeft _) ->
          if direction == East
            then Snake direction coords
            else Snake West coords
        _ -> Snake direction coords

  case e of
    VtyEvent (EvKey KEsc _) -> halt
    _ ->
      if snakeIsLegal newSnake
        then put newSnake
        else halt

main :: IO ()
main = do
  eventChan <- newBChan 10
  let buildVty = mkVty defaultConfig
  initialVty <- buildVty
  forkIO . forever $ do
    writeBChan eventChan Tick
    threadDelay 100000
  customMain initialVty buildVty (Just eventChan) app (Snake East $ [(0, 0)])
  return ()
