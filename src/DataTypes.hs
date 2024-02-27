module DataTypes
  ( Tick (Tick),
    AppMachine (Game, Menu),
  )
where

import Game.Logic.DataTypes
import Menu.Logic.DataTypes

data Tick = Tick

data AppMachine = Game GameState | Menu MenuState