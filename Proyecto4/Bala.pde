ArrayList<Bala> g_pBalas = new ArrayList<Bala>();

class Bala
{
  Vector m_pPosicion;
  Vector m_pVelocidad;
  float m_fRadio = 5.0;
  
  Bala(Vector pPosicion, float fAngulo)
  {
    m_pPosicion = pPosicion.Copiar();
    
    float fX = cos(fAngulo) * 1500.0 / frameRate;
    float fY = sin(fAngulo) * 1500.0 / frameRate;
    m_pVelocidad = new Vector(fX, fY);
    g_pBalas.add(this);
  }//Fin del constructor.
  
  //Esto hace que las balas desaparezcan
  //cuando llegan al final de la pantalla.
  void Actualizar()
  {
    m_pPosicion = m_pPosicion.Sumar(m_pVelocidad);
    
    if(
      m_pPosicion.m_fX > 750.0
      || m_pPosicion.m_fX < 0.0
      || m_pPosicion.m_fY > 650.0
      || m_pPosicion.m_fY < 0.0
      )
    {
      g_pBalas.remove(this);
      return;
    }//Fin del if.
      
       for (int i = 0; i < g_pAsteroides.size(); i++)
       {
          Asteroide pAst = g_pAsteroides.get(i);
          Vector pDist = m_pPosicion.Restar(pAst.m_pPosicion);
          float flongitud = pDist.Longitud();
        
          if(flongitud < m_fRadio + pAst.m_fRadio)
          {
            g_pBalas.remove(this);
            pAst.Destruir();
            g_iScore += 25;
             
            return;
          }
       }//Fin del for.
       
       for (int i = 0; i < g_pBoss.size(); i++)
       {
          Boss pBoss = g_pBoss.get(i);
          Vector pDist = m_pPosicion.Restar(pBoss.m_pPosicion);
          float flongitud = pDist.Longitud();
        
          if(flongitud < m_fRadio + pBoss.m_fRadioBoss)
          {
            g_pBalas.remove(this);
            pBoss.Destruir();
            g_iScore += 50;
             
            return;
          }
       }//Fin del for.
  }//Fin del void actualizar. 
  
  void Dibujar()
  {
    camera();
    fill( color(51,255,255) );
    ellipse(m_pPosicion.m_fX, m_pPosicion.m_fY, 10.0, 10.0);
    
    /*Este if genera balas mas grandes y las cambia de color
    cuando el score supera 500 puntos. De esta manera se le hace mas
    facil al jugador destruir los asteroides cuando tiene un
    mejor puntaje.*/
    if(g_iScore >= 600)
    {
      fill(0, 255, 0);
      ellipse(m_pPosicion.m_fX, m_pPosicion.m_fY, 30.0, 30.0);
    }
  }
  
}//Fin del class Bala. 