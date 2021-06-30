module Drawing where

import Graphics.Gloss
import Data
import Values(shipPic, bulletPic, asteroidPic, screenBorder)

doDraw :: World -> Picture
doDraw (World ship bullets asteroids) = Pictures (screenBorder:(drawShip ship):((drawAllBullets bullets) ++ (drawAllAsteroids asteroids)))

-- Entities
drawAllBullets :: [Bullet] -> [Picture]
drawAllBullets bullets = map drawBullet bullets

drawBullet :: Bullet -> Picture
drawBullet (B t _) = drawEntity bulletPic t

drawAllAsteroids :: [Asteroid] -> [Picture]
drawAllAsteroids asteroids = map drawAsteroid asteroids

drawAsteroid :: Asteroid -> Picture
drawAsteroid (A t _) = drawEntity asteroidPic t

drawShip = drawEntity shipPic

drawEntity :: Picture -> Transform -> Picture
drawEntity pic (T (x, y) r _) = Translate x y (Rotate (convertAngle r) pic)

-- Needed since Gloss works in radians
convertAngle :: Float -> Float
convertAngle a = a * (-180) / pi + 90

