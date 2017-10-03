/*Asteroids
José Sosa, Gabriel Sarria.*/

Nave  g_pNave = new Nave();
PImage Background;
int etapa = 1;
int g_iScore;

void setup()
{
  etapa = 1;
  size(800, 600, P3D);
  frameRate(60);
  smooth();
  
  //Controla el número de asteroides
  //que dibujamos. 
  for(int i = 0; i < 10; i++)
  {
    Asteroide pAst = new Asteroide();
  }
  //Hacemos que se dibuje el Boss.
  for(int i = 0; i < 1; i++)
  {
    Boss pBoss = new Boss();
  }
  
  Background = loadImage("Background.jpg");
  image(loadImage("PantallaDeInicio.png"),0,0);
}

void draw()
{
  /*Esto permite dibujar una pantalla de inicio.
  En este caso, la primera pantalla genera una imagen
  de fondo. Esta se activa con aplastar cualquier tecla.*/
  if(etapa==1)
  {
    if(keyPressed == true)
    {
      textSize(50);
      fill(255);
      etapa = 2;
    }
  }
 
  /*En esta etapa se ejecuta el juego en si. Aquí se ejecutan
  la clase Bala, Nave y Asteroide.*/
  if(etapa==2)
  {
    background(Background);
    g_pNave.Actualizar();
    g_pNave.Dibujar();
    
  
    /*Estos lazos for controlan lo que ocurre 
    cuando las balas y los asteroides se salen de la pantalla.
    En ambos casos, el actualizar los redibuja.*/
  
    for(int i = 0; i < g_pBalas.size(); i++)
    {
      Bala pBala = g_pBalas.get(i);
      pBala.Actualizar();
      pBala.Dibujar();
    }
  
    for(int i = 0; i < g_pAsteroides.size(); i++)
    {
      Asteroide pAsteroide = g_pAsteroides.get(i);
      pAsteroide.Actualizar();
      pAsteroide.Dibujar();
    }
    
    for(int i = 0; i < g_pBoss.size(); i++)
    {
      Boss pBoss = g_pBoss.get(i);
      pBoss.Actualizar();
      pBoss.Dibujar();
    }
  }//Fin de la etapa 2.
}//Fin del void draw().


/*Aqui controlamos que las balas dejen de dispararse
cuando soltamos el dedo de la tecla.*/
void keyPressed()
{
  g_pNave.Tecla(keyCode, true);
}

void keyReleased()
{
  g_pNave.Tecla(keyCode, false);
}