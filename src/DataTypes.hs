{-# LANGUAGE NamedFieldPuns #-}

module DataTypes
  ( Tick (Tick),
    AppMachine (Game, Menu),
  )
where

import qualified Game.Logic.Constants
import Game.Logic.DataTypes
import Menu.Logic.DataTypes

data Tick = Tick

data AppMachine = Game GameState | Menu MenuState

newGame :: AppMachine -> AppMachine
newGame (Game (GameState {randGen})) = Game . Game.Logic.Constants.defaultGameState $ randGen
newGame (Menu (MenuState {randGen})) = Game . Game.Logic.Constants.defaultGameState $ randGen