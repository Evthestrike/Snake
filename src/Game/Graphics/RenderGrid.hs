{-# LANGUAGE NamedFieldPuns #-}

module Game.Graphics.RenderGrid (grid) where

import Brick
import Brick.Widgets.Border
import Brick.Widgets.Center
import Control.Lens
import qualified Game.Graphics.Assets as Assets
import Game.Logic.DataTypes

grid :: Int -> Int -> GameState -> Widget ()
grid width height (GameState {snake, appleCoord = (appleX, appleY)}) =
  center
    . borderWithLabel (str "Snake")
    . vBox
    . map (hBox . map colorStr)
    . addApple
    . snakeToStringArray width height
    $ snake
  where
    addApple = ix appleY . ix appleX .~ Assets.appleStr

colorStr :: String -> Widget n
colorStr s
  | s == Assets.headStr = withAttr Assets.headAttr . str $ s
  | s == Assets.bodyStr = withAttr Assets.bodyAttr . str $ s
  | s == Assets.appleStr = withAttr Assets.appleAttr . str $ s
  | s == Assets.groundStr = withAttr Assets.groundAttr . str $ s
  | otherwise = str s

snakeToStringArray :: Int -> Int -> Snake -> [[String]]
snakeToStringArray width height (Snake _ coords) = foldr (\x acc -> x acc) (blankArray & ix headY . ix headX .~ Assets.headStr) setters
  where
    (headX, headY) = head coords
    blankArray = replicate height (replicate width Assets.groundStr)
    setters :: [[[String]] -> [[String]]]
    setters = map (\(x, y) xs -> xs & ix y . ix x .~ Assets.bodyStr) . tail $ coords