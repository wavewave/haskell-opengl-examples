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
  postRedisplay Nothing

initfn :: IO ()
initfn = do 
  matrixMode $= Projection
  loadIdentity
  ortho 0.0 1.0 0.0 1.0 (-1.0) 1.0


display :: IO ()
display = do 
  clear [ ColorBuffer ] 
  renderPrimitive Polygon $ do 
    color (Color3 (1.0::GLfloat) 1.0 1.0)
    vertex (Vertex3 (0.25::GLfloat) 0.25 0.0)
    vertex (Vertex3 (0.75::GLfloat) 0.25 0.0)
    vertex (Vertex3 (0.75::GLfloat) 0.75 0.0)
    vertex (Vertex3 (0.25::GLfloat) 0.75 0.0)
  swapBuffers

