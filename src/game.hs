import Graphics.Gloss.Interface.Pure.Game

import Values (initialState)
import Drawing (doDraw)
import Input (doInput)
import Logic (doUpdate)

displayMode = FullScreen
bgColor = white
stepsPerSecond = 30 :: Int

game = play displayMode bgColor stepsPerSecond initialState doDraw doInput doUpdate

-- TODO
-- Collision
-- Splitting
-- Game Over
