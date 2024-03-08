{-# LANGUAGE NamedFieldPuns #-}

module Menu.Graphics.RenderMenu (renderMenu) where

import Brick
import Data.List (unfoldr)
import qualified Menu.Graphics.Assets
import Menu.Logic.DataTypes

renderMenu :: MenuState -> Widget n
renderMenu (MenuState {selected}) =
  vBox
    . map
      ( \x ->
          ( if x == selected
              then withAttr Menu.Graphics.Assets.selectedAttr
              else id
          )
            . str
            . optionToString
            $ x
      )
    $ [minBound .. maxBound]

optionToString :: MenuOption -> String
optionToString Play = Menu.Graphics.Assets.playStr
optionToString Quit = Menu.Graphics.Assets.quitStr