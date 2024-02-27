{-# LANGUAGE NamedFieldPuns #-}

module Game.Graphics.RenderGrid (grid) where

import Brick
import Brick.Widgets.Border
import Brick.Widgets.Center
import Control.Lens
import qualified Game.Graphics.Assets
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
    addApple = ix appleY . ix appleX .~ Game.Graphics.Assets.appleStr

colorStr :: String -> Widget n
colorStr s
  | s == Game.Graphics.Assets.headStr = withAttr Game.Graphics.Assets.headAttr . str $ s
  | s == Game.Graphics.Assets.bodyStr = withAttr Game.Graphics.Assets.bodyAttr . str $ s
  | s == Game.Graphics.Assets.appleStr = withAttr Game.Graphics.Assets.appleAttr . str $ s
  | s == Game.Graphics.Assets.groundStr = withAttr Game.Graphics.Assets.groundAttr . str $ s
  | otherwise = str s

snakeToStringArray :: Int -> Int -> Snake -> [[String]]
snakeToStringArray width height (Snake _ coords) = foldr (\x acc -> x acc) (blankArray & ix headY . ix headX .~ Game.Graphics.Assets.headStr) setters
  where
    (headX, headY) = head coords
    blankArray = replicate height (replicate width Game.Graphics.Assets.groundStr)
    setters :: [[[String]] -> [[String]]]
    setters = map (\(x, y) xs -> xs & ix y . ix x .~ Game.Graphics.Assets.bodyStr) . tail $ coords