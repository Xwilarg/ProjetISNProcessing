/*
 * Crée par Christian CHAUX en début 2016
 * Dernières modifications le 04/07/2016
 */

class Guerrier extends Personnage
{
  Guerrier(String nom, short vie, short force, short mana, byte xPerso, byte yPerso, byte equipe, char sexe, byte id)
  {
    super(nom, vie, force, mana, xPerso, yPerso, equipe, sexe, id);
    attUn = icAttaquer;
    attDeux = icKick;
    attTrois = icBuffAtt;
    attQuatre = icBouclier;
  }
  
  void defClasse()
  {
    classe = 1;
  }
  
  void verifEvent()
  {
    if(boostDegats > 1 && compAttTrois.progression() < 50/2)
    {
      boostDegats = 1;
    }
    if(utiliseBouclier && compAttTrois.progression() < 2*(50/3))
      utiliseBouclier = false;
  }
  
  void attaquer()
  {
    try{
      Personnage cible = carteActuelle.caseCarteDevant(xPerso, yPerso, this).returnPersoQuiOccupe();
    
      if(peuxAttaquer(cible) && compAttUn.estFini())
      {
       if(mana >= 5)
       {
         compAttUn.initialiserMili((short)250);
         mana -= 5;
         short degats;
         degats = (short)(force+random(10*boostDegats)-5);
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
  
  void attaquerSec()
  {
    try{
      Personnage cible = carteActuelle.caseCarteDevant(xPerso, yPerso, this).returnPersoQuiOccupe();
    
      if(peuxAttaquer(cible) && compAttDeux.estFini())
      {
         if(mana >= 15)
         {
           compAttDeux.initialiser((short)5);
           mana -= 15;
           short degats;
           degats = (short)(force-random(5*boostDegats, 10*boostDegats));
           if(degats < 0) degats = 0;
            
           cible.diminuerVie((short)(degats), this); // random: intervalle de dégats
           cible.stunPerso();
           
           if(!cible.reculer(this))
           {
             degats = (short)(force-random(5*boostDegats, 10*boostDegats));
             if(degats < 0) degats = 0;
             cible.diminuerVie((short)(degats), this); // random: intervalle de dégats
           }
           
           dernierDegatsInfliges = degats;
           
           if(cible == joueur) dernierQuiAttaqueJoueur = this;
            
           monstreTue(cible);
           if(cible == saria)
           {
             ennemis.remove(saria);
            saria         = new Healer  ("Saria",  (short)50,  (short)3,   (short)200, (byte)35, (byte)17, (byte)1, 'F', (byte)3);
            equipe.add(saria);
            saria.defEmplacementPerso((byte)(joueur.returnXPerso()+1), (byte)(joueur.returnYPerso()+1));
            saria.changerEtatDansEquipe();
           }
        }
        else
          genererAffDgts(99999); // Out of mana
      }
    } catch(Exception e){}
  }
  
  void attaquerTer()
  {
    if(peuxAttaquerSoisMeme() && compAttTrois.estFini())
    {
      if(mana >= 70)
      {
        mana-=70;
        boostDegats = 2; // multiplicateur
        compAttTrois.initialiser((short)30);
      }
    }
  }
  
  void attaquerLast()
  {
    if(peuxAttaquerSoisMeme() && compAttQuatre.estFini())
    {
      if(mana >= 10)
      {
        mana -= 10;
        utiliseBouclier = true;
        compAttQuatre.initialiser((short)20);
      }
    }
  }
  
  String returnManaVig(){return d.affichageStats("Vigueur");}
  String returnClasse()
  {
    if(sexe == 'F') return d.affichageStats("Guerrière");
    else return d.affichageStats("Guerrier");
  }
}