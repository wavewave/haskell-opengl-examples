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
  renderPrimitive Polygon $ do 
    vertex (Vertex2 (0.0::GLfloat) 0.0)
    vertex (Vertex2 (0.0::GLfloat) 3.0)
    vertex (Vertex2 (4.0::GLfloat) 3.0)
    vertex (Vertex2 (6.0::GLfloat) 1.5)
    vertex (Vertex2 (4.0::GLfloat) 0.0)
  swapBuffers

