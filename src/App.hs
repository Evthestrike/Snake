{-# LANGUAGE NamedFieldPuns #-}
{-# LANGUAGE RecordWildCards #-}

module App (app, initialState) where

import Brick
import Brick.Widgets.Border
import Brick.Widgets.Center
import qualified Graphics.Assets as Assets
import Graphics.RenderGrid
import Graphics.Vty
import qualified Logic.Constants as Constants
import Logic.DataTypes
import Logic.SnakeLogic
import System.Random

initialState :: StdGen -> AppMachine
initialState initRandGen = Game $ GameState {randGen = initRandGen, appleCoord = (1, 1), snake = Snake East [(0, 0)]}

renderApp :: AppMachine -> [Widget ()]
renderApp (Game gameState) = (: []) . center . borderWithLabel (str "Snake") . grid Constants.width Constants.height $ gameState

app :: App AppMachine Tick ()
app =
  App
    renderApp
    (\_ _ -> Nothing)
    handleEvent
    (return ())
    ( const . attrMap defAttr $
        [ (Assets.headAttr, fg brightGreen),
          (Assets.bodyAttr, fg green),
          (Assets.appleAttr, fg red),
          (Assets.groundAttr, fg white)
        ]
    )

handleGameEvent :: GameState -> BrickEvent n Tick -> EventM n AppMachine ()
handleGameEvent (GameState {..}) e = do
  let newSnake = case e of
        AppEvent Tick ->
          if (head . coords . growSnake $ snake) == appleCoord
            then growSnake snake
            else moveSnake snake
        VtyEvent (EvKey KUp _) -> turnHead North snake
        VtyEvent (EvKey KDown _) -> turnHead South snake
        VtyEvent (EvKey KRight _) -> turnHead East snake
        VtyEvent (EvKey KLeft _) -> turnHead West snake
        _ -> snake
      (newGen, newAppleCoord) =
        if (head . coords $ newSnake) == appleCoord
          then
            let (newAppleX, randGen') = uniformR (0, Constants.width - 1) randGen
                (newAppleY, randGen'') = uniformR (0, Constants.height - 1) randGen'
             in (randGen'', (newAppleX, newAppleY))
          else (randGen, appleCoord)
      newAppState =
        Game $
          GameState
            { randGen = newGen,
              appleCoord = newAppleCoord,
              snake = newSnake
            }

  case e of
    VtyEvent (EvKey KEsc _) -> halt
    _ ->
      if snakeIsLegal newSnake
        then put newAppState
        else halt

handleMenuEvent :: MenuState -> BrickEvent n Tick -> EventM n AppMachine ()
handleMenuEvent menuState e = pure ()

handleEvent :: BrickEvent n Tick -> EventM n AppMachine ()
handleEvent e = do
  appState <- get
  case appState of
    (Game gameState) -> handleGameEvent gameState e
    (Menu menuState) -> handleMenuEvent menuState e