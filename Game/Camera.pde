/*
 * Crée par Christian CHAUX le 12/05/2016
 * Dernières modifications le 16/05/2016
 */

class Camera // Pour l'instant peu utile en tant qu'objet, me permettra de gérer plus facilement le multijoueur local plus tard
{
  byte tailleX, tailleY;
  byte centreX, centreY;
  byte pointXGauche, pointYGauche; // Coordonnées du point haut gauche, pour savoir de où la caméra part. (voir affichage() dans Carte.pde)
  Personnage persoASuivre;
  final byte caseAvDep = 5; // Nombre de cases entre le perso et le bord avant le déplacement de la caméra.
  Camera(byte tailleX, byte tailleY, Personnage persoASuivre)
  {
    this.tailleX = tailleX;
    this.tailleY = tailleY;
    this.persoASuivre = persoASuivre;
    placementCamera();
    //Carte mapAffichage = new Carte(null); <--- Ne marche pas... Pourquoi ?
  }
  
  void siCameraDoitDeplacer()
  {
    try{
      carteActuelle.valeurCase(centreX, (byte)(pointYGauche + tailleY-1)); // Si on arrive pas a récupérer cette valeur, ca veut dire qu'on est en dehors de la map et qu'on doit bouger la caméra.
    } catch(ArrayIndexOutOfBoundsException ofbe) {
      deplacementCamera((byte)0);
    }
    try{
      carteActuelle.valeurCase(centreX, (byte)pointYGauche); // Si on arrive pas a récupérer cette valeur, ca veut dire qu'on est en dehors de la map et qu'on doit bouger la caméra.
    } catch(ArrayIndexOutOfBoundsException ofbe) {
      deplacementCamera((byte)1);
    }
    try{
      carteActuelle.valeurCase((byte)(pointXGauche + tailleX-1), centreY); // Si on arrive pas a récupérer cette valeur, ca veut dire qu'on est en dehors de la map et qu'on doit bouger la caméra.
    } catch(ArrayIndexOutOfBoundsException ofbe) {
      deplacementCamera((byte)2);
    }
    try{
      carteActuelle.valeurCase((byte)(pointXGauche), centreY); // Si on arrive pas a récupérer cette valeur, ca veut dire qu'on est en dehors de la map et qu'on doit bouger la caméra.
    } catch(ArrayIndexOutOfBoundsException ofbe) {
      deplacementCamera((byte)3);
    }
    
    if(persoASuivre.returnYPerso() <= pointYGauche+caseAvDep)
      deplacementCamera((byte)0);
    if(persoASuivre.returnYPerso() >= pointYGauche+tailleY-caseAvDep)
      deplacementCamera((byte)1);
    if(persoASuivre.returnXPerso() <= pointXGauche+caseAvDep)
      deplacementCamera((byte)2);
    if(persoASuivre.returnXPerso() >= pointXGauche+tailleX-caseAvDep)
      deplacementCamera((byte)3);
  }
  
  void deplacementCamera(byte direction) //haut, bas, gauche, droite ; 0, 1, 2, 3
  {
    if(direction == 0 && pointYGauche > 0)
    {
      pointYGauche--;
    }
    else if(direction == 1 && pointYGauche < carteActuelle.returnNbLignes()-tailleY)
    {
      pointYGauche++;
    }
    else if(direction == 2 && pointXGauche > 0)
    {
      pointXGauche--;
    }
    else if(direction == 3 && pointXGauche < carteActuelle.returnNbColonnes()-tailleX)
    {
      pointXGauche++;
    }
  }
  
  void placementCamera()
  {
    pointXGauche = (byte)(persoASuivre.returnXPerso()-tailleX/2);
    pointYGauche = (byte)(persoASuivre.returnYPerso()-tailleY/2);
    centreX      = (byte)(pointXGauche+(tailleX/2)+1);
    centreY      = (byte)(pointYGauche+(tailleY/2)+1);
  }
  
  byte returnTailleX(){return tailleX;}
  byte returnTailleY(){return tailleY;}
  byte returnPointXGauche(){return pointXGauche;}
  byte returnPointYGauche(){return pointYGauche;}
}