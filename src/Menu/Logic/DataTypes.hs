module Menu.Logic.DataTypes
  ( MenuOptions (Play, Quit),
    MenuState (MenuState, menuOptions, selected),
  )
where

data MenuOptions = Play | Quit

data MenuState = MenuState {menuOptions :: [MenuOptions], selected :: Int}