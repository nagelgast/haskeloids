module Input where

import Graphics.Gloss
import Graphics.Gloss.Interface.Pure.Game
import Values
import Data
import Math
import Logic

doInput :: Event -> World -> World
doInput event world = handleInput event world

-- Input Handlers
handleInput :: Event -> World -> World
handleInput (EventKey (SpecialKey KeyUp) Down _ _) world = boost world
handleInput (EventKey (SpecialKey KeyLeft) Down _ _) world = turnLeft world
handleInput (EventKey (SpecialKey KeyRight) Down _ _) world = turnRight world
handleInput (EventKey (SpecialKey KeySpace) Down _ _) world = spawnBullet world
handleInput _ ship = ship

boost world = updateShip (accelerateShip shipSpeed) world
turnLeft world = updateShip (rotateShip shipTurnSpeed) world
turnRight world = updateShip (rotateShip (-shipTurnSpeed)) world

rotateShip :: Float -> Ship -> Ship
rotateShip dR ship = rotateTransform dR ship

getShipTip :: Ship -> Point
getShipTip (T p r _) = addPoints p (vectorToPoint (shipTip, r))

-- World Handlers
updateShip :: (Ship -> Ship) -> World -> World
updateShip f (World ship bullets asteroids) = World (f ship) bullets asteroids

-- Bullets
spawnBullet :: World -> World
spawnBullet (World ship bullets asteroids) = World ship ((createBullet ship):bullets) asteroids

createBullet :: Ship -> Bullet
createBullet ship@(T _ r _) = B (T (getShipTip ship) r (bulletSpeed, r)) bulletDuration