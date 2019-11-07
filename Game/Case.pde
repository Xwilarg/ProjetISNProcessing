/*
 * Crée par Christian CHAUX en début 2016
 * Dernières modifications le 04/07/2016
 */

class Case
{
  byte x, y;
  char valeur;
  color couleur;
  
  boolean estOuvrable, estTraversable, estAttaquable;
  Personnage persoQuiOccupe; // Personnage qui occupe la case
  Personnage mortQuiOccupe;
  Coffre coffreQuiOccupe;
  Piege piegeQuiOccupe;
  BombePose bombeQuiOccupe;
  Projectile projQuiOccupe;
  boolean contientPerso;       boolean rPerso(){return contientPerso;}
  boolean contientCoffre;      boolean rCoffre(){return contientCoffre;}
  boolean contientPiege;       boolean rPiege(){return contientPiege;}
  boolean contientBombe;       boolean rBombe(){return contientBombe;}
  boolean contientProjectile;  boolean rProjectile(){return contientProjectile;}
  boolean contientMort;        boolean rMort(){return contientMort;}
  boolean nonOccupe;           boolean rNonOccupe(){return nonOccupe;}
  
  Case(char valeur, byte x, byte y)
  {
    this.valeur = valeur;
    this.x = x;
    this.y = y;
    changeValeur(valeur);
  }
  
  void defEstOccupe()
  {
    persoQuiOccupe = null;
    coffreQuiOccupe = null;
    piegeQuiOccupe = null;
    bombeQuiOccupe = null;
    projQuiOccupe = null;
    mortQuiOccupe = null;
    contientPerso = false;
    contientCoffre = false;
    contientPiege = false;
    contientBombe = false;
    contientProjectile = false;
    contientMort = false;
    nonOccupe = false;
    if(progIntro == 1 && x == petiteSoeur.returnXPerso() && y == petiteSoeur.returnYPerso())
    {
      persoQuiOccupe = petiteSoeur;
      contientPerso = true;
    }
    for(int i = 0 ; i < proj.size() ; i++)
    {
      try{
        if(x == proj.get(i).rX() && y == proj.get(i).rY())
        {
          projQuiOccupe = proj.get(i);
          contientProjectile = true;
        }
      } catch(NullPointerException ne) {}
    }
    
    for(int i = 0 ; i < persoMort.size() ; i++)
    {
      try{
        if(x == persoMort.get(i).returnXPerso() && y == persoMort.get(i).returnYPerso())
        {
          mortQuiOccupe = persoMort.get(i);
          contientMort = true;
        }
      } catch(NullPointerException ne) {}
    }
    
    for(int i = 0 ; i < ennemis.size() ; i++)
    {
      try{
        if(x == ennemis.get(i).returnXPerso() && y == ennemis.get(i).returnYPerso())
        {
          persoQuiOccupe = ennemis.get(i);
          contientPerso = true;
        }
      } catch(NullPointerException ne) {}
    }
    
    for(int i = 0 ; i < persoNeutre.size() ; i++)
    {
      try{
        if(x == persoNeutre.get(i).returnXPerso() && y == persoNeutre.get(i).returnYPerso())
        {
          persoQuiOccupe = persoNeutre.get(i);
          contientPerso = true;
        }
      } catch(NullPointerException ne) {}
    }
    
    if(modeDeJeu != 0)
    {
      for(int i = 0 ; i < equipe.size() ; i++)
      {
        try{
          if(x == equipe.get(i).returnXPerso() && y == equipe.get(i).returnYPerso())
          {
            persoQuiOccupe = equipe.get(i);
            contientPerso = true;
          }
        } catch(NullPointerException ne) {}
        catch(ArrayIndexOutOfBoundsException ae){}
      }
    }
    else
    {
      for(int i = 0 ; i < listePersos.length ; i++)
      {
        try{
          if(x == listePersos[i].returnXPerso() && y == listePersos[i].returnYPerso())
          {
            persoQuiOccupe = listePersos[i];
            contientPerso = true;;
          }
          if(x == joueur.returnXPerso() && y == joueur.returnYPerso())
          {
            persoQuiOccupe = joueur;
            contientPerso = true;;
          }
        } catch(NullPointerException ne) {}
        catch(ArrayIndexOutOfBoundsException ae){}
      }
    }
    
    for(int i = 0 ; i < bombesPose.size() ; i++)
    {
      try{
        if(x == bombesPose.get(i).rX() && y == bombesPose.get(i).rY())
        {
          bombeQuiOccupe = bombesPose.get(i);
          contientBombe = true;
        }
      } catch(NullPointerException ne) {}
    }
    
    for(int i = 0 ; i < coffres.size() ; i++)
    {
      try{
        if(x == coffres.get(i).returnXCoffre() && y == coffres.get(i).returnYCoffre() && coffres.get(i).returnTypeCoffre() != 5)
        {
          coffreQuiOccupe = coffres.get(i);
          contientCoffre = true;
        }
      } catch(NullPointerException ne) {}
    }
    
    for(int i = 0 ; i < pieges.size() ; i++)
    {
      try{
        if(x == pieges.get(i).returnX() && y == pieges.get(i).returnY())
        {
          piegeQuiOccupe = pieges.get(i);
          contientPiege = true;
        }
      } catch(NullPointerException ne) {println("NYAN " + ne.getMessage());}
    }
    if(contientPerso == false && contientCoffre == false && contientPiege == false && contientBombe == false && contientProjectile == false)
      nonOccupe = true;
  }
  
  boolean defAttaquable()
  {
    for(int i = 0 ; i < ennemis.size() ; i++)
    {
      try{
        if(x == ennemis.get(i).returnXPerso() && y == ennemis.get(i).returnYPerso() || x == joueur.returnXPerso() && y == joueur.returnYPerso())
        {
          if(ennemis.get(i).returnVie() == 0)
            return false;
          else
            return true;
        }
      } catch(NullPointerException ne) {}
    }
    
    for(int i = 0 ; i < persoNeutre.size() ; i++)
    {
      try{
        if(x == persoNeutre.get(i).returnXPerso() && y == persoNeutre.get(i).returnYPerso() || x == joueur.returnXPerso() && y == joueur.returnYPerso())
        {
          if(persoNeutre.get(i).returnVie() == 0)
            return false;
          else
            return true;
        }
      } catch(NullPointerException ne) {}
    }
    return false;
  }
  
  boolean defTraversable()
  {
    if(contientPerso)
      if(persoQuiOccupe.returnVie() > 0)
        return false;
     
    if(contientCoffre)
      return false;
      
    if(contientPiege)
      return true;
      
    if(valeur == '.')      return true; // Sol
    else if(valeur == 'E') return true; // Entrée
    else if(valeur == 'S') return true; // Sortie
    else if(valeur == '*') return true; // Objet au sol
    else if(valeur == 'Z') return true; // Passage secret
    else if(valeur == 'X') return true; // Event
    else if(valeur == '@') return true; // Brouillard
    else if(valeur == '+') return true; // Sable
    else if(valeur == ',') return true; // Herbe
    else                   return false;
  }
  
  boolean defOuvrable()
  {
    if(valeur == 'P')      return true;
    else if(valeur == 'Z') return true;
    else                   return false;
  }
  
  void changeValeur(char nouvelleValeur)
  {
    valeur = nouvelleValeur;
    defEstOccupe();
    estOuvrable = defOuvrable();
    estAttaquable = defAttaquable();
    estTraversable = defTraversable();
  }
  
  Piege      returnPiegeQuiOccupe(){return piegeQuiOccupe;}
  Coffre     returnCoffreQuiOccupe(){return coffreQuiOccupe;}
  Personnage returnPersoQuiOccupe(){return persoQuiOccupe;}
  BombePose  returnBombeQuiOccupe(){return bombeQuiOccupe;}
  color      returnCouleur(){return couleur;}
  byte       returnX(){return x;}
  byte       returnY(){return y;}
  char       returnValeur(){return valeur;}
  boolean    returnEstOuvrable(){return estOuvrable;}
  boolean    returnEstTraversable(){return estTraversable;}
  boolean    returnEstAttaquable(){return estAttaquable;}
}