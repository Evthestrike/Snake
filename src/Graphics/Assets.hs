{-# LANGUAGE OverloadedStrings #-}

module Graphics.Assets where

import Brick

headStr, bodyStr, groundStr, appleStr :: String
headStr = "0"
bodyStr = "o"
groundStr = "."
appleStr = "@"

headAttr, bodyAttr, groundAttr, appleAttr :: AttrName
headAttr = attrName "head"
bodyAttr = attrName "body"
groundAttr = attrName "ground"
appleAttr = attrName "apple"
