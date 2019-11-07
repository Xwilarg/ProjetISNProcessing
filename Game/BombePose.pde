/*
 * Crée par Christian CHAUX le 09/06/2016
 * Dernières modifications le 04/07/2016
 */
 
class BombePose
{
  byte x, y;
  Compteur detonation;
  PImage image;
  BombePose(byte x, byte y)
  {
    this.x = x;
    this.y = y;
    detonation = new Compteur();
    detonation.initialiser((short)5);
    image = iBombe;
  }
  void exploser()
  {
    if(!carteActuelle.caseCarte((byte)(x+1), y).returnEstTraversable() && carteActuelle.valeurCase((byte)(x+1), y) != 'M')
    {
      carteActuelle.changerValeurCase((byte)(x+1), y, '.');
      if(modeDeJeu == 2 && dansLeNoir == false || modeDeJeu == 1) carteActuelle.enleverBrouillard((byte)3, x, y);
    }
    if(carteActuelle.caseCarte((byte)(x+1), y).rPerso())
    {
      carteActuelle.caseCarte((byte)(x+1), y).returnPersoQuiOccupe().diminuerVie(1000, null);
    }
    
    if(!carteActuelle.caseCarte((byte)(x-1), y).returnEstTraversable() && carteActuelle.valeurCase((byte)(x-1), y) != 'M')
    {
      carteActuelle.changerValeurCase((byte)(x-1), y, '.');
      if(modeDeJeu == 2 && dansLeNoir == false || modeDeJeu == 1) carteActuelle.enleverBrouillard((byte)2, x, y);
    }
    if(carteActuelle.caseCarte((byte)(x-1), y).rPerso())
    {
      carteActuelle.caseCarte((byte)(x-1), y).returnPersoQuiOccupe().diminuerVie(1000, null);
    }
    
    if(!carteActuelle.caseCarte(x, (byte)(y+1)).returnEstTraversable() && carteActuelle.valeurCase(x, (byte)(y+1)) != 'M')
    {
      carteActuelle.changerValeurCase(x, (byte)(y+1), '.');
      if(modeDeJeu == 2 && dansLeNoir == false || modeDeJeu == 1) carteActuelle.enleverBrouillard((byte)1, x, y);
    }
    if(carteActuelle.caseCarte(x, (byte)(y+1)).rPerso())
    {
      carteActuelle.caseCarte(x, (byte)(y+1)).returnPersoQuiOccupe().diminuerVie(1000, null);
    }
    
    if(!carteActuelle.caseCarte(x, (byte)(y-1)).returnEstTraversable() && carteActuelle.valeurCase(x, (byte)(y-1)) != 'M')
    {
      carteActuelle.changerValeurCase(x, (byte)(y-1), '.');
      if(modeDeJeu == 2 && dansLeNoir == false || modeDeJeu == 1) carteActuelle.enleverBrouillard((byte)0, x, y);
    }
    if(carteActuelle.caseCarte(x, (byte)(y-1)).rPerso())
    {
      carteActuelle.caseCarte(x, (byte)(y-1)).returnPersoQuiOccupe().diminuerVie(1000, null);
    }
    
    if(!carteActuelle.caseCarte(x, y).returnEstTraversable() && carteActuelle.valeurCase(x, y) != 'M')
    {
      carteActuelle.changerValeurCase(x, y, '.');
    }
    if(carteActuelle.caseCarte(x, y).rPerso())
    {
      carteActuelle.caseCarte(x, y).returnPersoQuiOccupe().diminuerVie(1000, null);
    }
    
    bombesPose.remove(this);
    
    if(joueur.returnVie() <= 0) dial.gameOver("VIE_NULL", "TUER_BOMBE");
  }
  
  void affichageCompteARebour()
  {
    fill(255, 255, 0);
    textSize(20);
    text(detonation.progression()/10, (x - camJoueur.returnPointXGauche())*carteActuelle.returnTailleCase(), (y - camJoueur.returnPointYGauche())*carteActuelle.returnTailleCase());
  }
  
  byte rX(){return x;}
  byte rY(){return y;}
  PImage returnImage(){return image;}
  boolean aExplose()
  {
    if(detonation.estFini()) return true;
    else return false;
  }
}