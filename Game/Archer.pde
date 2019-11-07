/*
 * Crée par Christian CHAUX le 22/05/2016
 * Dernières modifications le 10/06/2016
 */

class Archer extends Personnage
{
  Archer(String nom, short vie, short force, short mana, byte xPerso, byte yPerso, byte equipe, char sexe, byte id)
  {
    super(nom, vie, force, mana, xPerso, yPerso, equipe, sexe, id);
  }
  
  void defClasse()
  {
    classe = 5;
  }
  
  void attaquer()
  {
    try{
      Personnage cible = carteActuelle.caseCarteDevant(xPerso, yPerso, this).returnPersoQuiOccupe();
    
      if(peuxAttaquer(cible))
      {
          short degats = (short)(force+random(10)-5);
          if(degats < 0) degats = 0;
          
          cible.diminuerVie((short)(degats), this); // random: intervalle de dégats
          dernierDegatsInfliges = degats;
          
          monstreTue(cible);
      }
    } catch(Exception e){}
  }
  
  String returnManaVig(){return d.affichageStats("Vigueur");}
  String returnClasse()
  {
    if(sexe == 'F') return d.affichageStats("Archère");
    else return d.affichageStats("Archer");
  }
}