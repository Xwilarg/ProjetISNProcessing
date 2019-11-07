/*
 * Crée par Christian CHAUX le 08/03/2016
 * Dernières modifications le 08/06/2016
 */

class Compteur{
  long tmpArr;
  long depart;
  Compteur()
  { 
  }
  
  void initialiser(short duree) // en secondes
  {
    tmpArr = System.currentTimeMillis() + duree*1000;
    depart = System.currentTimeMillis();
  }
  
  void initialiserMili(short duree)
  {
    tmpArr = System.currentTimeMillis() + duree;
    depart = System.currentTimeMillis();
  }
  
  boolean estFini()
  {
    if(System.currentTimeMillis() > tmpArr) return true;
    else return false;
  }
  
  float progression()
  {
    try{
    return (float)(50-((System.currentTimeMillis()-depart)*50)/(tmpArr-depart));
    } catch (ArithmeticException ae) {return -1;}
  }
}