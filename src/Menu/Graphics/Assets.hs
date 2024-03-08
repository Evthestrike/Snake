module Menu.Graphics.Assets
  ( playStr,
    optionsStr,
    leaderboardStr,
    quitStr,
    selectedAttr,
  )
where

import Brick

playStr, optionsStr, leaderboardStr, quitStr :: String
playStr = "Play"
optionsStr = "Options"
leaderboardStr = "Leaderboard"
quitStr = "Quit"

selectedAttr :: AttrName
selectedAttr = attrName "selected"
