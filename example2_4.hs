import Control.Applicative 
import Graphics.Rendering.OpenGL
import Graphics.UI.GLUT

circle_points = [0..99]

main :: IO ()
main = do 
  (progname,_) <- getArgsAndInitialize 
  createWindow "Hello World"
  displayCallback $= display 
  reshapeCallback $= Just reshape 
  initfn 
  mainLoop

reshape s@(Size w h) = do
  viewport $= (Position 0 0,s)
  matrixMode $= Projection 
  loadIdentity
  ortho2D (-10.0) 10.0 (-10.0) 10.0


initfn :: IO ()
initfn = do 
  matrixMode $= Projection
  loadIdentity
  ortho 0.0 1.0 0.0 1.0 (-1.0) 1.0


display :: IO ()
display = do
  clearColor $= Color4 1.0 0.0 0.0 1.0 
  clear [ ColorBuffer ] 
  color (Color3 (1.0::GLfloat) 1.0 1.0)
  
  let angles :: [GLfloat]
      angles = map (\x->x*2.0*pi/100.0) circle_points
       
  renderPrimitive LineLoop $ 
    mapM_ (vertex . uncurry Vertex2 . ((,)<$>cos<*>sin)) angles
  swapBuffers

