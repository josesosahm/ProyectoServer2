/*Aquí creamos las instancias de asteroides.
El arraylist combinado con las operaciones vectoriales
hace que sea más fácil dibujar asteroides con propiedades
específicas.*/

ArrayList<Asteroide> g_pAsteroides = new ArrayList<Asteroide>();

class Asteroide
{
  Vector m_pPosicion;
  Vector m_pVelocidad;
  
  float m_fRadio;
  float  m_fRotacion;
  int m_iSubD;
  
  Asteroide()
  {
    m_iSubD     = int(random(1,3));
    m_fRadio    = random(20.0, 35.0);
    m_fRotacion = random(-PI, PI);
        
    m_pPosicion = new Vector(
      200.0 + cos(m_fRotacion) * 200.0,
      100.0 + sin(m_fRotacion) * 200.0
    );
    
    float fRapidez = random(5.0, 25.0);
    float fX       = cos(m_fRotacion) * fRapidez / frameRate;
    float fY       = sin(m_fRotacion) * fRapidez / frameRate;
    
    m_pVelocidad = new Vector(fX, fY);
    
    g_pAsteroides.add(this);
  }//Fin del constructor.
  
  //Esto controla lo que ocurre cuando los asteroides
  //se salen de la pantalla. 
  void Actualizar()
  {
    m_pPosicion = m_pPosicion.Sumar(m_pVelocidad);
    
    if(m_pPosicion.m_fX > 800.0)
      m_pPosicion.m_fX -= 800.0;
      
    if(m_pPosicion.m_fX < 0.0)
      m_pPosicion.m_fX += 800.0;
      
    if(m_pPosicion.m_fY > 600.0)
      m_pPosicion.m_fY -= 600.0;
      
    if(m_pPosicion.m_fY < 0.0)
      m_pPosicion.m_fY += 600.0;
  }//Fin del void actualizar.
  
  /*En este dibujar creamos asteroides con esferas que se
  mueven en direcciones aleatorias. Tienen tambien un efecto 
  de rotacion sobre el eje Y para dar al impresion de que
  giran en el espacio*/
  void Dibujar()
  {
    /*La funcion camera actua como ResetMatrix cuando
    utilizamos el operador P3D.*/
    camera();
    fill( color(153,76,0) );
    rectMode(CENTER);
    translate(m_pPosicion.m_fX, m_pPosicion.m_fY);
    rotateY(2*PI / frameRate);
    lights();
    sphere(m_fRadio);
  }
  
  void Destruir()
  {
    g_pAsteroides.remove(this);
    
    if (m_fRadio < 20.0)
      return;
    
    for(int i = 0; i < m_iSubD; i++)
    {
      Asteroide pAst   = new Asteroide();
      pAst.m_pPosicion = m_pPosicion.Copiar();
      pAst.m_fRadio    = m_fRadio / 1.5;
    }
  }//Fin del void Destruir().
  
}//Fin del class Asteroide.