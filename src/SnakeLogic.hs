module SnakeLogic () where

import qualified Constants
import Data.List (nub)
import DataTypes

inBounds :: Int -> Int -> Snake -> Bool
inBounds width height (Snake _ coords) = xInBounds && yInBounds
  where
    (x, y) = head coords
    xInBounds = x >= 0 && x < width
    yInBounds = y >= 0 && y < height

noCollisions :: Snake -> Bool
noCollisions (Snake _ coords) = nub coords == coords

snakeIsLegal = (&&) <$> inBounds Constants.width Constants.height <*> noCollisions