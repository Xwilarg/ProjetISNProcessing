/*
 * Crée par Christian CHAUX le 14/04/2016
 * Dernières modifications le 06/06/2016
 */
 
class Coffre
{
  PImage imageCoffre;
  byte typeCoffre; // 1: en bois ; 2: Argent ; 3: Or ; 4: Glace ; 5 étoile ; 6 rouge ; 7 incrusté de pierres précieuses
  short orGagneDansCoffre;
  byte xCoffre, yCoffre;
  boolean estFerme;
  short chanceApparaitre; // %°
  
  Coffre(byte xCoffre, byte yCoffre, byte typeCoffre)
  {
    this.typeCoffre = typeCoffre;
    this.xCoffre = xCoffre;
    this.yCoffre = yCoffre;
    estFerme = true;
    defApparanceCoffre();
    defContenuCoffre();
  }
  
  void defContenuCoffre()
  {
    if(typeCoffre == 1)
    {
      orGagneDansCoffre = (short)(random(18)+2);
    }
    else if(typeCoffre == 2)
    {
      orGagneDansCoffre = (short)(random(30)+10);
    }
    else if(typeCoffre == 3)
    {
      orGagneDansCoffre = (short)(random(50)+30);
    }
    else if(typeCoffre == 4)
    {
      orGagneDansCoffre = (short)(random(300)+1700);
    }
  }
  
  Objet tirerObjet(byte rarete)
  {
    byte quelObjet;
    byte quantite;
    if(rarete == 1) // Bois
    {
      quelObjet = (byte)(random(5)+1);
      if(quelObjet == 1) joueur.returnInventaire().ajouterObjet(new Potion((byte)1, (short)1)); // Vie
      else if(quelObjet == 2) joueur.returnInventaire().ajouterObjet(new Potion((byte)2, (short)1)); // Mana
      else if(quelObjet == 3) joueur.returnInventaire().ajouterObjet(new Potion((byte)3, (short)1)); // Vigueur
      else if(quelObjet == 4) joueur.returnInventaire().ajouterObjet(new Potion((byte)4, (short)1)); // Chance
      else if(quelObjet == 5) ; // Rien
    }
    else if(rarete == 2)
    {
      quelObjet = (byte)(random(7)+1);
      quantite = (byte)(random(2)+1);
      if(quelObjet == 1) joueur.returnInventaire().ajouterObjet(new Potion((byte)1, (short)quantite)); // Vie
      else if(quelObjet == 2) joueur.returnInventaire().ajouterObjet(new Potion((byte)2, (short)quantite)); // Mana
      else if(quelObjet == 3) joueur.returnInventaire().ajouterObjet(new Potion((byte)3, (short)quantite)); // Vigueur
      else if(quelObjet == 4) joueur.returnInventaire().ajouterObjet(new Potion((byte)4, (short)quantite)); // Chance
      else if(quelObjet == 5) joueur.returnInventaire().ajouterObjet(new Objet((byte)9, (short)1)); // Planche
      else if(quelObjet == 6) joueur.returnInventaire().ajouterObjet(new Objet((byte)10, (short)1)); // Bombe
      else if(quelObjet == 7) ; // Rien
    }
    else if(rarete == 3)
    {
      quelObjet = (byte)(random(6)+1);
      quantite = (byte)(random(2)+1);
      if(quelObjet == 1) joueur.returnInventaire().ajouterObjet(new Potion((byte)1, (short)quantite)); // Vie
      else if(quelObjet == 2) joueur.returnInventaire().ajouterObjet(new Potion((byte)2, (short)quantite)); // Mana
      else if(quelObjet == 3) joueur.returnInventaire().ajouterObjet(new Potion((byte)3, (short)quantite)); // Vigueur
      else if(quelObjet == 4) joueur.returnInventaire().ajouterObjet(new Potion((byte)4, (short)quantite)); // Chance
      else if(quelObjet == 5) joueur.returnInventaire().ajouterObjet(new Objet((byte)6, (short)1)); // Chocolat
      else if(quelObjet == 6) ; // Rien
    }
    else if(rarete == 5)
    {
      if(modeDeJeu == 0)
      {
        joueur.returnInventaire().ajouterObjet(new Potion((byte)1, (short)5)); // Vie
        joueur.returnInventaire().ajouterObjet(new Potion((byte)2, (short)5)); // Mana
        joueur.returnInventaire().ajouterObjet(new Potion((byte)3, (short)5)); // Vigueur
        joueur.returnInventaire().ajouterObjet(new Potion((byte)4, (short)5)); // Chance
        joueur.returnInventaire().ajouterObjet(new Objet((byte)9, (short)1)); // Planche
        joueur.returnInventaire().ajouterObjet(new Objet((byte)10, (short)1)); // Bombe
      }
      else if(modeDeJeu == 2 && !joueur.returnInventaire().rechercherObjet((byte)7)) // Amulette
      {
        joueur.returnInventaire().ajouterObjet(new Objet((byte)7, (short)1)); // Médaillon
      }
      rarete = 0;
    }
    
    if(rarete > 1)
    {
      rarete--;
      tirerObjet(rarete);
    }
    return null;
  }
  
  void ouvrirCoffre()
  {
    if(estFerme)
    {
      println(typeCoffre + " ; " + orGagneDansCoffre);
      joueur.gagneOr(orGagneDansCoffre);
      estFerme = false;
      defApparanceCoffre();
      tirerObjet(typeCoffre);
    }
  }
  
  void defApparanceCoffre()
  {
    if(estFerme)
    {
      if(typeCoffre == 1)      imageCoffre = loadImage("Images/CoffreBoisFerme.png");
      else if(typeCoffre == 2) imageCoffre = loadImage("Images/CoffreArgentFerme.png");
      else if(typeCoffre == 3) imageCoffre = loadImage("Images/CoffreOrFerme.png");
      else if(typeCoffre == 4) imageCoffre = loadImage("Images/CoffreGlaceFerme.png");
      else if(typeCoffre == 5) imageCoffre = iObjetSol;
      else if(typeCoffre == 6) imageCoffre = loadImage("Images/CoffreRougeFerme.png");
      else if(typeCoffre == 7) imageCoffre = loadImage("Images/CoffrePrecieuxFerme.png");
    }
    else
    {
      if(typeCoffre == 1)      imageCoffre = loadImage("Images/CoffreBoisOuvert.png");
      else if(typeCoffre == 2) imageCoffre = loadImage("Images/CoffreArgentOuvert.png");
      else if(typeCoffre == 3) imageCoffre = loadImage("Images/CoffreOrOuvert.png");
      else if(typeCoffre == 4) imageCoffre = loadImage("Images/CoffreGlaceOuvert.png");
      else if(typeCoffre == 5) imageCoffre = null;
      else if(typeCoffre == 6) imageCoffre = loadImage("Images/CoffreBoisOuvert.png");
      else if(typeCoffre == 7) imageCoffre = loadImage("Images/CoffreOrOuvert.png");
    }
  }
  
  PImage returnImageCoffre(){return imageCoffre;}
  byte   returnXCoffre(){return xCoffre;}
  byte   returnYCoffre(){return yCoffre;}
  short  returnChanceApparaitre(){return chanceApparaitre;}
  byte   returnTypeCoffre(){return typeCoffre;}
}