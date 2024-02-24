{-# LANGUAGE NamedFieldPuns #-}

module Logic.SnakeLogic
  ( growSnake,
    moveSnake,
    snakeIsLegal,
    turnHead,
  )
where

import Data.List (nub)
import qualified Logic.Constants as Constants
import Logic.DataTypes

inBounds :: Int -> Int -> Snake -> Bool
inBounds width height (Snake _ coords) = xInBounds && yInBounds
  where
    (x, y) = head coords
    xInBounds = x >= 0 && x < width
    yInBounds = y >= 0 && y < height

noCollisions :: Snake -> Bool
noCollisions (Snake _ coords) = nub coords == coords

snakeIsLegal :: Snake -> Bool
snakeIsLegal = (&&) <$> inBounds Constants.width Constants.height <*> noCollisions

growSnake :: Snake -> Snake
growSnake (Snake direction coords) = Snake direction newCoords
  where
    headCoord = head coords
    newCoords = moveCoord direction headCoord : coords

moveSnake :: Snake -> Snake
moveSnake snake = Snake direction (init coords)
  where
    (Snake direction coords) = growSnake snake

turnHead :: Direction -> Snake -> Snake
turnHead newDirection (Snake direction coords) = case newDirection of
  North ->
    if direction == South
      then Snake direction coords
      else Snake North coords
  South ->
    if direction == North
      then Snake direction coords
      else Snake South coords
  East ->
    if direction == West
      then Snake direction coords
      else Snake East coords
  West ->
    if direction == East
      then Snake direction coords
      else Snake West coords