module Game.Logic.Constants
  ( width,
    height,
    defaultGameState,
  )
where

import Game.Logic.DataTypes
import System.Random (StdGen)

width :: Int
width = 12

height :: Int
height = 12

defaultGameState :: StdGen -> GameState
defaultGameState initRandGen = GameState {randGen = initRandGen, appleCoord = (1, 1), snake = Snake East [(0, 0)]}