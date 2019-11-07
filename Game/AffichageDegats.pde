/*
 * Crée par Christian CHAUX le 21/03/2016
 * Dernières modifications le 22/05/2016
 */

class AffichageDegats
{
  int valeur;
  short r, g, b; // RGB
  short x, y;
  boolean estActif;
  final short duree = 2; // en secondes
  long tmpFin;
  AffichageDegats()
  {
    estActif = false;
  }
  
  void activer(int valeur, byte a_x, byte a_y)
  {
    x = (short)(a_x*carteActuelle.returnTailleCase()+(random(carteActuelle.returnTailleCase()*2)-carteActuelle.returnTailleCase()/2)-camJoueur.returnPointXGauche()*carteActuelle.returnTailleCase());
    y = (short)(a_y*carteActuelle.returnTailleCase()+(random(carteActuelle.returnTailleCase()*2)-carteActuelle.returnTailleCase()/2)-camJoueur.returnPointYGauche()*carteActuelle.returnTailleCase());
    this.valeur = valeur;
    estActif = true;
    tmpFin = System.currentTimeMillis() + duree*1000;
  }
  
  void afficher()
  {
    if(estActif)
    {
      if(valeur < 99999)
      {
        if(valeur > 0)
        {
          r = 255; g = 255; b = 0; // RGB
          g -= valeur*3;
        }
        else if (valeur == 0)
        {
          r = 255; g = 255; b = 255;
        }
        else
        {
          r = 127; g = 255; b = 0;
          g -= valeur*3;
        }
        
        if(valeur > 50 || valeur < -50) textSize(50);
        else if(valeur < 0) textSize(-valeur);
        else if(valeur < 10 || valeur == 0) textSize(10);
        else textSize(valeur);
        
        if(valeur == 0) fill(255, 255, 255, tmpFin-System.currentTimeMillis());
        else fill(r, g, b, tmpFin-System.currentTimeMillis());
        text(valeur, x, y+tmpFin/100-System.currentTimeMillis()/100);
      }
      else if(valeur == 99999)
      {
        fill(0, 191, 255);
        textSize(15);
        text(d.outOfMana(), x, y+tmpFin/100-System.currentTimeMillis()/100);
      }
      else if(valeur < 200000 && valeur > 100000)
      {
        fill(255, 215, 0);
        textSize(15);
        text("+" + (valeur-100000) + " " + d.affichageStats("Or"), x, y+tmpFin/100-System.currentTimeMillis()/100);
      }
      else if(valeur < 300000 && valeur > 200000)
      {
        fill(255, 0, 255);
        textSize(15);
        text("+" + (valeur-200000) + " " + d.affichageStats("XP"), x, y+tmpFin/100-System.currentTimeMillis()/100);
      }
      else if(valeur == 300001)
      {
        fill(255, 0, 0);
        textSize(15);
        text(d.utilisationImpossible(), x, y+tmpFin/100-System.currentTimeMillis()/100);
      }
      else if(valeur < 500000 && valeur > 400000)
      {
        fill(0, 0, 255);
        textSize(15);
        text("+" + (valeur-400000) + " " + d.affichageStats("Mana"), x, y+tmpFin/100-System.currentTimeMillis()/100);
      }
      else if(valeur < 600000 && valeur > 500000)
      {
        fill(0, 255, 0);
        textSize(15);
        text("+" + (valeur-500000) + " " + d.affichageStats("Vigueur"), x, y+tmpFin/100-System.currentTimeMillis()/100);
      }
    }
    if(System.currentTimeMillis() > tmpFin) estActif = false;
  }
}