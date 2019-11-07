/*
 * Crée par Christian CHAUX le 12/05/2016
 * Dernières modifications le 14/06/2016
 */
 
class Piege
{
  short id; // 0: trou ; 1: piège
  PImage image;
  byte x, y;
  boolean amorce;
  Piege(byte x, byte y, short id)
  {
    this.id = id;
    amorce = true;
    definirPiege();
    this.x = x;
    this.y = y;
  }

  void definirPiege()
  {
    if(id == 0)
    {
      if(amorce)
        image = iTrou;
      else
        image = iTrouBouche;
    }
    else if(id == 1)
    {
      if(amorce)
        image = iPiegeOurs;
      else
        image = iPiegeOursD;
    }
  }
  
  void effet(Personnage perso)
  {
    if(amorce)
    {
      if(id == 0)
        perso.diminuerVie(10000, null);
      else if(id == 1)
      {
        perso.diminuerVie(50, null);
        amorce = false;
        definirPiege();
      }
    }
  }
  
  void desamorcePiege(){amorce = false;definirPiege();}
  boolean returnEstAmorce(){return amorce;}
  byte returnX(){return x;}
  byte returnY(){return y;}
  PImage returnImage(){return image;}
}