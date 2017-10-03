/*
  Algebra Lineal
  
  Este archivo contiene clases y funciones que facilitan
  varias tareas cotidianas de programación en tiempo real
*/

// Vector
// Esta clase representa un Vector 2D,
// es decir, un punto con coordenadas x, y
// Contiene varios métodos para realizar
// operaciones vectoriales comúnes.
class Vector
{
  // propiedades
  
  // coordenadas x,y del vector.
  // inicializadas a 0.0 por defecto
  float m_fX = 0.0;
  float m_fY = 0.0;
  
  // constructor normal
  Vector()
  {
  }
  
  // constructor con argumentos x,y
  Vector(float x, float y)
  {
    // copiar los valores a las propiedades
    m_fX = x;
    m_fY = y;
  }
  
  Vector Copiar()
  {
    return new Vector(m_fX, m_fY);
  }
  
  // Sumar() agrega los componentes x,y
  // de otro Vector a los de este, y retorna
  // un nuevo Vector con las coordenadas resultantes.
  Vector Sumar(Vector otro)
  {
    // restar cada componente
    float x = m_fX + otro.m_fX;
    float y = m_fY + otro.m_fY;
    
    // crear un nuevo Vector y retornarlo
    return new Vector(x, y);
  }
  
  // Restar() sustrae los componentes x,y
  // de otro Vector a los de este, y retorna
  // un nuevo Vector con las coordenadas resultantes.
  Vector Restar(Vector otro)
  {
    // restar cada componente
    float x = m_fX - otro.m_fX;
    float y = m_fY - otro.m_fY;
    
    // crear un nuevo Vector y retornarlo
    return new Vector(x, y);
  }
  
  // Lerp() hace una interpolación lineal
  // entre este Vector y otro, al porcentaje indicado,
  // y retorna un nuevo Vector con las coordenadas resultantes.
  Vector Lerp(Vector otro, float porcentaje)
  {
    // aplicar el Lerp a cada componente
    float x = (m_fX * porcentaje) + (otro.m_fX * (1.0 - porcentaje));
    float y = (m_fY * porcentaje) + (otro.m_fY * (1.0 - porcentaje));
    
    // crear un nuevo vector y retornarlo
    return new Vector(x, y);
  }
  
  // Longitud() calcula y retorna
  // la longitud euclidiana del Vector
  // utilizando el teorema de Pitágoras
  float Longitud()
  {
    // calcular la raíz de la suma de los cuadrados y retornar el resultado
    return sqrt(m_fX * m_fX + m_fY * m_fY);
  }
 
  // AnguloRadianes() calcula el ángulo
  // formado por los componentes x,y del Vector
  // utilizando la operación ArcTan 
  float AnguloRadianes()
  {
    return atan2(m_fY, m_fX);
  }

}
