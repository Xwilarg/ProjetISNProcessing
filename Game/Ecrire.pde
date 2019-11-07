/*
 * Crée par Christian CHAUX le 22/06/2016
 * Dernières modifications le 22/06/2016
 */
 
class Ecrire
{
  Ecrire(){}
  int derniereToucheEcrire = -999;
  char[] msgEnCours = new char[21];
  int positionCurseurEcriture = -1;
  boolean entreePresse = false;
  
  void backspace()
  {
    if(positionCurseurEcriture > -1)
    {
      msgEnCours[positionCurseurEcriture] = ' ';
      positionCurseurEcriture--;
    }
  }
  
  void enter()
  {
    entreePresse = true;
  }
  
  void autresTouches()
  {
    derniereToucheEcrire = key;
  }
  
  boolean rEntreePresse()
  {
    return entreePresse;
  }
  
  int rPosCurseur(){return positionCurseurEcriture;}
  
  String rTexteEcrit()
  {
    String txtEcrit = "";
    for(int i = 0 ; i < msgEnCours.length ; i++)
    {
      if(msgEnCours[i] == ' ') break;
      else txtEcrit += msgEnCours[i];
    }
    return txtEcrit;
  }
  
  void reset() // Remet toutes les variables à leur état originelle
  {
    for(int i = 0 ; i <= positionCurseurEcriture ; i++)
      msgEnCours[i] = ' ';
          
    positionCurseurEcriture = -1;
    entreePresse = false;
  }
  
  void afficherTexte()
  {
    if(derniereToucheEcrire != -999)
    {
      positionCurseurEcriture++;
      msgEnCours[positionCurseurEcriture] = (char)derniereToucheEcrire;
    }
    
    fill(255);
    textSize(20);
    for(int i = 0 ; i <= positionCurseurEcriture ; i++)
      text(msgEnCours[i], menuP.tailleFenX()/2-20 + i*14, menuP.tailleFenY()/2-10);
      
    derniereToucheEcrire = -999;
  }
}