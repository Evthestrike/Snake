{-# LANGUAGE NamedFieldPuns #-}

module Menu.Graphics.RenderMenu (renderMenu) where

import Brick
import Data.List.Index
import qualified Game.Graphics.Assets
import Game.Logic.DataTypes
import qualified Menu.Graphics.Assets

renderMenu :: MenuState -> Widget n
renderMenu (MenuState {menuOptions, selected}) =
  vBox
    . imap
      ( \i x ->
          ( if i == selected
              then withAttr Menu.Graphics.Assets.selectedAttr
              else id
          )
            . str
            . optionToString
            $ x
      )
    $ menuOptions

optionToString :: MenuOptions -> String
optionToString Play = Menu.Graphics.Assets.playStr
optionToString Quit = Menu.Graphics.Assets.quitStr