{-# LANGUAGE NamedFieldPuns #-}
{-# LANGUAGE RecordWildCards #-}

module App (app, initialState) where

import Brick
import Brick.Widgets.Border
import Brick.Widgets.Center
import qualified Game.Graphics.Assets
import Game.Graphics.RenderGrid
import qualified Game.Logic.Constants
import Game.Logic.DataTypes
import Game.Logic.SnakeLogic
import Graphics.Vty
import qualified Menu.Graphics.Assets
import Menu.Graphics.RenderMenu
import System.Random

initialState :: StdGen -> AppMachine
initialState initRandGen = Game $ GameState {randGen = initRandGen, appleCoord = (1, 1), snake = Snake East [(0, 0)]}

renderApp :: AppMachine -> [Widget ()]
renderApp (Game gameState) = (: []) . grid Game.Logic.Constants.width Game.Logic.Constants.height $ gameState
renderApp (Menu menuState) = (: []) . renderMenu $ menuState

app :: App AppMachine Tick ()
app =
  App
    renderApp
    (\_ _ -> Nothing)
    handleEvent
    (return ())
    ( const . attrMap defAttr $
        [ (Game.Graphics.Assets.headAttr, fg brightGreen),
          (Game.Graphics.Assets.bodyAttr, fg green),
          (Game.Graphics.Assets.appleAttr, fg red),
          (Game.Graphics.Assets.groundAttr, fg white),
          (Menu.Graphics.Assets.selectedAttr, fg yellow)
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
            let (newAppleX, randGen') = uniformR (0, Game.Logic.Constants.width - 1) randGen
                (newAppleY, randGen'') = uniformR (0, Game.Logic.Constants.height - 1) randGen'
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
handleMenuEvent (MenuState {..}) e = do
  let newSelected = case e of
        VtyEvent (EvKey KUp _) ->
          if selected - 1 < 0
            then length menuOptions
            else selected - 1
        VtyEvent (EvKey KDown _) ->
          if selected + 1 < length menuOptions
            then 0
            else selected + 1
        _ -> selected
  return ()

handleEvent :: BrickEvent n Tick -> EventM n AppMachine ()
handleEvent e = do
  appState <- get
  case appState of
    (Game gameState) -> handleGameEvent gameState e
    (Menu menuState) -> handleMenuEvent menuState e