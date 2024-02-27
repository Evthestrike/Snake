module Menu.Graphics.Assets
  ( playStr,
    quitStr,
    selectedAttr,
  )
where

import Brick

playStr, quitStr :: String
playStr = "Play"
quitStr = "Quit"

selectedAttr :: AttrName
selectedAttr = attrName "selected"
