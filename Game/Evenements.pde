/*
 * Crée par Christian CHAUX le 27/03/2016
 * Dernières modifications le 10/06/2016
 */
 
byte tutoEvent = 0;

void activationEvent() // A activer en début de niveau
{
  transparanceAffInfosEvents = 255;
  resetEvent();
  byte chanceEvent = (byte)(random(8)+1);
  println("Event ayant été généré: " + chanceEvent);
  //chanceEvent = 5;
  switch(chanceEvent)
  {
    case 1 :
      dansLeNoir = true;
      break;
    
    case 2 :
      dansLeFroid = true;
      break;
    
    case 3 :
      if(saria.returnDansEquipe() && !joueur.returnInventaire().rechercherObjet((byte)7)) // Amulette
      {
        sariaInsane = true;
        equipe.remove(saria);
         // Nom, vie, force, mana, coordonnées x, y, équipe, sexe et id.
        saria = new Guerrier("Saria",  (short)200,  (short)5, (short)500, (byte)35, (byte)16, (byte)2, 'F', (byte)3);
        ennemis.add(saria);
        saria.defEmplacementPerso((byte)(joueur.returnXPerso()+1), (byte)(joueur.returnYPerso()+1));
      }
      break;
    
    case 4 :
      for(byte i = 0 ; i < equipe.size() ; i++)
      {
        if(equipe.get(i).returnUtiliseMana()) // A gérer dans Personnage pour la regen, les montés de niveau et les potions.
        {
          equipe.get(i).resetMana();
          pasDeMana = true;
        }
      }
      break;
    
    case 5:
      if(niveauDonjonAlea >= 3)
        seulementBerserker = true;
      break;
  }
}

void resetEvent()
{
  dansLeNoir         = false;
  dansLeFroid        = false;
  sariaInsane        = false;
  pasDeMana          = false;
  seulementBerserker = false;
}

void verifEmplacementEvent()
{
  if(dansLeFroid)
  {
    if(nbToursDraw > 50 && nbToursDraw %12.5 == 0
    || nbToursDraw > 40 && nbToursDraw < 50 && nbToursDraw %10 == 0
    || nbToursDraw > 20 && nbToursDraw < 40  && nbToursDraw %5 == 0
    || nbToursDraw > 10 && nbToursDraw < 20 && nbToursDraw %2.5 == 0
    || nbToursDraw < 10 && nbToursDraw == 1 || nbToursDraw < 10 && nbToursDraw == 2 || nbToursDraw < 10 && nbToursDraw == 2 || nbToursDraw < 10 && nbToursDraw == 2) //4 actions pour les IA par tours de draw.
    {
      byte chanceDiminuerVie = (byte)(random(3)+1);
      if(chanceDiminuerVie == 1)
      {
        for(int i = 0 ; i < equipe.size() ; i++)
        {
          if(equipe.get(i) != elenia) // En tant qu'elfe, Elenia à une meilleur resistance au froid.
          equipe.get(i).diminuerVie((byte)1, null);
        }
      }
    }
  }
  if(carteActuelle.valeurCase(joueur.returnXPerso(), joueur.returnYPerso()) == 'S' && modeDeJeu == 2) // Lorsque le Perso atteint la sortie en mode Sans Fin
  {
    ecran = 1;
    niveauDonjonAlea++;
  }
  if(carteActuelle.valeurCase(joueur.returnXPerso(), joueur.returnYPerso()) == 'D')
  {
    dial.gameOver("VIE_NULL", "TOMBE_TROU");
  }
 if(modeDeJeu == 0)
  {
     if(joueur.returnXPerso() == 6 && joueur.returnYPerso() == 16 && carteActuelle.valeurCase((byte)6, (byte)16) == 'S')
     {
        ecran = 1;
        modeDeJeu = 2;
        niveauDonjonAlea = 1;
        if(equipe.size() > 1) seul = false;
     }
     else if(joueur.returnXPerso() == 8 && joueur.returnYPerso() == 16 && carteActuelle.valeurCase((byte)8, (byte)16) == 'S')
     {
        niveauHistoire = 1;
        modeDeJeu = 1;
        ecran = 1;
     }
     else if(joueur.returnXPerso() == 10 && joueur.returnYPerso() == 16 && carteActuelle.valeurCase((byte)10, (byte)16) == 'S')
     {
        selectCarteEscTrois = true;
        modeDeJeu = 3;
        ecran = -1;
        choixCarte();
     }
     else if(joueur.returnXPerso() == 14 && joueur.returnYPerso() == 16 && carteActuelle.valeurCase((byte)10, (byte)16) == 'S')
     {
        modeDeJeu = 4;
        ecran = 1;
     }
  }
  if(joueur.returnXPerso() == 36 || joueur.returnYPerso() == 18 || joueur.returnXPerso() == 0 || joueur.returnYPerso() == 0)
  {
     dial.afficheBoiteErreur("You aren't suppose to be here.");
  }
  if(modeDeJeu == 1)
  {
    if(carteActuelle.valeurCase(joueur.returnXPerso(), joueur.returnYPerso()) == 'X')
    {
      for(byte i = 0 ; i < carteActuelle.returnNbColonnes() ; i++){
        for(byte y = 0 ; y < carteActuelle.returnNbLignes() ; y++){
          if(carteActuelle.valeurCase(i, y) == '1')
            carteActuelle.changerValeurCase(i, y, '.');
        }
      }
      tutoEvent = 1;
    }
      
    if(carteActuelle.returnNbEnnemis() <= 0 && tutoEvent == 1)
    {
      for(byte i = 0 ; i < carteActuelle.returnNbColonnes() ; i++){
        for(byte y = 0 ; y < carteActuelle.returnNbLignes() ; y++){
          if(carteActuelle.valeurCase(i, y) == '2')
            carteActuelle.changerValeurCase(i, y, '.');
        }
      }
      tutoEvent = 2;
    }
    
    if(carteActuelle.valeurCase(joueur.returnXPerso(), joueur.returnYPerso()) == 'S' && joueur.returnXPerso() == 1 && joueur.returnYPerso() == 13)
    {
      ecran = 1;
      tutoEvent = 3;
    }
    
     if(carteActuelle.valeurCase(joueur.returnXPerso(), joueur.returnYPerso()) == 'S' && joueur.returnXPerso() == 33 && joueur.returnYPerso() == 3)
    {
      ecran = 1;
      modeDeJeu = 0;
      joueur.defEmplacementPerso((byte)18, (byte)16);
      tutoEvent = 0;
    }
  }
  
 /* if(modeDeJeu == 2)
  {
    short changeDialogEvent = (short)(random(1)+1);
    if(changeDialogEvent == 1)
    {
      byte lequel;
      if(equipe.size() > 1)
      {
        lequel = (byte)(random(equipe.size()-1)+1);
        dial.demCompteur(d.dialogueAleaNiveau(equipe.get(lequel)), joueur);
      }
    }
    if(dial.returnDialAff())
      dial.parlerPerso();
  }*/
  
  for(int i = 0 ; i < equipe.size() ; i++)
  {
    equipe.get(i).verifEvent();
  }
  
  for(int i = 0 ; i < bombesPose.size() ; i++)
  {
    if(bombesPose.get(i).aExplose())
      bombesPose.get(i).exploser();
    else
      bombesPose.get(i).affichageCompteARebour();
  }
}

void actionIA()
{
  for(byte i = 0 ; i < ennemis.size() ; i++)
  {
    if(ennemis.get(i).returnVie() > 0)
      ennemis.get(i).botFaireAction();
  }
  for(byte i = 0 ; i < equipe.size() ; i++)
  {
    try
    {
      if(equipe.get(i).returnVie() > 0)
        equipe.get(i).botFaireAction();
    } catch (Exception e) {}
  }
}