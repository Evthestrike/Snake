module Menu.Graphics.Assets
  ( titleStr,
    playStr,
    optionsStr,
    leaderboardStr,
    quitStr,
    selectedAttr,
    disabledAttr,
  )
where

import Brick

titleStr :: String
titleStr = "                 _       \n                | |       \n ___ _ __   __ _| | _____ \n/ __| '_ \\ / _` | |/ / _ \\\n\\__ \\ | | | (_| |   <  __/\n|___/_| |_|\\__,_|_|\\_\\___|\n\n"

playStr, optionsStr, leaderboardStr, quitStr :: String
playStr = "Play"
optionsStr = "Options"
leaderboardStr = "Leaderboard"
quitStr = "Quit"

selectedAttr :: AttrName
selectedAttr = attrName "selected"

disabledAttr :: AttrName
disabledAttr = attrName "disabled"
