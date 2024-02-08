{-# LANGUAGE NamedFieldPuns #-}

module Graphics.RenderGrid (grid) where

import Brick
import Control.Lens
import Logic.DataTypes

grid :: Int -> Int -> AppState -> Widget ()
grid width height (AppState {snake, appleCoord = (appleX, appleY)}) = vBox . map (hBox . map str) . addApple . snakeToStringArray width height $ snake
  where
    addApple = ix appleY . ix appleX .~ "@"

snakeToStringArray :: Int -> Int -> Snake -> [[String]]
snakeToStringArray width height (Snake _ coords) = foldr (\x acc -> x acc) (blankArray & ix headY . ix headX .~ "0") setters
  where
    (headX, headY) = head coords
    blankArray = replicate height (replicate width ".")
    setters :: [[[String]] -> [[String]]]
    setters = map (\(x, y) xs -> xs & ix y . ix x .~ "o") . tail $ coords