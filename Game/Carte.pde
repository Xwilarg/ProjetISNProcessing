/*
 * Crée par Christian CHAUX en début 2016
 * Dernières modifications le 23/07/2016
 */

class Carte
{
  String nomCarte;
  LectureTxt lectTxt;
  
  Carte(String nomCarte)
  {
    this.nomCarte = nomCarte;
    
    for(byte i = 0 ; i < nbColonnes ; i++)
      for(byte y = 0 ; y < nbLignes ; y++)
        map[i][y] = new Case('M', i, y);
        
     lectTxt = new LectureTxt(nomCarte);
  }
  
  void affichage() // Affichage de la map
  {
    /*if(carteActuelle == lvlAlea)
      debug.ecrireCarteFichier();*/
      
    if(dansLeFroid) tint(0, 153, 204, 50);
      
    byte iModif, yModif;
    for(byte i = 0 ; i < camJoueur.returnTailleX() ; i++){
      for(byte y = 0 ; y < camJoueur.returnTailleY() ; y++){
        try
        {
          iModif = (byte)(i + camJoueur.returnPointXGauche());
          yModif = (byte)(y + camJoueur.returnPointYGauche());
          
          if(carteActuelle.valeurCase(iModif, yModif) == 'C')
          {
            coffres.add(new Coffre(iModif, yModif, (byte)1));
            changerValeurCase(iModif, yModif, '.');
            nbTresors++;
          }
          if(carteActuelle.valeurCase(iModif, yModif) == '5')
          {
            if(iModif == 24 && yModif == 1 && carteActuelle == menuP) coffres.add(new Coffre(iModif, yModif, (byte)7));
            else coffres.add(new Coffre(iModif, yModif, (byte)6));
            changerValeurCase(iModif, yModif, '.');
            nbTresors++;
          }
          if(carteActuelle.valeurCase(iModif, yModif) == 'D')
          {
            pieges.add(new Piege(iModif, yModif, (byte)0));
            changerValeurCase(iModif, yModif, '.');
          }
          if(carteActuelle.valeurCase(iModif, yModif) == 'K')
          {
            if(carteActuelle == intro)
            {
              ennemis.add(new Personnage("Poule " + nbEnnemis, (short)20, (short)1, (short)100, iModif, yModif, (byte)2, 'F', (byte)14));
              changerValeurCase(iModif, yModif, ',');
            }
            else
            {
              // Nom, vie, force, mana, coordonnées x, y, équipe, sexe et id.
              ennemis.add(new Personnage("Ennemi " + nbEnnemis, (short)200, (short)5, (short)300, iModif, yModif, (byte)2, 'X', (byte)9));
              changerValeurCase(iModif, yModif, '.');
            }
            nbEnnemis++;
          }
          if(carteActuelle.valeurCase(iModif, yModif) == '6')
          {
            ennemis.add(new Personnage("Ennemi " + nbEnnemis, (short)250, (short)10, (short)300, iModif, yModif, (byte)2, 'X', (byte)6));
            changerValeurCase(iModif, yModif, '.');
            nbEnnemis++;
          }
          else if(carteActuelle.valeurCase(iModif, yModif) == '7')
          {
            ennemis.add(new Personnage("Slime " + nbEnnemis, (short)150, (short)5, (short)300, iModif, yModif, (byte)2, 'X', (byte)9));
            changerValeurCase(iModif, yModif, '.');
            nbEnnemis++;
          }
          else if(carteActuelle.valeurCase(iModif, yModif) == '8')
          {
            ennemis.add(new Guerrier("Berserker " + nbEnnemis, (short)1000, (short)20, (short)300, iModif, yModif, (byte)2, 'X', (byte)12));
            changerValeurCase(iModif, yModif, '.');
            nbEnnemis++;
          }
          else if(carteActuelle.valeurCase(iModif, yModif) == '9')
          {
            ennemis.add(new Healer("Prêtre maléfique " + nbEnnemis, (short)100, (short)4, (short)300, iModif, yModif, (byte)2, 'X', (byte)13));
            changerValeurCase(iModif, yModif, '.');
            nbEnnemis++;
          }
          if(mapBrouillard[iModif][yModif] == 0 && valeurCase(iModif, yModif) != '@' || modeDeJeu == 2 && niveauDonjonAlea%5 == 0 && valeurCase(iModif, yModif) != '@') // Si la case est visible par le joueur
          { 
            /*if(carteActuelle == intro)
              afficherImage(iHerbe, i*tailleCase, y*tailleCase); // Herbe
            else*/
              afficherCasesCartes(iSolBois, i*tailleCase, y*tailleCase); // Sol normal
              
            /*if(nomCarte.equals("Boss1") && valeurCase(iModif, yModif) == 'N') afficherImage(iPillier, i*tailleCase, y*tailleCase);// Murs cassable <-- Ne marche pas, raison inconnu
            else */if(valeurCase(iModif, yModif) == 'N' || valeurCase(iModif, yModif) == '1' || valeurCase(iModif, yModif) == '2') afficherCasesCartes(iPierreCassable, i*tailleCase, y*tailleCase);// Murs cassable
            else if(valeurCase(iModif, yModif) == '.' || valeurCase(iModif, yModif) == 'X')
            {
              if(modeDeJeu != 4)
                afficherCasesCartes(iSolBois, i*tailleCase, y*tailleCase); // Sol normal (et events)
              else
                afficherCasesCartes(iHerbe, i*tailleCase, y*tailleCase); // Sol normal
            }
            else if(valeurCase(iModif, yModif) == 'P') // Porte
            {
              if(caseCarte(iModif, (byte)(yModif-1)).returnEstTraversable() == false && caseCarte(iModif, (byte)(yModif-1)).rNonOccupe()) afficherCasesCartes(iPorteV, i*tailleCase, y*tailleCase);
              else afficherCasesCartes(iPorteH, i*tailleCase, y*tailleCase);
            }
            else if(valeurCase(iModif, yModif) == 'L') // Porte verouillee
            {
              if(caseCarte(iModif, (byte)(yModif-1)).returnEstTraversable() == false && caseCarte(iModif, (byte)(yModif-1)).rNonOccupe()) afficherCasesCartes(iPorteV, i*tailleCase, y*tailleCase);
              else afficherCasesCartes(iPorteH, i*tailleCase, y*tailleCase);
            }
            else if(valeurCase(iModif, yModif) == 'R') afficherCasesCartes(iPancarte, i*tailleCase, y*tailleCase); // Pancarte
            else if(valeurCase(iModif, yModif) == 'E') afficherCasesCartes(iEscalierH, i*tailleCase, y*tailleCase); // Entree
            else if(valeurCase(iModif, yModif) == 'S') afficherCasesCartes(iEscalierB, i*tailleCase, y*tailleCase); // Sortie
            else if(valeurCase(iModif, yModif) == 'Z') afficherCasesCartes(iPassageSecret, i*tailleCase, y*tailleCase); // Passage secret
            else if(valeurCase(iModif, yModif) == '*') afficherCasesCartes(iObjetSol, i*tailleCase, y*tailleCase); // Etoile
            else if(valeurCase(iModif, yModif) == '-' && carteActuelle == intro) afficherCasesCartes(iBarriere, i*tailleCase, y*tailleCase); // Barrière
            else if(valeurCase(iModif, yModif) == '-' && carteActuelle != intro) afficherCasesCartes(iEau, i*tailleCase, y*tailleCase); // Eau
            else if(valeurCase(iModif, yModif) == '+') afficherCasesCartes(iSable, i*tailleCase, y*tailleCase); // Sable
            else if(valeurCase(iModif, yModif) == ',') afficherCasesCartes(iHerbe, i*tailleCase, y*tailleCase); // Herbe
            else afficherCasesCartes(iPierreIncassable, i*tailleCase, y*tailleCase); // Murs incassables 'M'
            
            if(caseCarte(iModif, yModif).rCoffre()) afficherCasesCartes(caseCarte(iModif, yModif).returnCoffreQuiOccupe().returnImageCoffre(), i*tailleCase, y*tailleCase); // Coffre
            
            if(caseCarte(iModif, yModif).rPiege())
              afficherCasesCartes(caseCarte(iModif, yModif).piegeQuiOccupe.returnImage(), i*tailleCase, y*tailleCase); // Pièges
              
            if(caseCarte(iModif, yModif).rBombe())
              afficherCasesCartes(caseCarte(iModif, yModif).bombeQuiOccupe.returnImage(), i*tailleCase, y*tailleCase); // Bombes
              
            if(caseCarte(iModif, yModif).rProjectile())
              afficherCasesCartes(iFleche, i*tailleCase, y*tailleCase); // Projectiles
              
            if(caseCarte(iModif, yModif).rMort()) // Personnages
            {
              afficherImage(iSang, i*tailleCase, y*tailleCase);
              //afficherImage(persoMort.get(i).returnImagePerso(), persoMort.get(i).returnXPerso()*tailleCase, persoMort.get(i).returnYPerso()*tailleCase);
            }
              
            if(caseCarte(iModif, yModif).rPerso()) // Personnages
            {
              if(caseCarte(iModif, yModif).returnPersoQuiOccupe().estStun()) afficherCasesCartes(efStun, i*tailleCase, y*tailleCase);
              if(caseCarte(iModif, yModif).returnPersoQuiOccupe().rBoostForce() > 1) afficherCasesCartes(efBoostForce, i*tailleCase, y*tailleCase);
              if(caseCarte(iModif, yModif).returnPersoQuiOccupe().rUtiliseBouclier()) afficherCasesCartes(efBouclier, i*tailleCase, y*tailleCase);
              afficherPerso(caseCarte(iModif, yModif).returnPersoQuiOccupe().returnImagePerso(), i*tailleCase, y*tailleCase, caseCarte(iModif, yModif).returnPersoQuiOccupe());
            }
          }
          else
          {
            afficherCasesCartes(iBrouillard, i*tailleCase, y*tailleCase);
          }
        }
        catch(Exception e) // Ne marche pas
        {
          //afficherImage(textureManquante, i*tailleCase, y*tailleCase);
        }
        
        // rect(i*tailleCase, y*tailleCase, tailleCase, tailleCase);
        
        //fill(255);
      }
    }
    tint(255);
  }
  
  void supprimerEnnemis() // Enlève tous les ennemis de la carte.
  {   
    ennemis = null;
    ennemisVisible = null;
    persoMort = null;
    persoNeutre = null;
    coffres = null;
    pieges = null;
    
    ennemis     = new ArrayList <Personnage> ();
    ennemisVisible = new ArrayList <Personnage> ();
    persoMort   = new ArrayList <Personnage> ();
    persoNeutre = new ArrayList <Personnage> (); // Mimic allié
    coffres     = new ArrayList <Coffre> ();
    pieges      = new ArrayList <Piege> ();
    
    println("SUPPRIMER ENNEMIS: " + pieges.size());
      
      
    nbEnnemis = 0;
    nbTresors = 0;
  }
  
  void changerNomFile(String nouvNom)
  {
    lectTxt.changerNomFile(nouvNom);
  }
  
  void lireTxt()
  {
    supprimerEnnemis();
    lectTxt.creationCarte();
    placementJoueurDebutPartie();
    actualiserCarte();
  }
  
  void iniGenAlea()
  {
    avanceGenerationAleatoire = 0;
  }
  
  void remplirBrouillard()
  {
    for(byte i = 0 ; i < nbColonnes ; i++) // Rempli les cases de V, pour éviter les bugs
     {
       for(byte y = 0 ; y < nbLignes ; y++)
       {
         mapBrouillard[i][y] = 1; // Toutes les cases sont rempli de brouillard.
       }
     }
  }
  
  
  void creationAlea() // Creation de la map aléatoirement
  {
    if(avanceGenerationAleatoire == 7) avanceGenerationAleatoire = 0;
    fill(255);
    textSize(30);
    text(d.infoChargementLvlAlea(avanceGenerationAleatoire), menuP.tailleFenX()/2-200, menuP.tailleFenY()/2+100); // Affichage des infos sur le chargement.
    progressionBarreChargementPourcent = (short)(((avanceGenerationAleatoire + 1)*100/6)); // Progression de la barre de chargement selon la génération de la carte.
     
     switch(avanceGenerationAleatoire)
     {
     case 0 :
       for(byte i = 0 ; i < nbColonnes ; i++) // Rempli les cases de V, pour éviter les bugs
       {
         for(byte y = 0 ; y < nbLignes ; y++)
         {
           map[i][y].changeValeur('.');
           mapBrouillard[i][y] = 1; // Toutes les cases sont rempli de brouillard.
         }
       }
       placementMursIncassable();
       placementMursCassable();
       placementEntreesSorties();
       if(dansLeNoir) enleverBrouillardAutour(joueur);
       else placementBrouillard();
       placementPortes();
       break;
       
     case 1 :
       //verifMapCorrect();
       break;
      
     case 2 :
       placementTrou();
       break;
       
     case 3:
       placementTresors();
       break;
       
     case 4 :
       placementEnnemis();
       break;
       
     case 5 :
       //actualiserCarte();
       break;
    	  
     case 6 :
       ecran = 2;
       break;
        
     default :
       dial.afficheBoiteErreur("Erreur, la variable 'avanceGenerationAleatoire' a atteint une valeur non attendu.\nCarte.pde; void creationAlea();, ligne 99.\nValeur variable: " + avanceGenerationAleatoire);
       break;
    }
    avanceGenerationAleatoire++;
	
    //nbSalle = (byte)(nbSalleHor * nbSalleVer);)
    
    //verifCarte();
  }
  
  void placementTrou()
  {
     byte nbTrous = 0;
     byte nbTrousMin = 30;
     byte nbTrousMax = 50;
     byte quelPiege;
     final byte nbTrousAPlace = (byte)(random(nbTrousMin, nbTrousMax));
      while(nbTrous < nbTrousAPlace)
      {
        byte randomI = (byte)(Math.random()*nbColonnes);
        byte randomY = (byte)(Math.random()*nbLignes);
        if(seulementBerserker)
          quelPiege = 1;
        else
          quelPiege = (byte)(random(2)+1);
       if(placementCorrect(randomI, randomY, false))
       {
         if(quelPiege == 1)
           pieges.add(new Piege(randomI, randomY, (byte)0));
         else
           pieges.add(new Piege(randomI, randomY, (byte)1));
         nbTrous++;
       }
       actualiserCarte();
     }
     println("Nb de trous placés: " + nbTrous);
  }
  
  boolean placementCorrect(byte i, byte y, boolean aCotePorte)
  {
    if(!aCotePorte)
    {
      try {
        if(caseCarte((byte)(i-1), y).returnEstOuvrable())
          return false;
      } catch(Exception ex) {}
      try {
        if(caseCarte((byte)(i+1), y).returnEstOuvrable())
          return false;
      } catch(Exception ex) {}
      try {
        if(caseCarte(i, (byte)(y-1)).returnEstOuvrable())
          return false;
      } catch(Exception ex) {}
      try {
        if(caseCarte(i, (byte)(y+1)).returnEstOuvrable())
           return false;
      } catch(Exception ex) {}
      // Pour pas que le trou se mette a coté d'une porte
    }
    
    if(caseCarte(i, y).rCoffre() || caseCarte(i, y).rPiege())
      return false;
    
    if(!caseCarte(i, y).returnEstTraversable()
       || valeurCase(i, y) == 'E' || valeurCase(i, y) == 'S')
       return false;
     
     for(byte w = 0 ; w < nbColonnes ; w++)
     {
       for(byte z = 0 ; z < nbLignes ; z++)
       {
         if(map[w][z].returnValeur() == 'E' || map[w][z].returnValeur() == 'S') // Cherche où est l'entrée
         {
           if(i < w && w-i < 5 || i > w && i-w < 5 || y < z && z-y < 5 || y > z && y-z < 5)
             return false;
         }
       }
     }

    return true;
  }
  
  void placementBrouillard()
  {
    for(byte i = 0 ; i < nbColonnes ; i++)
     {
       for(byte y = 0 ; y < nbLignes ; y++)
       {
         if(map[i][y].returnValeur() == 'E') // Cherche où est l'entrée
         {
           for(byte w = (byte)(i-nbCaseSalle/2-1) ; w < i+nbCaseSalle/2+2 ; w++) // Puis enlève le brouillard sur les cases environnante
           {
             for(byte z = (byte)(y-nbCaseSalle/2-1) ; z < y+nbCaseSalle/2+2 ; z++)
             {
               mapBrouillard[w][z] = 0;
             }
           }
         }
         if(map[i][y].returnValeur() == 'M' && modeDeJeu != 1) // Les murs incassable sont également visible par le joueur
           mapBrouillard[i][y] = 0;
       }       
     }
  }
  
  void enleverBrouillardAutour(Personnage perso)
  {
    for(byte i = 0 ; i < nbColonnes ; i++) // Rempli les cases de V, pour éviter les bugs
     {
       for(byte y = 0 ; y < nbLignes ; y++)
       {
         mapBrouillard[i][y] = 1; // Toutes les cases sont rempli de brouillard.
       }
     }
    for(int i = 0 ; i < 3 ; i++)
    {
      for(int y = 0 ; y < 3 ; y++)
      {
        mapBrouillard[joueur.returnXPerso()-1+i][joueur.returnYPerso()-1+y] = 0;
        if (map[joueur.returnXPerso()-1+i][joueur.returnYPerso()-1+y].rPerso())
        {
          if (map[joueur.returnXPerso()-1+i][joueur.returnYPerso()-1+y].returnPersoQuiOccupe().returnEquipe() != perso.returnEquipe())
            ennemisVisible.add(map[joueur.returnXPerso()-1+i][joueur.returnYPerso()-1+y].returnPersoQuiOccupe());
        }
      }
    }
  }
  
  void enleverBrouillard(byte directionRegardee, byte x, byte y) // Lors de la découverte d'une nouvelle pièce
  {
    byte milieuXSalle;
    byte milieuYSalle;
    
    if(directionRegardee == 0) // Haut
    {
      milieuXSalle = (byte)(x);
      milieuYSalle = (byte)(y - (nbCaseSalle/2)-2);
      while(true)
      {
        if(map[(byte)(milieuXSalle-1)][milieuYSalle].returnValeur() == '.')
          milieuXSalle--;
        else
          break;
      }
      milieuXSalle = (byte)(milieuXSalle + (nbCaseSalle/2));
    }
    else if(directionRegardee == 1) // Bas
    {
      milieuXSalle = (byte)(x);
      milieuYSalle = (byte)(y + (nbCaseSalle/2)+2);
      while(true)
      {
        if(map[(byte)(milieuXSalle-1)][milieuYSalle].returnValeur() == '.')
          milieuXSalle--;
        else
          break;
      }
      milieuXSalle = (byte)(milieuXSalle + (nbCaseSalle/2));
    }
    else if(directionRegardee == 2) // Gauche
    {
      milieuXSalle = (byte)(x - (nbCaseSalle/2)-2);
      milieuYSalle = (byte)(y);
      while(true)
      {
        if(map[milieuXSalle][(byte)(milieuYSalle-1)].returnValeur() == '.')
          milieuYSalle--;
        else
          break;
      }
      milieuYSalle = (byte)(milieuYSalle + (nbCaseSalle/2));
    }
    else // 3, Droite
    {
      milieuXSalle = (byte)(x + (nbCaseSalle/2)+2);
      milieuYSalle = (byte)(y);
      while(true)
      {
        if(map[milieuXSalle][(byte)(milieuYSalle-1)].returnValeur() == '.')
          milieuYSalle--;
        else
          break;
      }
      milieuYSalle = (byte)(milieuYSalle + (nbCaseSalle/2));
    }
    
    for(byte w = (byte)(milieuXSalle-nbCaseSalle/2-1) ; w < milieuXSalle+nbCaseSalle/2+2 ; w++) // Puis enlève le brouillard sur les cases environnante
    {
      for(byte z = (byte)(milieuYSalle-nbCaseSalle/2-1) ; z < milieuYSalle+nbCaseSalle/2+2 ; z++)
      {
        try{
          mapBrouillard[w][z] = 0;
          if (map[joueur.returnXPerso()-2+w][joueur.returnYPerso()-2+z].rPerso())
          {
            if (map[joueur.returnXPerso()-2+w][joueur.returnYPerso()-2+z].returnPersoQuiOccupe().returnEquipe() != joueur.returnEquipe())
              ennemisVisible.add(map[joueur.returnXPerso()-2+w][joueur.returnYPerso()-2+z].returnPersoQuiOccupe());
          }
        } catch(Exception e) {} // Possibilité de bug avec les fonctions de debug.
      }
    }
  }
  
  void actualiserCarte()
  {
    for(byte i = 0 ; i < nbColonnes ; i++)
      for(byte y = 0 ; y < nbLignes ; y++)
        caseCarte(i, y).changeValeur(caseCarte(i, y).returnValeur());
  }
  
  void placementEnnemis()
  {
      println("/////////////////////////////////////////PASSAGE/////////////////////////////////////////");
        
      nbEnnemis = 0;
      byte quelEnnemi;
      final byte nbEnnemisAPlace = (byte)(random(nbEnnemisMin, nbEnnemisMax));
      while(nbEnnemis < nbEnnemisAPlace)
      {
        byte randomI = (byte)(Math.random()*nbColonnes);
        byte randomY = (byte)(Math.random()*nbLignes);
        if(placementCorrect(randomI, randomY, true))
        {
          
          if(seulementBerserker)
            quelEnnemi = 3;
          else if(niveauDonjonAlea > 2)
            quelEnnemi = (byte)(random(4)+1);
          else
            quelEnnemi = (byte)(random(2)+1);
                                        // Nom,                 vie,         force,   mana,     coordonnées x, y, équipe, sexe et id.
                                        
           println("Ennemi placé, " + randomI + " ; " + randomY + " --- " + nbEnnemis + "'-'-'-'-'" + quelEnnemi);
          
          if(quelEnnemi == 1)
          {
            ennemis.add(new Personnage("Ennemi " + nbEnnemis, (short)250, (short)10, (short)300, randomI, randomY, (byte)2, 'X', (byte)6));
            println("ENNEMI UN");
          }
          else if(quelEnnemi == 2)
          {
            ennemis.add(new Personnage("Slime " + nbEnnemis, (short)150, (short)5, (short)300, randomI, randomY, (byte)2, 'X', (byte)9));
            println("ENNEMI DEUX");
          }
          else if(quelEnnemi == 3)
          {
            ennemis.add(new Guerrier("Berserker " + nbEnnemis, (short)1000, (short)20, (short)300, randomI, randomY, (byte)2, 'X', (byte)12));
            println("ENNEMI TROIS");
            println("|!|!|!| Berserker placé. Event: " + seulementBerserker);
          }
          else
          {
            ennemis.add(new Healer("Prêtre maléfique " + nbEnnemis, (short)100, (short)4, (short)300, randomI, randomY, (byte)2, 'X', (byte)13));
            println("ENNEMI TROIS");
          }
          nbEnnemis++;
          actualiserCarte();
        }
      }
  }
  
  void placementTresors()
  {
      nbTresors = 0;
      boolean coffreGentil = false; // Si le mimic amical est déja placé
      final byte nbTresorsAPlace = (byte)(random(nbEnnemisMin, nbEnnemisMax));
      while(nbTresors < nbTresorsAPlace)
      {
          try{
            byte randomI = (byte)(Math.random()*nbColonnes);
            byte randomY = (byte)(Math.random()*nbLignes);
            short coffreAleatoire = (short)(random(1000)+1);
            byte chanceApparitionMimic = (byte)(random(2)+1);
            
            if(placementCorrect(randomI, randomY, false))
            {
              if(chanceApparitionMimic == 1 && !coffreGentil && mimic.returnVie() > 0) // Semble ne pas marcher
              {
                                          // Nom,           vie,      force,   mana,     coordonnées x, y, équipe, sexe et id.
                persoNeutre.add(mimic);
                mimic.defEmplacementPerso(randomI, randomY);
                coffreGentil = true;
                println("Mimic amical: " + randomI + " ; " + randomY);
              }
              else
              {
                if(coffreAleatoire <= chanceCoffreGlace) coffres.add(new Coffre(randomI, randomY, (byte)4));
                else if(coffreAleatoire <= chanceCoffreOr) coffres.add(new Coffre(randomI, randomY, (byte)3));
                else if(coffreAleatoire <= chanceCoffreArgent) coffres.add(new Coffre(randomI, randomY, (byte)2));
                else coffres.add(new Coffre(randomI, randomY, (byte)1));
                nbTresors++;
                println("Coffre placé");
              }
            }
          } catch(Exception e) { // Trop d'erreurs, à gérer
            //println("Erreur lors du placement d'un trésor: " + e.getMessage());
          }
        actualiserCarte();
    }
    println("///////////////////////////////////////////// Nombre de trésors: " + nbTresors);
  }
  
  void placementMursIncassable()
  {
    for(byte i = 0 ; i < nbColonnes ; i++) // Placement des murs incassable horizontale
    {
      map[i][0].changeValeur('M');
      map[i][nbLignes-1].changeValeur('M');
    }
    for(byte i = 0 ; i < nbLignes ; i++) // Placement des murs incassable verticale
    {
      map[0][i].changeValeur('M');
      map[nbColonnes-1][i].changeValeur('M');
    }
  }
  
  void placementMursCassable()
  {
    for(byte i = nbCaseSalle+1 ; i < nbColonnes-1 ; i+=nbCaseSalle+1) // Placement des murs cassable horizontale
    {
      for(byte y = 1 ; y < nbLignes-1 ; y++)
          map[i][y].changeValeur('N');
      nbSalleHor++;
    }
    nbSalleHor++;
    for(byte i = nbCaseSalle+1 ; i < nbLignes-1 ; i+=nbCaseSalle+1) // Placement des murs cassable verticale
    {
      for(byte y = 1 ; y < nbColonnes-1 ; y++)
          map[y][i].changeValeur('N');
      nbSalleVer++;
    }
    nbSalleVer++; 
  }
  
  void placementEntreesSorties() // Placement de l'entrée, de la sortie et du joueur
  {
    if(zoneArrive == 0)
      zoneDepart = (byte)(Math.random()*4+1);
    else
      zoneDepart = zoneArrive;
    do
      zoneArrive = (byte)(Math.random()*4+1);
    while(zoneDepart == zoneArrive);

    if(zoneDepart == 1)                                       // En haut à gauche
      map[nbCaseSalle/2+1][nbCaseSalle/2+1].changeValeur('E');
    else if(zoneDepart == 2)                                  // En bas à droite
      map[nbColonnes-nbCaseSalle/2-2][nbLignes-nbCaseSalle/2-2].changeValeur('E');
    else if(zoneDepart == 3)                                  // en haut à droite
      map[nbColonnes-nbCaseSalle/2-2][nbCaseSalle/2+1].changeValeur('E');
    else if(zoneDepart == 4)                                  // en bas à droite
      map[nbCaseSalle/2+1][nbLignes-nbCaseSalle/2-2].changeValeur('E');
          
    if(zoneArrive == 1)
      map[nbCaseSalle/2+1][nbCaseSalle/2+1].changeValeur('S');
    else if(zoneArrive == 2) 
      map[nbColonnes-nbCaseSalle/2-2][nbLignes-nbCaseSalle/2-2].changeValeur('S'); 
    else if(zoneArrive == 3) 
      map[nbColonnes-nbCaseSalle/2-2][nbCaseSalle/2+1].changeValeur('S');
    else if(zoneArrive == 4) 
      map[nbCaseSalle/2+1][nbLignes-nbCaseSalle/2-2].changeValeur('S');
      
    placementJoueurDebutPartie();
  }
  
  void placementJoueurDebutPartie()
  {
    if(carteActuelle != menuP)
    {
      for(byte i = 0 ; i < nbColonnes ; i++) // Placement du Perso en début de partie
      {
        for(byte y = 0 ; y < nbLignes ; y++)
        {
          for(int z = 0 ; z < equipe.size() ; z++) // Placement de tous les membre de l'équipe
          {
            try{
            if(map[i][y].returnValeur() == 'E')
            {
              if(z < 2)
                equipe.get(z).defEmplacementPerso((byte)(i-z), y);
              else // Car au bout de 2 cases, la suivante est un mur/porte.
                equipe.get(z).defEmplacementPerso(i, (byte)(y-1));
            }
            } catch(Exception e) {}
          }
        }
      }
    }
  }
  
  void placementPortes()
  {
    boolean placementIncorrect = true;
    //while(placementIncorrect) <-- boucle infini ? wtf
    {
      placementIncorrect = false;
      for(byte i = nbCaseSalle/2+1 ; i < nbLignes ; i+=(nbCaseSalle/2+1)*2) // Placement des portes
      {
        for(byte y = nbCaseSalle/2+1 ; y < nbColonnes ; y+=(nbCaseSalle/2+1)*2)
        {
          boolean zoneInccorect = true;
          byte nbEssais = 0;
          while(zoneInccorect)
          {
            byte endroitPorte = (byte)(Math.random()*4+1);
            switch(endroitPorte)
            {
            case 1 :
              if(map[y][i-nbCaseSalle/2-1].returnValeur() != 'M' && map[y][i-nbCaseSalle/2-1].returnValeur() != 'P')
              {
                map[y][i-nbCaseSalle/2-1].changeValeur('P');
                zoneInccorect = false;
              }
              break;
            case 2 :
              if(map[y][i+nbCaseSalle/2+1].returnValeur() != 'M' && map[y][i+nbCaseSalle/2+1].returnValeur() != 'P')
              {
                map[y][i+nbCaseSalle/2+1].changeValeur('P');
                zoneInccorect = false;
              }
              break;
              case 3 :
              if(map[y+nbCaseSalle/2+1][i].returnValeur() != 'M' && map[y+nbCaseSalle/2+1][i].returnValeur() != 'P')
              {
                map[y+nbCaseSalle/2+1][i].changeValeur('P');
                zoneInccorect = false;
              }
              break;
              case 4 :
              if(map[y-nbCaseSalle/2-1][i].returnValeur() != 'M' && map[y-nbCaseSalle/2-1][i].returnValeur() != 'P')
              {
                map[y-nbCaseSalle/2-1][i].changeValeur('P');
                zoneInccorect = false;
              }
              break;
            }
            nbEssais++;
            if(nbEssais == 10) // Construction en theorie impossible, replace tout depuis le début.
            {
              zoneInccorect = false;
              placementIncorrect = true;
              println("Erreur, une porte n'a pas pu être généré.");
            }
          }
        }
      }
    }
  }
  
  void afficherMiniMap()
  {
    if(modeDeJeu == 2)
    {
      textSize(12);
      stroke(10);
      for(int i = 0 ; i < nbSalleHor*2+1 ; i++){
        for(int y = 0 ; y < nbSalleVer*2+1 ; y++){
          try {
            if(mapBrouillard[i*3][y*3] == 0)
            {
              if(valeurCase((byte)(i*3), (byte)(y*3)) == 'M')
                 fill(105, 105, 105);
               else if(valeurCase((byte)(i*3), (byte)(y*3)) == 'E')
                 fill(0, 255, 0);
               else if(valeurCase((byte)(i*3), (byte)(y*3)) == '.')
                 fill(205, 102, 29);
               else if(valeurCase((byte)(i*3), (byte)(y*3)) == 'S')
                 fill(255, 0, 0);
               else if(valeurCase((byte)(i*3), (byte)(y*3)) == 'N')
                 fill(211, 211, 211);
               else if(valeurCase((byte)(i*3), (byte)(y*3)) == 'P')
                 fill(139, 39, 19);
               else
                 fill(random(255), random(255), random(255)); // N'est pas censée arrivé, mais si c'est le cas, ça se verra.
            }
            else
              fill(0);
            rect(menuP.tailleFenX()+20+10*i, 20+13*y, 12, 12); // 12 est la taille du texte.
          } catch(Exception e) {
            // Erreur minimap, pensé a voir pourquoi ca se passe.
          }
          textSize(15);
          fill(255);
          text("Level " + niveauDonjonAlea, menuP.tailleFenX()+20, 20 + 110);
        }
      }
      noStroke();
    }
    else
    {
      textSize(15);
      text(d.miniMapNonDispo(), menuP.tailleFenX()+60, 60);
    }
  }
  
  void verifCarte() // Vérifie que la carte est bien possible. Prend à droite à chaques intersections Ne marche pas encore.
  {
    byte cheminOK[] = {1, 1}; // 0: chemin valide ; 1: chemin en cours de validation ; 2: chemin invalide
    char mapRecherche[][] = new char[nbSalleHor*2+1][nbSalleVer*2+1]; // Contient une version réduite de la map pour faciliter la chose
    byte dirRegarde[] = new byte[2]; // 0: haut ; 1: bas ; 2: gauche ; 3: droite
    byte posRecherche[][] = new byte[2][2]; // Position où en ai actuellement les 2 recherches
    
    for(int i = 0 ; i < nbSalleHor*2+1 ; i++){
      for(int y = 0 ; y < nbSalleVer*2+1 ; y++){
        mapRecherche[i][y] = map[i*3][y*3].returnValeur();
        print(map[i*3][y*3].returnValeur());
      }
      println();
    }
    
    if(zoneDepart == 1)
    {
      dirRegarde[0] = 1; // direction où le curseur regarde en fonction de la zone de départ
      dirRegarde[1] = 3;
      println(mapRecherche[1][2] + " ; " + mapRecherche[2][1]);
      if(mapRecherche[1][2] == 'P') // Si il y a une porte...
      {
        println("Porte 1 detecté");
        posRecherche[0][0] = 1; // La recherche est possible
        posRecherche[0][1] = 3;
      }
      else
          cheminOK[0] = 2; // Sinon elle ne l'est pas
      if(mapRecherche[2][1] == 'P')
      {
        println("Porte 2 detecté");
        posRecherche[1][0] = 3;
        posRecherche[1][1] = 1;
      }
      else
          cheminOK[1] = 2;
    }
    else if(zoneDepart == 2)
    {
      dirRegarde[0] = 2;
      dirRegarde[1] = 0;
      println(mapRecherche[mapRecherche.length - 3][mapRecherche[0].length - 2] + " ; " + mapRecherche[mapRecherche.length - 2][mapRecherche[0].length - 3]);
      if(mapRecherche[mapRecherche.length - 3][mapRecherche[0].length - 2] == 'P')
      {
        println("Porte 1 detecté");
        posRecherche[0][0] = (byte)(mapRecherche.length - 4);
        posRecherche[0][1] = (byte)(mapRecherche[0].length - 2);
      }
      else
          cheminOK[0] = 2;
      if(mapRecherche[mapRecherche.length - 2][mapRecherche[0].length - 3] == 'P')
      {
        println("Porte 2 detecté");
        posRecherche[1][0] = (byte)(mapRecherche.length - 2);
        posRecherche[1][1] = (byte)(mapRecherche[0].length - 4);
      }
      else
          cheminOK[1] = 2;
    }
    else if(zoneDepart == 3)
    {
      dirRegarde[0] = 2;
      dirRegarde[1] = 1;
      println(mapRecherche[mapRecherche.length - 3][1] + " ; " + mapRecherche[mapRecherche.length - 2][2]);
      if(mapRecherche[mapRecherche.length - 3][1] == 'P')
      {
        println("Porte 1 detecté");
        posRecherche[0][0] = (byte)(mapRecherche.length - 4);
        posRecherche[0][1] = 1;
      }
      else
          cheminOK[0] = 2;
      if(mapRecherche[mapRecherche.length - 2][2] == 'P')
      {
        println("Porte 2 detecté");
        posRecherche[1][0] = (byte)(mapRecherche.length - 2);
        posRecherche[1][1] = 3;
      }
      else
          cheminOK[1] = 2;
    }
    else if(zoneDepart == 4)
    {
      dirRegarde[0] = 0;
      dirRegarde[1] = 3;
      println(mapRecherche[1][mapRecherche.length - 3] + " ; " + mapRecherche[2][mapRecherche[0].length - 2]);
      if(mapRecherche[1][mapRecherche[0].length - 3] == 'P')
      {
        println("Porte 1 detecté");
        posRecherche[0][0] = (byte)(mapRecherche.length - 4);
        posRecherche[0][1] = 1;
      }
      else
          cheminOK[0] = 2;
      if(mapRecherche[2][mapRecherche[0].length - 2] == 'P')
      {
        println("Porte 2 detecté");
        posRecherche[1][0] = 3;
        posRecherche[1][1] = (byte)(mapRecherche[0].length - 2);
      }
      else
          cheminOK[1] = 2;
    }
    
    println(posRecherche[0][0] + "  " + posRecherche[0][1] + " valeur: " + mapRecherche[posRecherche[0][0]][posRecherche[0][1]]);
    println(posRecherche[1][0] + "  " + posRecherche[1][1] + " valeur: " + mapRecherche[posRecherche[1][0]][posRecherche[1][1]]);
    
    println("zoneDepart : " + zoneDepart);       
          
    while(cheminOK[0] != 2 && cheminOK[1] != 2 || cheminOK[0] == 0 || cheminOK[1] == 0)
    {
      for(int i = 0 ;  i < 2 ; i++)
      {
        if(cheminOK[i] == 1)
        {
        }
      }
    }
    if(cheminOK[0] == 0 || cheminOK[1] == 0)
      println("Map généré avec succès");
    else
      println("Erreur dans la génération de la map");
  }
  
  void verifMapCorrect()
  {
    variableOk();
    verifCarte();
  }
  
  void variableOk()
  {
    /*
     *  Vérifie que les dimensions sont bien dans ce format | * * * * * | * * * * * | * * * * * |
     *  | : mur    ;    * : sol   ;   Exemple pris sur une salle de 3 colonnes avec 5 cases par salles.
    */
    /*if((5*nbColonnes + nbColonnes-1 + 2)%nbColonnes != 0 && (5*nbLignes + nbLignes-1 + 2)%nbLignes != 0)
      afficheBoiteErreur("Les dimensions de la salle sont incorrect.");*/
  }
  
  char valeurCaseDevant(byte x, byte y, Personnage perso)
  {
    if(perso.returnDirectionRegarde() == 0) // haut
      return map[x][y-1].returnValeur();
    else if(/*caseCarte(x, y).returnPersoQuiOccupe()*/perso.returnDirectionRegarde() == 1) // bas
      return map[x][y+1].returnValeur();
    else if(perso.returnDirectionRegarde() == 2) // gauche
      return map[x-1][y].returnValeur();
    else if(perso.returnDirectionRegarde() == 3) // droite
      return map[x+1][y].returnValeur();
    else return 'M';
  }
  
  void changerValeurCaseDevant(byte x, byte y, char valeur, Personnage perso)
  {
    if(valeurCaseDevant(perso.returnXPerso(), perso.returnYPerso(), perso) != 'M')
    {
      if(perso.returnDirectionRegarde() == 0) // haut
        map[x][y-1].changeValeur(valeur);
      else if(perso.returnDirectionRegarde() == 1) // bas
        map[x][y+1].changeValeur(valeur);
      else if(perso.returnDirectionRegarde() == 2) // gauche
        map[x-1][y].changeValeur(valeur);
      else if(perso.returnDirectionRegarde() == 3) // droite
        map[x+1][y].changeValeur(valeur);
    }
  }
  
  char valeurCase(byte x, byte y)
  {
    return map[x][y].returnValeur();
  }
  
  void changerValeurCase(byte x, byte y, char valeur)
  {
    map[x][y].changeValeur(valeur);
  }
  
  Case caseCarte(byte x, byte y)
  {
    return map[x][y];
  }
  
  Case[][] returnCarte()
  {
    return map;
  }
  
  Case caseCarteDevant(byte x, byte y, Personnage perso)
  {
    if(perso.returnDirectionRegarde() == 0) // haut
      return map[x][y-1];
    else if(perso.returnDirectionRegarde() == 1) // bas
      return map[x][y+1];
    else if(perso.returnDirectionRegarde() == 2) // gauche
      return map[x-1][y];
    else if(perso.returnDirectionRegarde() == 3) // droite
      return map[x+1][y];
    else return map[x][y];   
  }
  
  Case caseCarteDerriere(byte x, byte y, Personnage perso)
  {
    if(perso.returnDirectionRegarde() == 0) // haut
      return map[x][y+1];
    else if(perso.returnDirectionRegarde() == 1) // bas
      return map[x][y-1];
    else if(perso.returnDirectionRegarde() == 2) // gauche
      return map[x+1][y];
    else if(perso.returnDirectionRegarde() == 3) // droite
      return map[x-1][y];
    else return map[x][y];   
  }
  
  void actualiserCase(byte x, byte y)
  {
    carteActuelle.caseCarte(x, y).changeValeur(caseCarte(x, y).returnValeur());
  }
  
  void actualiserCaseArriere(byte x, byte y, Personnage perso)
  {
    caseCarteDerriere(x, y, perso).changeValeur(caseCarteDerriere(x, y, perso).returnValeur());
  }
  
  void actualiserCaseDevant(byte x, byte y, Personnage perso)
  {
    caseCarteDevant(x, y, perso).changeValeur(caseCarteDevant(x, y, perso).returnValeur());
  }
  
  byte caseEstCache(byte x, byte y)
  {
    return mapBrouillard[x][y];
  }
  
  short tailleFenX(){return 1150;/*nbColonnes*25;*/} // Retourne la taille de la fenetre en X
  short tailleFenY(){return 650;/*nbLignes*25;*/} // Retourne la taille de la fenetre en Y
  
  byte returnNbColonnes(){return nbColonnes;}
  byte returnNbLignes(){return nbLignes;}
  
  byte tailleCase = 50;
  final byte nbColonnes = 37; // taille X
  final byte nbLignes = 19; // taille Y
  byte  returnTailleCase(){return tailleCase;}
  
  final byte nbCaseSalle = 5; // Nombre de case dans une salle
  
  final byte nbEnnemisMin = 5;
  final byte nbEnnemisMax = 15;
  // final byte chanceEnnemiApparaitre = 10; // 1/variable
  byte nbEnnemis;
  byte returnNbEnnemis(){return nbEnnemis;}
  void diminuerNbEnnemis(){nbEnnemis--;}
  
  final byte nbTresorsMin = 0;
  final long nbTresorsMax = 10;
  final byte chanceTresorsApparaitre = 4; // 1/variable
  byte nbTresors;
  final short chanceCoffreGlace = 1; // 0.1%
  final short chanceCoffreOr = 100; // 10%
  final short chanceCoffreArgent = 300; // 30%
  
  byte nbSalleHor, nbSalleVer;
  byte nbSalle;
  
  byte zoneDepart; // Zone de départ
  byte zoneArrive = 0; // Zone d'arrive
  // 1 : en haut à gauche ; 2 : en bas à gauche ; 3 : en haut à droite ; 4 : en bas à droite
  
  byte avanceGenerationAleatoire;
  
  Case map[][]           = new Case[nbColonnes][nbLignes];
  byte mapBrouillard[][] = new byte[nbColonnes][nbLignes];
  
  String returnNomCarte(){return nomCarte;}
}