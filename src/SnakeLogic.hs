module SnakeLogic () where

import Data.List
import DataTypes

inBounds :: Int -> Int -> Snake -> Bool
inBounds width height (Snake _ ((x, y) : _)) = xInBounds && yInBounds
  where
    xInBounds = x >= 0 && x < width
    yInBounds = y >= 0 && y < height

noCollisions :: Snake -> Bool
noCollisions (Snake _ coords) = nub coords == coords