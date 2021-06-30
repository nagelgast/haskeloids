module Math where

import Graphics.Gloss
import Values (halfSpaceWidth, halfSpaceHeight)

-- Math
distance :: Point -> Point -> Float
distance (x1, y1) (x2, y2) = sqrt (((x2-x1)^2) + ((y2-y1)^2))

isCollision :: Point -> Float -> Point -> Float -> Bool
isCollision p1 size1 p2 size2 = (distance p1 p2) > (size1 + size2)

-- Vector/Point conversions
vectorToPoint :: Vector -> Point
vectorToPoint (m, a) = (m * (cos a), m * (sin a))

pointToVector :: Point -> Vector
pointToVector (x, y) = (sqrt (x*x + y*y), atan2 y x)

addPoints :: Point -> Point -> Point
addPoints (x1, y1) (x2, y2) = (x1+x2, y1+y2)

addVectors :: Vector -> Vector -> Vector
addVectors v1 v2 = pointToVector (addPoints (vectorToPoint v1) (vectorToPoint v2))

-- General Movement
applyMomentumToX :: Float -> Float -> Vector -> Float
applyMomentumToX x t (v, r) = x + (cos r) * v * t

applyMomentumToY :: Float -> Float -> Vector -> Float
applyMomentumToY y t (v, r) = y + (sin r) * v * t

movePos :: Float -> Point -> Vector -> Point
movePos dT (x, y) mom = applySpaceBounds (applyMomentumToX x dT mom, applyMomentumToY y dT mom)

applySpaceAxisBound :: Float -> Float -> Float
applySpaceAxisBound axisHalfSize z
    | z > axisHalfSize = z - (axisHalfSize * 2)
    | z < (-axisHalfSize) = z + (axisHalfSize * 2)
    | otherwise = z

applySpaceXBound = applySpaceAxisBound halfSpaceWidth
applySpaceYBound = applySpaceAxisBound halfSpaceHeight

applySpaceBounds :: Point -> Point
applySpaceBounds (x, y) = (applySpaceXBound x, applySpaceYBound y)

