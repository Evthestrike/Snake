module DataTypes
  ( Coord,
    Direction (North, South, East, West),
    Snake (Snake),
    moveCoord,
  )
where

import Data.Bifunctor (Bifunctor (first, second))

type Coord = (Int, Int)

data Direction = North | South | East | West deriving (Show, Read)

data Snake = Snake Direction [Coord] deriving (Show, Read)

moveCoord :: Direction -> Coord -> Coord
moveCoord North = second (+ (-1))
moveCoord South = second (+ 1)
moveCoord East = first (+ 1)
moveCoord West = first (+ (-1))