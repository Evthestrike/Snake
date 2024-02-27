{-# LANGUAGE NamedFieldPuns #-}

module DataTypes
  ( Tick (Tick),
    AppMachine (Game, Menu),
  )
where

import qualified Game.Logic.Constants
import Game.Logic.DataTypes
import Menu.Logic.DataTypes
import System.Random

data Tick = Tick

data AppMachine = Game StdGen GameState | Menu StdGen MenuState

newGame :: AppMachine -> AppMachine
newGame (Game randGen _) = Game randGen Game.Logic.Constants.defaultGameState
newGame (Menu randGen _) = Game randGen Game.Logic.Constants.defaultGameState