module Graphics.RenderGrid () where

import Brick
import Control.Lens
import Logic.DataTypes

grid :: Int -> Int -> Snake -> Widget ()
grid width height = vBox . map (hBox . map str) . snakeToStringArray width height

snakeToStringArray :: Int -> Int -> Snake -> [[String]]
snakeToStringArray width height (Snake _ coords) = foldr (\x acc -> x acc) (blankArray & ix headY . ix headX .~ "0") setters
  where
    (headX, headY) = head coords
    blankArray = replicate height (replicate width ".")
    setters :: [[[String]] -> [[String]]]
    setters = map (\(x, y) xs -> xs & ix y . ix x .~ "o") . tail $ coords