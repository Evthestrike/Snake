module App (app, initialState) where

import Brick
import DataTypes
import qualified Game.Graphics.Assets
import Game.Graphics.RenderGrid
import qualified Game.Logic.Constants
import Game.Logic.GameLogic
import Graphics.Vty
import qualified Menu.Graphics.Assets
import Menu.Graphics.RenderMenu
import qualified Menu.Logic.Constants
import Menu.Logic.MenuLogic
import System.Random

initialState :: StdGen -> AppMachine
initialState randGen = Menu randGen Menu.Logic.Constants.defaultMenu

renderApp :: AppMachine -> [Widget ()]
renderApp (Game _ gameState) = (: []) . grid Game.Logic.Constants.width Game.Logic.Constants.height $ gameState
renderApp (Menu _ menuState) = (: []) . renderMenu $ menuState

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

handleEvent :: BrickEvent n Tick -> EventM n AppMachine ()
handleEvent e = do
  appState <- get
  case appState of
    (Game randGen gameState) -> handleGameEvent randGen gameState e
    (Menu randGen menuState) -> handleMenuEvent randGen menuState e