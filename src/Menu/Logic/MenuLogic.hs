{-# LANGUAGE RecordWildCards #-}

module Menu.Logic.MenuLogic (handleMenuEvent) where

import Brick
import DataTypes
import Graphics.Vty
import Menu.Logic.DataTypes
import System.Random

handleMenuEvent :: StdGen -> MenuState -> BrickEvent n Tick -> EventM n AppMachine ()
handleMenuEvent randGen (MenuState {..}) e = do
  let newSelected = case e of
        VtyEvent (EvKey KUp _) -> wrapPred selected
        VtyEvent (EvKey KDown _) -> wrapSucc selected
        _ -> selected
      newMenuState = Menu randGen (MenuState {selected = newSelected})

  case e of
    VtyEvent (EvKey KEnter _) -> case newSelected of
      Play -> put . newGame $ newMenuState
      Options -> put newMenuState
      Leaderboard -> put newMenuState
      Quit -> halt
    _ -> put newMenuState