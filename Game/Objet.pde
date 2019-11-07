/*
 * Crée par Christian CHAUX le 20/05/2016
 * Dernières modifications le 21/07/2016
 */
 
class Objet
{
  byte id; // 0: divers ; 1 à 4 potions (vie/mana/vigueur/malus); 5: clé ; 6: chocolat ; 7: amulette ; 8: livre feu ; 9: planches ; 10: bombe ; 11: blessed moonstone ; 12: hell's mushroom ; 13: empty flask
           // 14: water flask, 15: holy water, 16: framboises, 17: Orphanee, 18: Corne de Dragon, 19: Poudre de corne de dragon
  byte type;
  short nombreEmpile; // Nombre qui sont superposé
  PImage image;
  Objet(byte id, short nombreEmpile)
  {
    this.id = id;
    this.nombreEmpile = nombreEmpile;
    gestionImages();
  }
  
  String description()
  {
    if(id == 1) return       "Small life potion,\nYou can drink it to recover some\nhealth points.\nEven if it's smell like raspberry,\ndrinking too much of them can give\nyou stomach ache.";
    else if(id == 2) return  "Small mana potion,\nYou can drnik it to recover some\nmana.\nEven if it's smell like blueberry,\ndrinking too much of them can give\nyou stomach ache.";
    else if(id == 3) return  "Small vigor potion,\nYou can drnik it to recover some\nvigor.\nEven if it's smell like gooseberry,\ndrinking too much of them can give\nyou stomach ache.";
    else if(id == 4) return  "Small chance potion,\nIt's called like this because well...\nYou can loose health point,\nor winning some...\nYou shouldn't drink them,\nexcept if you don't have the choice...";
    else if(id == 5) return  "Dungeon's key,\nIt's a small fragile key,\nyou can use it to open most of the\ndoors of the dungeon.\nIt's very fragile, so there is high\nchance that it'll break after usage\n" +
                             "It's make like that so\nyou can't open all the doors\nyou want with only one key.";
    else if(id == 6) return  "Milk chocolate,\nTaste good, you can eat one\nif you're in need of... sucar...";
    else if(id == 7) return  "Amulet,\nImpregnate with a mystic power.\nSaria said that she absolutly need\nthis item\nYou should ask her for\nmore informations about it.";
    else if(id == 8) return  "Old book,\nA really old book,\nit seem to speak of the fire magic,\nbut it's a little too hard for\nyou to understand...\nYou should give it to someone who have\n" +
                             "a better knowledge about it.";
    else if(id == 9) return  "Board,\nIf a hole prevent you to move forward,\nyou can place a board on it,\nthey should be solid enought for you\nand your team to walk on it.";
    else if(id == 10) return "Bomb,\nThere is a wall in front of you,\ndon't worry, you still can explode it.\nTry to don't stay to close of it\nwhen it'll explode or you can\nheavily hurt yourself.";
    else if(id == 11) return "Blessed moonstone,\nThere is a legend who say that part of the moon fall in the earth.\nThis moonstone was blessed by a powerful spell who would avoid you to be cursed.";
    else if(id == 12) return "Hell's mushroom,\nThese mushroom are called like that because they only can grow up next to very hot point, like lava.";
    else if(id == 13) return "Empty flask\nThis flask is empty, you can use it to store liquids.";
    else if(id == 14) return "Water flask\nThere is water in this flask.\nWell, nothing else particular, just normal water...";
    else if(id == 15) return "Holy water flask\nHoly water can only be blessed by a archpriest, it's say that it can repulse the evil.";
    else if(id == 16) return "Raspberrie\nThey seam tasty.";
    else if(id == 17) return "Orphannee\nA beautiful flower, only findable at high altitude.\nEven if they are hard to find, they are really useful for potions concoction.";
    else if(id == 18) return "Dragon's horn\nDragon's horn are really hard too find, especially because they are hard to kill\nYou would be able to have a good price of it";
    else if(id == 19) return "Dragon's horn powder\nDragon's horn are really robust.\nThe fact that you made a power of it is in fact, pretty impressive...";
    
    else return "Description not available";
  }
  
  String nom()
  {
    if(id == 1) return       "Small life potion";
    else if(id == 2) return  "Small mana potion";
    else if(id == 3) return  "Small vigor potion";
    else if(id == 4) return  "Small chance potion";
    else if(id == 5) return  "Dungeon's key";
    else if(id == 6) return  "Milk chocolate";
    else if(id == 7) return  "Amulet";
    else if(id == 8) return  "Old book";
    else if(id == 9) return  "Board";
    else if(id == 10) return "Bomb";
    else if(id == 11) return "Blessed moonstone";
    else if(id == 12) return "Hell's mushroom";
    else if(id == 13) return "Empty flask";
    else if(id == 14) return "Water flask";
    else if(id == 15) return "Holy water flask";
    else if(id == 16) return "Raspberrie";
    else if(id == 17) return "Orphannee";
    else if(id == 18) return "Dragon's horn";
    else if(id == 19) return "Dragon's horn powder";
    
    else return "Name unknowed";
  }
  
  void gestionImages()
  {
    if(id == 5)       this.image = iCle;
    else if(id == 6)  this.image = iChocolat;
    else if(id == 7)  this.image = iAmulette;
    else if(id == 8)  this.image = iLivre;
    else if(id == 9)  this.image = iPlanche;
    else if(id == 10) this.image = iBombe;
    else this.image = iObjetSol;
  }
  
  void action()
  {
    joueur.genererAffDgts(300001);
  }
  
  void reduireNbEmpile(){nombreEmpile--;}
  void augmenterNbEmpile(){nombreEmpile++;}
  PImage returnImage(){return image;}
  short returnNbEmpile(){return nombreEmpile;}
  byte returnID(){return id;}
}