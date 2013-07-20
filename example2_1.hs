import Graphics.Rendering.OpenGL
import Graphics.UI.GLUT

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
  ortho2D 0.0 (realToFrac w) 0.0 (realToFrac h)


initfn :: IO ()
initfn = do 
  matrixMode $= Projection
  loadIdentity
  ortho 0.0 1.0 0.0 1.0 (-1.0) 1.0


display :: IO ()
display = do
  clearColor $= Color4 1.0 0.0 0.0 1.0 
  clear [ ColorBuffer ] 
  renderPrimitive Polygon $ do 
    color (Color3 (1.0::GLfloat) 1.0 1.0)
    vertex (Vertex3 (100::GLfloat) 100 0.0)
    vertex (Vertex3 (300::GLfloat) 100 0.0)
    vertex (Vertex3 (300::GLfloat) 300 0.0)
    vertex (Vertex3 (100::GLfloat) 300 0.0)
  swapBuffers

