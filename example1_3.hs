import Data.IORef
import Graphics.Rendering.OpenGL
import Graphics.UI.GLUT

initfn :: IO ()
initfn = do 
  matrixMode $= Projection
  loadIdentity
  ortho 0.0 1.0 0.0 1.0 (-1.0) 1.0


display :: IORef GLfloat -> IO ()
display spinref = do 
  spin <- readIORef spinref
  clear [ ColorBuffer ]
  preservingMatrix $ do
    rotate spin (Vector3 0.0 0.0 1.0)
    color (Color3 (1.0::GLfloat) 1.0 1.0)
    rect  (Vertex2 (-25.0::GLfloat) (-25.0)) (Vertex2 25.0 25.0)
  swapBuffers



spinDisplay :: IORef GLfloat -> IO ()
spinDisplay sref = do 
    modifyIORef sref $ \spin ->  
      let spin' = spin + 2.0
      in if spin' > 360.0 then spin' - 360 else spin'
    postRedisplay Nothing 

 
 
reshape :: Size -> IO ()
reshape s@(Size w h) = do
  viewport $= (Position 0 0,s)
  matrixMode $= Projection 
  loadIdentity
  ortho (-50.0) 50.0 (-50.0) 50.0 (-1.0) 1.0
  matrixMode $= Modelview 0
  loadIdentity



mouse :: IORef GLfloat -> MouseButton -> KeyState -> Position -> IO ()
mouse sref LeftButton Down (Position x y) = idleCallback $= Just (spinDisplay sref)
mouse sref LeftButton _ _ = return ()
mouse sref MiddleButton Down (Position x y) = idleCallback $= Nothing
mouse sref MiddleButton _ _ = return ()
mouse sref _ _ _ = return ()


main :: IO ()
main = do 
  spinref <- newIORef 0.0
  (progname,_) <- getArgsAndInitialize 
  createWindow "Hello World"
  displayCallback $= (display spinref) 
  reshapeCallback $= Just reshape 
  mouseCallback $= Just (mouse spinref)
  initfn 
  mainLoop







