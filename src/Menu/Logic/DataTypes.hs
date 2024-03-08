module Menu.Logic.DataTypes
  ( MenuOption (Play, Quit),
    MenuState (MenuState, selected),
    wrapSucc,
    wrapPred,
  )
where

data MenuOption = Play | Quit deriving (Show, Read, Eq, Ord, Enum, Bounded)

wrapSucc :: (Eq a, Bounded a, Enum a) => a -> a
wrapSucc o =
  if o == maxBound
    then minBound
    else succ o

wrapPred :: (Eq a, Bounded a, Enum a) => a -> a
wrapPred o =
  if o == minBound
    then maxBound
    else pred o

data MenuState = MenuState {selected :: MenuOption}