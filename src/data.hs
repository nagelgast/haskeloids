module Data where

import Graphics.Gloss

type DeltaTime = Float
type Ship = Transform

data Size = Small | Medium | Large

data Transform = T {
    pos::Point,
    rot::Float,
    mom::Vector}

data Bullet = B Transform Float

data Asteroid = A Transform Size

data World = World Ship [Bullet] [Asteroid]
