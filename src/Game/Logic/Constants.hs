module Game.Logic.Constants
  ( width,
    height,
    defaultGameState,
  )
where

import Game.Logic.DataTypes

width :: Int
width = 16

height :: Int
height = 17

defaultGameState :: GameState
defaultGameState = GameState {appleCoord = (1, 1), snake = Snake East [(0, 0)]}