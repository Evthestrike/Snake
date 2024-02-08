module DataTypes
  ( Coords,
    Direction (North, South, East, West),
    Snake (Snake),
    moveCoords,
  )
where

import Data.Bifunctor

type Coords = (Int, Int)

data Direction = North | South | East | West deriving (Show, Read)

data Snake = Snake Direction [Coords] deriving (Show, Read)

moveCoords :: Direction -> Coords -> Coords
moveCoords North = second (+ (-1))
moveCoords South = second (+ 1)
moveCoords East = first (+ 1)
moveCoords West = first (+ (-1))