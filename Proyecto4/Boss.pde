ArrayList<Boss> g_pBoss = new ArrayList<Boss>();

class Boss
{
  Vector m_pPosicion;
  Vector m_pVelocidad;
  float  m_fRadioBoss;
  float  m_fRotacion;
  int    m_iSubDB;
  
  Boss()
  {
    m_iSubDB        = int(random(1,4));
    m_fRadioBoss    = 60;
    m_fRotacion     = random(-PI, PI);
        
    m_pPosicion = new Vector(
      200.0 + cos(m_fRotacion) * 200.0,
      100.0 + sin(m_fRotacion) * 200.0
    );
    
    float fRapidez = random(15.0, 30.0);
    float fX       = cos(m_fRotacion) * fRapidez / frameRate;
    float fY       = sin(m_fRotacion) * fRapidez / frameRate;
    
    m_pVelocidad = new Vector(fX, fY);
    
    g_pBoss.add(this);
  }//Fin del constructor.
  
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
  
  void Dibujar()
  {
    camera();
    fill(0);
    rectMode(CENTER);
    translate(m_pPosicion.m_fX, m_pPosicion.m_fY);
    rotateY(5*PI / frameRate);
    lights();
    stroke(51,255,255);
    strokeWeight(0.3);
    sphereDetail(12,12);
    sphere(m_fRadioBoss);
  }
  
  void Destruir()
  {
    g_pBoss.remove(this);
    
    if (m_fRadioBoss < 20.0)
      return;
    
    for(int i = 0; i < m_iSubDB; i++)
    {
      Boss pBoss         = new Boss();
      pBoss.m_pPosicion  = m_pPosicion.Copiar();
      pBoss.m_fRadioBoss = m_fRadioBoss / 1.4;
    }
  }//Fin del void Destruir().
  
}//Fin del class Boss.