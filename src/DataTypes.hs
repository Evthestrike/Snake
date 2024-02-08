module DataTypes
  ( Coord,
    Direction (North, South, East, West),
    Snake (Snake),
    moveCoords,
  )
where

import Data.Bifunctor

type Coord = (Int, Int)

data Direction = North | South | East | West deriving (Show, Read)

data Snake = Snake Direction [Coord] deriving (Show, Read)

moveCoords :: Direction -> Coord -> Coord
moveCoords North = second (+ (-1))
moveCoords South = second (+ 1)
moveCoords East = first (+ 1)
moveCoords West = first (+ (-1))