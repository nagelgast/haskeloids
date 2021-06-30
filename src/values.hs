module Values where

import Graphics.Gloss
import Data

spaceWidth = 500
spaceHeight = 500
shipSpeed = 10 :: Float
shipDrag = 0.1 :: Float
shipTurnSpeed = 0.2 :: Float
bulletSpeed = 150 :: Float
bulletDuration = 1 :: Float

shipSize = 10
shipTip = shipSize * 2
bulletSize = 1 :: Float
asteroidSize = 10 :: Float

shipPic = Line [(0, shipTip), (-shipSize,-shipSize), (0,0), (shipSize,-shipSize), (0, shipTip)]
bulletPic = Circle bulletSize
asteroidPic = Circle asteroidSize

initialState = World (T (0,0) 0 (0,0)) [] [(A (T (30, 30) 0 (10,0)) Small)]

halfSpaceWidth = spaceWidth / 2
halfSpaceHeight = spaceHeight / 2

screenBorder = Line [
    ((-halfSpaceWidth), (-halfSpaceHeight)),
    ((-halfSpaceWidth), halfSpaceHeight),
    (halfSpaceWidth, halfSpaceHeight),
    (halfSpaceWidth, (-halfSpaceHeight)),
    ((-halfSpaceWidth), (-halfSpaceHeight))]

