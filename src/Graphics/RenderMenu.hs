{-# LANGUAGE NamedFieldPuns #-}

module Graphics.RenderMenu (renderMenu) where

import Brick
import Data.List.Index
import qualified Graphics.Assets as Assets
import Logic.DataTypes

renderMenu :: MenuState -> Widget n
renderMenu (MenuState {menuOptions, selected}) =
  vBox
    . imap
      ( \i x ->
          ( if i == selected
              then withAttr Assets.selectedAttr
              else id
          )
            . str
            . optionToString
            $ x
      )
    $ menuOptions

optionToString :: MenuOptions -> String
optionToString Play = Assets.playStr
optionToString Quit = Assets.quitStr