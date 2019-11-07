/*
 * Crée par Christian CHAUX le 09/04/2016
 * Dernières modifications le 14/06/2016
 */

class Mage extends Personnage
{
  Mage(String nom, short vie, short force, short mana, byte xPerso, byte yPerso, byte equipe, char sexe, byte id)
  {
    super(nom, vie, force, mana, xPerso, yPerso, equipe, sexe, id);
    utiliseMana = true;
  }
  
  void defClasse()
  {
    classe = 2;
  }
  
  void attaquer()
  {
    try{
      Personnage cible = carteActuelle.caseCarteDevant(xPerso, yPerso, this).returnPersoQuiOccupe();
    
      if(peuxAttaquer(cible))
      {
        if(mana >= 10)
        {
          mana -= 10;
          short degats = (short)(random(20)-5);
          if(degats < 0) degats = 0;
        
          cible.diminuerVie((short)(degats), this); // random: intervalle de dégats
          dernierDegatsInfliges = degats;
          
          monstreTue(cible);
        }
        else
          cible.diminuerVie(99999, this); // Out of mana
      }
    } catch(Exception e){}
  }
  
  void restaure()
  {
    //if(mana < manaMax) mana++;
  }
  
  String returnManaVig(){return "Mana";}
  String returnClasse(){return d.affichageStats("Mage");}
}