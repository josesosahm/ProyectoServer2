class Nave
{
  Vector   m_pPosicion;
  float    m_fRapidezActual;
  float    m_fRapidezMaxima;
  float    m_fAceleracion;
  float    m_fFriccion;
  float    m_fAngulo;
  float    m_fRapidezAngular;
  float    m_fRapidezAngularMaxima;
  float    m_fAceleracionAngular;
  float    m_fFriccionAngular;
  float    m_fRadio = 25.0;

  Boolean  m_bArriba;
  Boolean  m_bAbajo;
  Boolean  m_bIzquierda;
  Boolean  m_bDerecha;

  Boolean  m_bDestruida = false;
  float    m_fRelojDestruccion = 0.0;

  Boolean  m_bInvencible = true;      //Esto evita que la nave se destruya
  float    m_fRelojInvencible = 0.0;  //si al aparecer choca con un asteroide.
  //nos da un tiempo para comenzar.  
  Nave()
  {
    m_pPosicion = new Vector(600.0, 500.0);
    m_fRapidezActual = 0.0;
    m_fRapidezMaxima = 500.0;
    m_fAceleracion = 0.0;
    m_fFriccion = 0.025;

    m_fAngulo = 0.0;
    m_fRapidezAngular = 0.0;
    m_fRapidezAngularMaxima = PI * 3.0;
    m_fAceleracionAngular = 0.0;
    m_fFriccionAngular = 0.075;

    m_bArriba = false;
    m_bAbajo = false;
    m_bIzquierda = false;
    m_bDerecha = false;
  }//Fin del constructor
  
  /*Aquí controlamos el comportamiento de la nave cuando
   se destruye. Se configura el reloj de destrucción para que 
   la nave tenga un tiempo de invencibilidad cuando aparece.
   Así mismo, vuelve a aparecer en la mitad de la pantalla, en las
   coordenadas 400, 300.*/
  void Actualizar()
  {
    fill(255);
    text("Score:" + "" + g_iScore, 0, 50);
    if (m_bDestruida)
    {
      
      m_fRelojDestruccion += 1.0 / frameRate;

      if (m_fRelojDestruccion > 3.0)
      {
        m_bDestruida = false;
        m_bInvencible = true;
        m_fRelojDestruccion = 0.0;
        m_fRelojInvencible = 0.0;

        m_pPosicion.m_fX = 400.0;
        m_pPosicion.m_fY = 300.0;

        m_fRapidezActual = 0.0;
        m_fRapidezAngular = 0.0;

        return;
      }
    }//Fin del if.

    ///////////Continuamos con el void Actualizar()///////////

    m_fAceleracion = 0.0;        //Esta aceleración permite esa
    //sensación de frenado con el movimiento.    
    if (m_bArriba)
      m_fAceleracion += 250.0;

    if (m_bAbajo)
      m_fAceleracion -= 250.0;

    m_fAceleracionAngular = 0.0;

    if (m_bIzquierda)
      m_fAceleracionAngular -= PI * 2.75;

    if (m_bDerecha)
      m_fAceleracionAngular += PI * 2.75;

    m_fRapidezActual += m_fAceleracion / frameRate;
    m_fRapidezActual = min(m_fRapidezActual, m_fRapidezMaxima);
    m_fRapidezActual = max(m_fRapidezActual, -m_fRapidezMaxima);

    m_fRapidezAngular += m_fAceleracionAngular / frameRate;
    m_fRapidezAngular = min(m_fRapidezAngular, m_fRapidezAngularMaxima);
    m_fRapidezAngular = max(m_fRapidezAngular, -m_fRapidezAngularMaxima);

    m_fAngulo += m_fRapidezAngular / frameRate;

    float fX = cos(m_fAngulo) * m_fRapidezActual / frameRate;
    float fY = sin(m_fAngulo) * m_fRapidezActual / frameRate;

    Vector pVelocidad = new Vector(fX, fY);

    m_pPosicion = m_pPosicion.Sumar(pVelocidad); //Nos permite tener velocidad.

    /*Estos if evitan que la nave se salga de la pantalla.
     La regresan siempre a su posición opuesta en la pantalla.*/
    if (m_pPosicion.m_fX > 800.0)
      m_pPosicion.m_fX -= 800.0;

    if (m_pPosicion.m_fX < 0.0)
      m_pPosicion.m_fX += 800.0;

    if (m_pPosicion.m_fY > 600.0)
      m_pPosicion.m_fY -= 600.0;

    if (m_pPosicion.m_fY < 0.0)
      m_pPosicion.m_fY += 600.0;

    m_fRapidezActual -= m_fRapidezActual * m_fFriccion;
    m_fRapidezAngular -= m_fRapidezAngular * m_fFriccionAngular;

    m_fRelojInvencible += 1.0 / frameRate; 
    if (m_fRelojInvencible > 3.0)
      m_bInvencible = false;

    //Esto nos despliega un mensaje para saber que
    //tenemos invencibilidad o inmunidad. Los asteroides
    //no destruyen la nave en este punto.
    if (m_bInvencible)
    {
      textSize(50);
      fill(255,255,0);
      text("Escudo Activo", 0, 100);
      return;
    }

    //Detección de colisión con los asteroides

    for (int i = 0; i < g_pAsteroides.size(); i++)
    {
      Asteroide pAst = g_pAsteroides.get(i);
      Vector pDist = m_pPosicion.Restar(pAst.m_pPosicion);
      float flongitud = pDist.Longitud();

      if (flongitud < m_fRadio + pAst.m_fRadio)
      { 
        m_bDestruida = true;
        g_iScore  = 0;
        return;
      }
    }//Fin del for
  }//Fin del void Actualizar().

  void Dibujar()
  {
    if (m_bDestruida)
    {
      return;
    }
    
    translate(m_pPosicion.m_fX, m_pPosicion.m_fY);
    rotate(m_fAngulo);

    /*Aquí aplicamos textura a una imagen en coordenadas
     específicas. En este caso, es más fácil generar el movimiento
     en base a un triángulo. La imagen se ajusta a este triángulo
     para así generar una punta para poder apuntar.*/

    noStroke();
    PImage nave = loadImage("Nave.png");
    noFill();
    beginShape();
    texture(nave);
    vertex(50.0, 0, 148, 56);    //Aquí controlamos que la imagen
    vertex(-50.0, -50.0, 0, 112); //se adapte al triángulo, haciendo coincidir
    vertex(-50.0, 50.0, 0, 0);   //la punta de la imagen nave.png con la punta
    endShape(CLOSE);           //del triángulo.
  }//Fin del void Dibujar. 

  void Tecla(int iCodigo, Boolean bPresionada)
  {
    switch(iCodigo)
    {
    case UP:   m_bArriba    = bPresionada; break;
    case DOWN: m_bAbajo     = bPresionada; break;
    case LEFT: m_bIzquierda = bPresionada; break;
    case RIGHT:m_bDerecha   = bPresionada; break;
    case TAB:
      if (!bPresionada && !m_bDestruida)
      {
        Bala pBala = new Bala(m_pPosicion, m_fAngulo);
      }
      break;
    }
  }//Fin del void Tecla().
}//Fin del class Nave.