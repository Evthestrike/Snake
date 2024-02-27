module Menu.Logic.DataTypes
  ( MenuOption (Play, Quit),
    MenuState (MenuState, selected),
  )
where

data MenuOption = Play | Quit deriving (Eq, Ord, Enum, Bounded)

data MenuState = MenuState {selected :: MenuOption}