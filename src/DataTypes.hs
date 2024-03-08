module DataTypes
  ( Tick (Tick),
    AppMachine (Game, Menu),
    newGame,
    quitGame,
  )
where

import qualified Game.Logic.Constants
import Game.Logic.DataTypes
import qualified Menu.Logic.Constants
import Menu.Logic.DataTypes
import System.Random

data Tick = Tick

data AppMachine = Game StdGen GameState | Menu StdGen MenuState

newGame :: AppMachine -> AppMachine
newGame (Game randGen _) = Game randGen Game.Logic.Constants.defaultGameState
newGame (Menu randGen _) = Game randGen Game.Logic.Constants.defaultGameState

quitGame :: AppMachine -> AppMachine
quitGame (Game randGen _) = Menu randGen Menu.Logic.Constants.defaultMenu
quitGame (Menu randGen _) = Menu randGen Menu.Logic.Constants.defaultMenu