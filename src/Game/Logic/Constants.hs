module Game.Logic.Constants
  ( width,
    height,
    defaultGameState,
  )
where

import Game.Logic.DataTypes

width :: Int
width = 12

height :: Int
height = 12

defaultGameState :: GameState
defaultGameState = GameState {appleCoord = (1, 1), snake = Snake East [(0, 0)]}