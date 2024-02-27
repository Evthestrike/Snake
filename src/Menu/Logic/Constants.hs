module Menu.Logic.Constants
  ( defaultMenu,
  )
where

import Menu.Logic.DataTypes

defaultMenu :: MenuState
defaultMenu = MenuState {selected = Play}