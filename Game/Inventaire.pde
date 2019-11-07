/*
 * Crée par Christian CHAUX le 11/05/2016
 * Dernières modifications le 13/07/2016
 */
 
class Inventaire
{
  Personnage perso;
  Inventaire(Personnage perso)
  {
    this.perso = perso; // Définit à qui est l'inventaire
  }
  
  void utiliserBarreAction(byte touche)
  {
    println("INVENTAIRE.TOUCHE :" + touche);
    if(touche >= 5)
    {
      if(tabInventaire[0][touche-5] != null)
      {
        tabInventaire[0][touche-5].action();
        tabInventaire[0][touche-5].reduireNbEmpile();
        if(tabInventaire[0][touche-5].returnNbEmpile() == 0)
          tabInventaire[0][touche-5] = null;
      }
    }
  }
  
  void ajouterObjet(Objet aAjouter)
  {
    boolean ajoute = false;
    for(int i = 0 ; i < tabInventaire.length && !ajoute ; i++)
    {
      for(int y = 0 ; y < tabInventaire[0].length && !ajoute ; y++)
      {
        try{
          if(tabInventaire[i][y].returnID() == aAjouter.returnID())
          {
            tabInventaire[i][y].augmenterNbEmpile();
            ajoute = true;
          }
        } catch(NullPointerException ne) {}
      }
    }
    
    for(int i = 0 ; i < tabInventaire.length && !ajoute ; i++)
    {
      for(int y = 0 ; y < tabInventaire[0].length && !ajoute ; y++)
      {
        if(tabInventaire[i][y] == null)
        {
          tabInventaire[i][y] = aAjouter;
          ajoute = true;
        }
      }
    }
  }
  
  void afficherInventaire()
  {
    short tailleX = 1000;
    short tailleY = 400;
    int coteG = (int)((menuP.tailleFenX()/2)-500); // coté gauche
    short coteH = (short)((menuP.tailleFenY()/2)-200); // coté haut
    short coteB = (short)(coteH + tailleY); // coté bas
    short coteD = (short)(coteG + tailleX);// coté droit
    // Evite d'utiliser des fonctions à rallonge.
    
    byte nbColonnes = 15;
    byte nbLignes = 8;
    byte tailleCase = (byte)(tailleY/nbLignes);
    
    fill(0);
    rect(coteG, coteG, tailleX, tailleY);
    fill(255);
    stroke(10);
    for(byte i = 0 ; i < nbColonnes ; i++) {
      for(byte y = 0 ; y < nbLignes ; y++) {
        afficherImage(fCaseInventaire, coteG+i*tailleCase, coteG+y*tailleCase);
        if(tabInventaire[i][y] == null)
          afficherImage(fCaseInventaire, coteG+i*tailleCase, coteG+y*tailleCase);
        else
        {
          try{
            afficherImage(tabInventaire[i][y].returnImage(), coteG+i*tailleCase, coteG+y*tailleCase);
          } catch(Exception e) {println("Image non trouvée");}
          text(tabInventaire[i][y].returnNbEmpile(), coteG+i*tailleCase+30, coteG+y*tailleCase+45);
        }
        if(mouseX < coteG+(i+1)*tailleCase && mouseX > coteG+i*tailleCase && mouseY < coteH+y*tailleCase && mouseY > coteH+(y-1)*tailleCase) // Description de l'objet
        {
          try{
            text(tabInventaire[i][y].description(), coteG + nbColonnes*tailleCase+10, coteH+10);
          } catch(Exception e) {}
        }
      }
    }
    noStroke();
    
    fill(255, 255, 0);
    textSize(15);
    text(d.affichageStats("Or") + ": " + joueur.returnOr(), coteD-60, coteB-60);
  }
  
  void diminuerDeUn(byte id)
  {
    for(int i = 0 ; i < tabInventaire.length ; i++) {
      for(int y = 0 ; y < tabInventaire[0].length ; y++) {
        try{
          if(tabInventaire[i][y].returnID() == id)
          {
            tabInventaire[i][y].reduireNbEmpile();
            if(tabInventaire[i][y].returnNbEmpile() == 0)
              tabInventaire[i][y] = null;
          }
        } catch(NullPointerException ne) {}
      }
    }
  }
  
  boolean rechercherObjet(byte id) // Permet de repérer l'objet par rapport à son image
  {
    for(int i = 0 ; i < tabInventaire.length ; i++) {
      for(int y = 0 ; y < tabInventaire[0].length ; y++) {
        try{
          if(tabInventaire[i][y].returnID() == id)
          {
            return true;
          }
        } catch(NullPointerException ne) {}
      }
    }
    return false;
  }
  
  Objet tabInventaire[][] = new Objet[15][8];
  
  Objet returnObjet(byte x, byte y){return tabInventaire[x][y];}
}