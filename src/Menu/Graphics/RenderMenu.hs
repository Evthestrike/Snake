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
    . hLimit ((+ 1) . length . head . lines $ Assets.titleStr)
    . vBox
    . ((hCenter . str $ Assets.titleStr) :)
    . map
      ( \x ->
          ( if x == Leaderboard || x == Options
              then withAttr Assets.disabledAttr
              else id
          )
            . ( if x == selected
                  then withAttr Assets.selectedAttr
                  else id
              )
            . border
            . hCenter
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