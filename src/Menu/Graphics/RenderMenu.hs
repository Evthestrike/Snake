{-# LANGUAGE NamedFieldPuns #-}

module Menu.Graphics.RenderMenu (renderMenu) where

import Brick
import Brick.Widgets.Border
import Brick.Widgets.Center
import qualified Menu.Graphics.Assets as Assets
import Menu.Logic.DataTypes

renderMenu :: MenuState -> Widget n
renderMenu (MenuState {selected}) =
  center
    . vBox
    . map
      ( \x ->
          ( if x == selected
              then withAttr Assets.selectedAttr
              else id
          )
            . border
            . str
            . optionToString
            $ x
      )
    $ [minBound .. maxBound]

optionToString :: MenuOption -> String
optionToString Play = Assets.playStr
optionToString Options = Assets.optionsStr
optionToString Leaderboard = Assets.leaderboardStr
optionToString Quit = Assets.quitStr