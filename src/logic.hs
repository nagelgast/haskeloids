module Logic where

import Data
import Math
import Values(shipSize, asteroidSize)

doUpdate :: DeltaTime -> World -> World
doUpdate dT (World ship bullets asteroids) = World (moveTransform dT ship) (updateBullets dT bullets) (updateAsteroids dT ship asteroids)

-- Game Over

-- Transforms
moveTransform :: DeltaTime -> Transform -> Transform
moveTransform dT t@(T p _ m) = t { pos = (movePos dT p m) }

rotateTransform :: Float -> Transform -> Transform
rotateTransform dR t@(T _ r _) = t { rot = (r + dR) }

boostTransform :: Float -> Transform -> Transform
boostTransform dV t@(T _ r m) = t { mom = addVectors (dV, r) m }

slowTransform :: Float -> Transform -> Transform
slowTransform dV t@(T _ _ (v, a)) = t { mom = ((max (v-dV) 0), a) }

-- Check collisions
removeCollidedAsteroids :: Ship -> [Asteroid] -> [Asteroid]
removeCollidedAsteroids ship asteroids = filter (checkAsteroidCollision ship) asteroids

checkAsteroidCollision :: Ship -> Asteroid -> Bool
checkAsteroidCollision (T p1 _ _) (A (T p2 _ _) size)  = isCollision p1 shipSize p2 asteroidSize


-- Ship
accelerateShip :: Float -> Ship -> Ship
accelerateShip dV ship = boostTransform dV ship

slowShip :: Float -> Ship -> Ship
slowShip dV ship = slowTransform dV ship

-- Bullets
updateBullets :: DeltaTime -> [Bullet] -> [Bullet]
updateBullets dT bullets = filter isBulletAlive $ map (updateBullet dT) bullets

updateBullet :: DeltaTime -> Bullet -> Bullet
updateBullet dT bullet = decayBullet dT $ moveBullet dT bullet

decayBullet :: DeltaTime -> Bullet -> Bullet
decayBullet dT (B t d) = B t (d-dT)

moveBullet :: DeltaTime -> Bullet -> Bullet
moveBullet dT (B t d) = B (moveTransform dT t) d

isBulletAlive :: Bullet -> Bool
isBulletAlive (B _ d) = d > 0

-- Asteroids
updateAsteroids :: DeltaTime -> Ship -> [Asteroid] -> [Asteroid]
updateAsteroids dT ship asteroids = removeCollidedAsteroids ship $ map (updateAsteroid dT) asteroids

updateAsteroid :: DeltaTime -> Asteroid -> Asteroid
updateAsteroid dT asteroid = moveAsteroid dT asteroid

moveAsteroid :: DeltaTime -> Asteroid -> Asteroid
moveAsteroid dT (A t s) = A (moveTransform dT t) s