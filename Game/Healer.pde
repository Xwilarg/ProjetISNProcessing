/*
 * Crée par Christian CHAUX le 09/04/2016
 * Dernières modifications le 19/06/2016
 */

class Healer extends Personnage
{
  Healer(String nom, short vie, short force, short mana, byte xPerso, byte yPerso, byte equipe, char sexe, byte id)
  {
    super(nom, vie, force, mana, xPerso, yPerso, equipe, sexe, id);
    utiliseMana = true;
    attUn = icHeal;
    attDeux = icAttaquer;
    attTrois = icBuffAtt;
    /*attQuatre = icBouclier;*/
  }
  
  void defClasse()
  {
    classe = 3;
  }
  
  void attaquer()
  {
    try{
      Personnage cible = carteActuelle.caseCarteDevant(xPerso, yPerso, this).returnPersoQuiOccupe();
    
      if(peuxSoigner(cible) && compAttUn.estFini())
      {
        if(mana >= 10)
        {
          mana -= 10;
          short degats = 0;
          compAttUn.initialiserMili((short)250);
          if(id == 3 || id == 1)
            degats = (short)(-random(20)+5);
          else
            degats = (short)(-random(50)+15);
          if(degats > 0) degats = 0; 
          cible.diminuerVie((short)(degats), this); // random: intervalle de dégats
          dernierDegatsInfliges = degats;
          
          monstreTue(cible);
          xp += 3;
          if(xp >= xpMax) lvlUp();
        }
        else
          genererAffDgts(99999); // Out of mana
      }
    } catch(Exception e){}
  }
  
  void attaquerSec()
  {
    try{
      Personnage cible = carteActuelle.caseCarteDevant(xPerso, yPerso, this).returnPersoQuiOccupe();
    
      if(peuxAttaquer(cible) && compAttDeux.estFini())
      {
       if(mana >= 5)
       {
         compAttDeux.initialiser((short)1);
         mana -= 5;
         short degats;
         degats = (short)(random(5)+force/10);
         if(degats < 0) degats = 0;
          
         cible.diminuerVie((short)(degats), this); // random: intervalle de dégats
         dernierDegatsInfliges = degats;
          
         monstreTue(cible);
      }
      else
        genererAffDgts(99999); // Out of mana
      }
    } catch(Exception e){}
  }
  
  void attaquerTer() // Systeme de boost de force à revoir, augmenter la force temporairement au lieu de gérer attaques par attaques
  {
    try{
      Personnage cible = carteActuelle.caseCarteDevant(xPerso, yPerso, this).returnPersoQuiOccupe();
    
      if(peuxSoigner(cible) && compAttTrois.estFini())
      {
        if(mana >= 50)
        {
          mana-=50;
          cible.boosterForce();
          compAttTrois.initialiser((short)40);
        }
      }
    } catch(Exception e){}
  }
  
  void attaquerLast()
  {}
  
  String returnManaVig(){return "Mana";}
  String returnClasse()
  {
    if(sexe == 'F') return d.affichageStats("Soigneuse");
    else return d.affichageStats("Soigneur");
  }
}