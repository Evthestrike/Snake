{-# LANGUAGE RecordWildCards #-}

module Game.Logic.GameLogic (handleGameEvent) where

import Brick
import DataTypes
import qualified Game.Logic.Constants as Constants
import Game.Logic.DataTypes
import Game.Logic.SnakeLogic
import Graphics.Vty
import System.Random

handleGameEvent :: StdGen -> GameState -> BrickEvent n Tick -> EventM n AppMachine ()
handleGameEvent randGen (GameState {..}) e = do
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
            let (newAppleX, randGen') = uniformR (0, Constants.width - 1) randGen
                (newAppleY, randGen'') = uniformR (0, Constants.height - 1) randGen'
             in (randGen'', (newAppleX, newAppleY))
          else (randGen, appleCoord)
      newAppState =
        Game newGen $
          GameState
            { appleCoord = newAppleCoord,
              snake = newSnake
            }

  case e of
    VtyEvent (EvKey KEsc _) -> halt
    _ ->
      if snakeIsLegal newSnake
        then put newAppState
        else put . quitGame $ newAppState
