/*
 * Crée par Christian CHAUX le 21/06/2016
 * Dernières modifications le 04/07/2016
 */

class Projectile
{
  byte id; // 0: flèche ; 1: boule de feu
  byte direction; //haut bas gauche droite
  byte x, y;
  PImage image;
  Projectile(byte id, byte direction, byte x, byte y)
  {
    this.id = id;
    this.direction = direction;
    this.x = x;
    this.y = y;
    image = iFleche;
  }
  
  boolean deplacer()
  {
    if(direction == 0)
      y--;
    else if(direction == 1)
      y++;
    else if(direction == 2)
      x--;
    else if(direction == 3)
      x++;
      
    if(!carteActuelle.caseCarte(x, y).returnEstTraversable())
    {
      attaquer();
      return false;
    }
    else return true;
  }
  
  void attaquer() // Lors de l'impact
  {
    if(id == 0)
    {
      if(carteActuelle.caseCarte(x, y).rPerso())
        carteActuelle.caseCarte(x, y).returnPersoQuiOccupe().diminuerVie(10, carteActuelle.caseCarte(x, y).returnPersoQuiOccupe()); // Valeur fixe pour le moment, a changer
    }
  }
  
  byte rX(){return x;}
  byte rY(){return y;}
}