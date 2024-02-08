module Logic.DataTypes
  ( Coord,
    Direction (North, South, East, West),
    Snake (Snake, direction, coords),
    AppState (AppState, randGen, appleCoord, snake),
    moveCoord,
  )
where

import Data.Bifunctor (Bifunctor (first, second))
import System.Random

type Coord = (Int, Int)

data Direction = North | South | East | West deriving (Show, Read, Eq)

data Snake = Snake {direction :: Direction, coords :: [Coord]} deriving (Show, Read)

data AppState = AppState {randGen :: StdGen, appleCoord :: Coord, snake :: Snake}

moveCoord :: Direction -> Coord -> Coord
moveCoord North = second (+ (-1))
moveCoord South = second (+ 1)
moveCoord East = first (+ 1)
moveCoord West = first (+ (-1))