/*
 * Crée par Christian CHAUX le 19/06/2016
 * Dernières modifications le 18/07/2016
 */
 
class Quete
{
  byte id;
  String nom, description;
  byte progression;
  Quete(byte id)
  {
    this.id = id;
    progression = 0;
    defAttributs();
  }
  
  void defAttributs()
  {
    if(id == 0)
    {
      nom = "A new chest for Mimi";
      if(progression == 0)
        description = "First of all, Mimi need clothes.\nFind her something she can wear, but not something too heavy.";
      else if(progression == 1)
        description = "Now that Mimi is dressed, you need to find her a better chest.\nA silver chest should be enough,\nbut you can find her a better one if you want.\n" +
                      "Obviously, Mimi need to stay alive.";
    }
    else if(id == 1)
    {
      nom = "Cure your little sister";
      if (progression == 0)
      {
        description = "To cure your little sister, you'll need to make a potion with the following ingredients :\n";
        description += "Blessed moonstone: ";
        if(joueur.returnInventaire().rechercherObjet((byte)9)) description += "Done.\n";
        else description += "Not found yet...\n";
        
        description += "Hell's mushroom: ";
        if(joueur.returnInventaire().rechercherObjet((byte)12)) description += "Done.\n";
        else description += "Not found yet...\n";
        
        description += "Empty flask: ";
        if(joueur.returnInventaire().rechercherObjet((byte)13)) description += "Done.\n";
        else description += "Not found yet...\n";
        
        description += "Water: ";
        if(joueur.returnInventaire().rechercherObjet((byte)14)) description += "Done.\n";
        else description += "Not found yet...\n";
        
        description += "Holy water: ";
        if(joueur.returnInventaire().rechercherObjet((byte)15)) description += "Done.\n";
        else description += "Not found yet...\n";
        
        description += "Raspberrie: ";
        if(joueur.returnInventaire().rechercherObjet((byte)16)) description += "Done.\n";
        else description += "Not found yet...\n";
        
        description += "Orphanee: ";
        if(joueur.returnInventaire().rechercherObjet((byte)17)) description += "Done.\n";
        else description += "Not found yet...\n";
        
        description += "Dragon's horn powder: ";
        if(joueur.returnInventaire().rechercherObjet((byte)19)) description += "Done.\n";
        else description += "Not found yet...\n";
      }
      else if (progression == 1)
      {
        description = "You have the potion !\n" +
                      "Now find a way to go out of here.";
      }
    }
    else if (id == 2)
    {
      nom = "Thrug's quest";
      if (progression == 0)
      {
        description = "Thrug want to reach the end of this dungeon.\n" +
                      "You don't know if it's possible so well... Good luck.\n" +
                      "Level completed: " + niveauDonjonAlea + "/Unknow";
      }
    }
    else if (id == 3)
    {
      nom = "Saria's quest";
      if (progression == 0)
      {
        description = "Saria search a medaillon,\n" +
                      "she didn't give you any additionnal informations about it.";
      }
    }
    else if (id == 4)
    {
      nom = "Gandur's quest";
      if (progression == 0)
      {
        description = "Gandur search a book about the fondations of the fire's magic,\n" +
                      "The only thing you know that it's findable in the dungeon.";
      }
    }
    else if (id == 5)
    {
      nom = "Kya's quest";
      if (progression == 0)
      {
        description = "Kya didn't give you any informations about this quest...";
      }
    }
    else if (id == 6)
    {
      nom = "Elenia's quest";
      if (progression == 0)
      {
        description = "Elenia didn't give you any informations about this quest...";
      }
    }
  }
  
  void ajouterQuete(byte id)
  {
    for(int i = 0 ; i < quetes.length ; i++)
    {
      if(quetes[i] == null)
      {
        quetes[i] = new Quete(id);
        break;
      }
    }
  }
  
  void ajouterQuetePerso(Personnage perso)
  {
    if(perso == thrug) ajouterQuete((byte)2);
    else if(perso == saria) ajouterQuete((byte)3);
    else if(perso == gandur) ajouterQuete((byte)4);
    else if(perso == kya) ajouterQuete((byte)5);
    else if(perso == elenia) ajouterQuete((byte)6);
  }
  
  String rNom(){return nom;}
  String rDescription(){return description;}
}