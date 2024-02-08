{-# LANGUAGE NamedFieldPuns #-}
{-# LANGUAGE RecordWildCards #-}

module Main (main) where

import Brick
import Brick.BChan (newBChan, writeBChan)
import Brick.Widgets.Border (borderWithLabel)
import Brick.Widgets.Center (center)
import Control.Concurrent (forkIO, threadDelay)
import Control.Monad
import qualified Graphics.Assets as Assets
import Graphics.RenderGrid
import Graphics.Vty
import qualified Logic.Constants as Constants
import Logic.DataTypes
import Logic.SnakeLogic
import System.Random

data Tick = Tick

app :: App AppState Tick ()
app =
  App
    ((: []) . center . borderWithLabel (str "Snake") . grid Constants.width Constants.height)
    (\_ _ -> Nothing)
    handleEvent
    (return ())
    ( const . attrMap defAttr $
        [ (Assets.headAttr, fg brightGreen),
          (Assets.bodyAttr, fg green),
          (Assets.appleAttr, fg red),
          (Assets.groundAttr, fg white)
        ]
    )

handleEvent :: BrickEvent n Tick -> EventM n AppState ()
handleEvent e = do
  (AppState {snake, ..}) <- get
  let newSnake = case e of
        AppEvent Tick ->
          if (head . coords . growSnake $ snake) == appleCoord
            then growSnake snake
            else moveSnake snake
        VtyEvent (EvKey KUp _) -> turnHead North snake
        VtyEvent (EvKey KDown _) -> turnHead South snake
        VtyEvent (EvKey KRight _) -> turnHead East snake
        VtyEvent (EvKey KLeft _) -> turnHead West snake
        _ -> snake
      (newGen, newAppleCoord) =
        if (head . coords $ newSnake) == appleCoord
          then
            let (newAppleX, newGen) = uniformR (0, Constants.width - 1) randGen
                (newAppleY, newGen') = uniformR (0, Constants.height - 1) newGen
             in (newGen', (newAppleX, newAppleY))
          else (randGen, appleCoord)
      newAppState =
        AppState
          { randGen = newGen,
            appleCoord = newAppleCoord,
            snake = newSnake
          }

  case e of
    VtyEvent (EvKey KEsc _) -> halt
    _ ->
      if snakeIsLegal newSnake
        then put newAppState
        else halt

main :: IO ()
main = do
  eventChan <- newBChan 10
  let buildVty = mkVty defaultConfig
  initialVty <- buildVty
  _ <- forkIO . forever $ do
    writeBChan eventChan Tick
    threadDelay 100000
  initGen <- initStdGen
  _ <- customMain initialVty buildVty (Just eventChan) app (AppState {randGen = initGen, appleCoord = (1, 1), snake = Snake East [(0, 0)]})
  return ()
