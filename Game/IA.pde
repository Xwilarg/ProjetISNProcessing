/*
 * Crée par Christian CHAUX le 26/03/2016
 * Dernières modifications le 23/07/2016
 */

class IA {
  Personnage perso;
  Personnage persoDevant;
  Personnage persoPlusProche;
  byte quelIA;

  IA(Personnage perso)
  {
    this.perso = perso;
  }

  void faireAction()
  {
    switch(quelIA)
    {
    case 0 : 
      neRienFaire(); 
      break;

    case 1 : 
      rotationAttIA(); 
      break;

    case 2 : 
      healerIA(); 
      break;

    case 3 : 
      rushBossIA(); 
      break;

    case 4 : 
      guerrierIA(); 
      break;
      
    case 5 :
      stupideIA();
      break;
      
    case 6 :
      healerEnnemi();
      break;
      
    case 7 :
      flashHealer(); // Soigne Saria si elle deviens insane.
      break;
      
    case 8 :
      voleurIA();
      break;
      
    case 9 :
      fuireIA();
      break;
      
    case 10 :
      archer();
      break;
      
    case 11 :
      klyxIA();
      break;
    }
  }

  void neRienFaire() // 0
  {
  }
  
  void rotationAttIA() // 1
  {
    try
    {
      if (carteActuelle.caseCarteDevant(perso.returnXPerso(), perso.returnYPerso(), perso).returnPersoQuiOccupe().returnEquipe() != perso.returnEquipe()
        && carteActuelle.caseCarteDevant(perso.returnXPerso(), perso.returnYPerso(), perso).returnPersoQuiOccupe().returnVie() > 0)
        perso.attaquer();
      else
      {
        if (perso.returnDirectionRegarde() < 3)
          perso.changementDirectionRegarde((byte)(perso.returnDirectionRegarde()+1));
        else
          perso.changementDirectionRegarde((byte)(0));
      }
    } 
    catch(Exception e) {
      if (perso.returnDirectionRegarde() < 3)
        perso.changementDirectionRegarde((byte)(perso.returnDirectionRegarde()+1));
      else
        perso.changementDirectionRegarde((byte)(0));
    }
  }

  boolean conditionGuerrierAttaque() // Si le guerrier peut attaquer un ennemi
  {
    try {
      if (tournerDirectionEnnemi() && carteActuelle.caseCarteDevant(perso.returnXPerso(), perso.returnYPerso(), perso).rPerso())
        persoDevant = carteActuelle.caseCarteDevant(perso.returnXPerso(), perso.returnYPerso(), perso).returnPersoQuiOccupe();
      else
        persoDevant = null;

      if (persoDevant.returnVie() > 0
        && persoDevant.returnEquipe() != perso.returnEquipe())
        return true;
    }
    catch(Exception e)
    {
      return false;
    }
    return false;
  }

  boolean conditionHealerAttaque() // Si le healer peut soigner le joueur
  {
    try {
      if (tournerDirectionAlliee() && carteActuelle.caseCarteDevant(perso.returnXPerso(), perso.returnYPerso(), perso).rPerso())
        persoDevant = carteActuelle.caseCarteDevant(perso.returnXPerso(), perso.returnYPerso(), perso).returnPersoQuiOccupe();
      else
        persoDevant = null;

      if (persoDevant.returnVie() < persoDevant.returnVieMax() - 20
        && persoDevant.returnVie() > 0
        && persoDevant.returnEquipe() == perso.returnEquipe())
        return true;
    }
    catch(Exception e)
    {
      return false;
    }
    return false;
  }
  
  boolean aCotePerso(byte equipeJTrue) // Vérifie si l'IA est à coté d'un personnage d'une équipe prédéfini. 1 alliés ; 2 ennemi
  {
    if(tournerDirectionAlliee())
      if(carteActuelle.caseCarteDevant(perso.returnXPerso(), perso.returnYPerso(), perso).returnPersoQuiOccupe().returnEquipe() == equipeJTrue)
        return true;
        
    return false;
  }
  
  boolean aCoteEnnemi(byte equipeJTrue) // Joue pour l'instant sur l'ID.
  {
    if(tournerDirectionEnnemi())
      if(carteActuelle.caseCarteDevant(perso.returnXPerso(), perso.returnYPerso(), perso).returnPersoQuiOccupe().returnId() == equipeJTrue)
        return true;
        
    return false;
  }
  
  void stupideIA()
  {
    if (conditionGuerrierAttaque())
      perso.attaquer();
    else
    {
      
      byte distancePlusPetite = Byte.MAX_VALUE;
      ArrayList <Personnage> ennemisActuels = new ArrayList <Personnage> (); // Les ennemis différe de l'équipe du personnage
      
      if(perso.returnEquipe() == 1) ennemisActuels = ennemis;
      else
      {
        for(int i = 0 ; i < equipe.size() ; i++)
        {
          try
          {
            ennemisActuels.add(equipe.get(i));
          } catch (Exception e) {}
        }
      }
      byte tabDistanceEnnemis[] = new byte[ennemisActuels.size()];
      
      for (int i = 0; i < tabDistanceEnnemis.length; i++)
      {
        tabDistanceEnnemis[i] = (byte)(Math.sqrt(Math.pow(ennemisActuels.get(i).returnXPerso() - perso.returnXPerso(), 2) + Math.pow(ennemisActuels.get(i).returnYPerso() - perso.returnYPerso(), 2)));
        // Distance entre le perso et chaques ennemis.

        if (tabDistanceEnnemis[i] < distancePlusPetite)
        {
          distancePlusPetite = tabDistanceEnnemis[i];
          persoPlusProche = ennemisActuels.get(i);
        }
      }
      rapprocherCible(persoPlusProche, false);
    }
  }
  
  void guerrierIA() // default
  {
    if (conditionGuerrierAttaque())
      perso.attaquer();
    else if (ennemisVisible.size() == 0 && perso.returnEquipe() == joueur.returnEquipe()) // Si c'est un allié du joueur et que aucune ennemi n'est détecté dans les parages
    {
      if(aCotePerso(persoPlusProche(equipe, false).returnEquipe()))
      {
        fuirPerso(persoPlusProche(equipe, false));
      }
      else
      {
        rapprocherCible(persoPlusProche(equipe, true), true);
      }
    }
    else
    {
      byte distancePlusPetite = Byte.MAX_VALUE;
      ArrayList <Personnage> ennemisActuels = new ArrayList <Personnage> (); // Les ennemis différe de l'équipe du personnage
      
      if(perso.returnEquipe() == 1) ennemisActuels = ennemisVisible;
      else
      {
        for(int i = 0 ; i < equipe.size() ; i++)
        {
          try
          {
            ennemisActuels.add(equipe.get(i));
          } catch (Exception e) {}
        }
      }
      
      if(perso.returnEquipe() == 1)
        rapprocherCible(persoPlusProche(ennemisVisible, false), true);
      else if(perso.returnEquipe() == 2)
        rapprocherCible(persoPlusProche(equipe, false), true);
    }
  }
  
  Personnage persoPlusProche(ArrayList <Personnage> aApprocher, boolean seulementSiBlesse) // aApprocher: tableau (ennemi / equipe / etc)
  {
    byte distancePlusPetite = Byte.MAX_VALUE;
    byte tabDistanceEnnemis[] = new byte[aApprocher.size()];
      
    for (int i = 0; i < tabDistanceEnnemis.length; i++)
    {
      if(aApprocher.get(i) == perso) continue;
      
      if(seulementSiBlesse && aApprocher.get(i).returnVie() < aApprocher.get(i).returnVieMax()-20 && perso.returnEquipe() == 1 || !seulementSiBlesse)
      {
        tabDistanceEnnemis[i] = (byte)(Math.sqrt(Math.pow(aApprocher.get(i).returnXPerso() - perso.returnXPerso(), 2) + Math.pow(aApprocher.get(i).returnYPerso() - perso.returnYPerso(), 2)));
        // Distance entre le perso et chaques ennemis.
  
        if (tabDistanceEnnemis[i] < distancePlusPetite)
        {
          distancePlusPetite = tabDistanceEnnemis[i];
          persoPlusProche = aApprocher.get(i);
        }
      }
    }
    if(distancePlusPetite == Byte.MAX_VALUE)
    {
      if(perso.returnEquipe() == 1)
        persoPlusProche = joueur;
      else if(seulementSiBlesse)
      {
        try{
          fuirPerso(persoPlusProche(equipe, false));
        } catch(StackOverflowError soe) {}
      }
    }
    if(persoPlusProche == null) persoPlusProche = joueur;
    return persoPlusProche;
  }

  void healerEnnemi()
  {
    ArrayList <Personnage> aHeal;
    ArrayList <Personnage> aFuir;
    if(perso.returnEquipe() == 1)
    {
      aHeal = equipe;
      aFuir = ennemis;
    }
    else
    {
      aHeal = ennemis;
      aFuir = equipe;
    }
      
    tournerDirectionAlliee();
    if (conditionHealerAttaque())
    {
      perso.attaquer();
    }
    else //if(aCotePerso(aFuir.get(0).returnEquipe()))
    {
      fuirPerso(persoPlusProche(aFuir, false));
    }
    /*else if(ennemis.size() > 0) // Sert de else pour l'instant. <-- Marche pas, Dieu sais pourquoi.
    {
      rapprocherCible(persoPlusProche(aHeal, true), false);
    }
    else
    {
      fuirPerso(persoPlusProche(aFuir, false));
    }*/
  }
  
  void flashHealer() // 7
  {
    if(saria.returnEquipe() == 2)
    {
      if(aCoteEnnemi((byte)3)) // Saria
      {
        ennemis.remove(saria);
        saria = new Healer ("Saria",  (short)50,  (short)3,   (short)200, (byte)35, (byte)17, (byte)1, 'F', (byte)3);
        equipe.add(saria);
        saria.defEmplacementPerso((byte)(joueur.returnXPerso()+1), (byte)(joueur.returnYPerso()+1));
        saria.changerEtatDansEquipe();
      }
      else
        rapprocherCible(saria, true);
    }
  }
  
  void voleurIA() // 8
  {
    if(tournerDirectionPiege())
    {
      carteActuelle.caseCarteDevant(perso.returnXPerso(), perso.returnYPerso(), joueur).returnPiegeQuiOccupe().desamorcePiege();
      perso.augmenterXp((byte)10);
    }
    else if(aCotePerso((byte)1))
    {
      fuirPerso(persoPlusProche(equipe, false));
    }
    else
    {
      rapprocherCible(joueur, true);
    }
  }
  
  void fuireIA() // 9
  {
    fuirPerso(persoPlusProche(equipe, false));
  }
  
  void archer() // 10
  {
    byte chanceTir = (byte)(random(10)+1);
    for(int i = 0 ; i < equipe.size() ; i++)
    {
      if(perso.returnXPerso() == equipe.get(i).returnXPerso() || perso.returnYPerso() == equipe.get(i).returnYPerso())
      {
        tournerDirectionCible(equipe.get(i));
        break;
      }
    }
    if(chanceTir == 10)
      proj.add(new Projectile((byte)0, perso.returnDirectionRegarde(), perso.returnXPerso(), perso.returnYPerso()));
  }
  
  void klyxIA() // 11
  {
    
  }
  
  void tournerDirectionCible(Personnage cible)
  {
    if(cible.returnXPerso() == perso.returnXPerso())
    {
      if(cible.returnYPerso() < perso.returnYPerso())
        perso.changementDirectionRegarde((byte)0);
      else
        perso.changementDirectionRegarde((byte)1);
    }
    else if(cible.returnYPerso() == perso.returnYPerso())
    {
      if(cible.returnXPerso() < perso.returnXPerso())
        perso.changementDirectionRegarde((byte)2);
      else
        perso.changementDirectionRegarde((byte)3);
    }
  }

  void healerIA() // Se rapproche du joueur et le soigne si il est blessé de son max de vie - 20 au min.
  {
    ArrayList <Personnage> aHeal;
    if(perso.returnEquipe() == 1)
      aHeal = equipe;
    else
      aHeal = ennemis;
    
    tournerDirectionAlliee();
    if (conditionHealerAttaque())
    {
      perso.attaquer();
    }
    else if(aCotePerso(persoPlusProche(aHeal, false).returnEquipe()))
    {
      fuirPerso(persoPlusProche(aHeal, false));
    }
    else
    {
      rapprocherCible(persoPlusProche(aHeal, true), true);
    }
  }

  void rapprocherCible(Personnage cible, boolean eviterTrous)
  {
    if (perso.returnXPerso() > cible.returnXPerso())
    {
      perso.changementDirectionRegarde((byte)2); // Gauche
      if(deplacementOk(eviterTrous))
        perso.modifEmplacementPerso((byte)-1, (byte)0);
      else
        /*contournerObstacle()*/;
    }
    else if (perso.returnXPerso() < cible.returnXPerso())
    {
      perso.changementDirectionRegarde((byte)3); // Droite
      if(deplacementOk(eviterTrous))
        perso.modifEmplacementPerso((byte)1, (byte)0);
     else
        /*contournerObstacle()*/;
    }
    if (perso.returnYPerso() > cible.returnYPerso())
    {
      perso.changementDirectionRegarde((byte)0); // Haut
      if(deplacementOk(eviterTrous))
        perso.modifEmplacementPerso((byte)0, (byte)-1);
      else
        /*contournerObstacle()*/;
    } else if (perso.returnYPerso() < cible.returnYPerso())
    {
      perso.changementDirectionRegarde((byte)1); // Bas
      if(deplacementOk(eviterTrous))
        perso.modifEmplacementPerso((byte)0, (byte)1);
      else
        /*contournerObstacle()*/;
    }
  }
  
  boolean deplacementOk(boolean eviterTrous) // Permet que l'IA ne fonce pas dans un trou...
  {
    if(carteActuelle.caseCarteDevant(perso.returnXPerso(), perso.returnYPerso(), perso).returnEstTraversable()
      || carteActuelle.caseCarteDevant(perso.returnXPerso(), perso.returnYPerso(), perso).returnEstOuvrable())
    {
      if(eviterTrous)
      {
        if(carteActuelle.caseCarteDevant(perso.returnXPerso(), perso.returnYPerso(), perso).rPiege())
        {
          if(carteActuelle.caseCarteDevant(perso.returnXPerso(), perso.returnYPerso(), perso).returnPiegeQuiOccupe().returnEstAmorce())
            return false;
          else
            return true;
        }
        else
          return true; 
      }
      else return true;
    }
    else
      return false;
  }
  
  void contournerObstacle() // Si rencontre un mur, regarde de quel coté est le mieux pour le contourner
  {
    /// Exemple, F est le PNJ
    /*
      . . N
      . . N
      . F N
      . . N
      . . P
      
      valeurCaseATest[0] contient N et valeurCaseATest[1] également, après un tour de boucle, valeurCaseATest[0] contient N et valeurCaseATest[1] contient P.
      Donc le chemin le plus rapide est par le bas.    
    */
    byte caseATest[][] = new byte[2][2];
    char valeurCaseATest[] = new char[2];
    byte bonneSortie = 0; // 0 haut, 1 bas, 2 gauche, 3 droite
    boolean sortieTrouve = false;
    byte nbTourBoucle = 0;
    do
    {
      if(perso.returnDirectionRegarde() == 0) // Haut
      {
        caseATest[0][0] = (byte)(perso.returnXPerso()-1);
        caseATest[0][1] = (byte)(perso.returnYPerso()-1);
        caseATest[1][0] = (byte)(perso.returnXPerso()+1);
        caseATest[1][1] = (byte)(perso.returnYPerso()-1);
      }
      else if(perso.returnDirectionRegarde() == 1) //Bas
      {
        caseATest[0][0] = (byte)(perso.returnXPerso()-1);
        caseATest[0][1] = (byte)(perso.returnYPerso()+1);
        caseATest[1][0] = (byte)(perso.returnXPerso()+1);
        caseATest[1][1] = (byte)(perso.returnYPerso()+1);
      }
      else if(perso.returnDirectionRegarde() == 2) // Gauche
      {
        caseATest[0][0] = (byte)(perso.returnXPerso()-1);
        caseATest[0][1] = (byte)(perso.returnYPerso()-1);
        caseATest[1][0] = (byte)(perso.returnXPerso()-1);
        caseATest[1][1] = (byte)(perso.returnYPerso()+1);
      }
      else if(perso.returnDirectionRegarde() == 3) // Droite
      {
        caseATest[0][0] = (byte)(perso.returnXPerso()+1);
        caseATest[0][1] = (byte)(perso.returnYPerso()-1);
        caseATest[1][0] = (byte)(perso.returnXPerso()+1);
        caseATest[1][1] = (byte)(perso.returnYPerso()+1);
      }
      valeurCaseATest[0] = carteActuelle.valeurCase(caseATest[0][0], caseATest[0][1]);
      valeurCaseATest[1] = carteActuelle.valeurCase(caseATest[1][0], caseATest[1][1]);
      
      if(valeurCaseATest[0] == '.' || valeurCaseATest[0] == 'P')
      {
        if(perso.returnDirectionRegarde() == 0)
          perso.modifEmplacementPerso((byte)0, (byte)-1);
        else
          perso.modifEmplacementPerso((byte)-1, (byte)0);
        sortieTrouve = true;
      }
      else if(valeurCaseATest[1] == '.' || valeurCaseATest[1] == 'P')
      {
        if(perso.returnDirectionRegarde() == 0)
          perso.modifEmplacementPerso((byte)0, (byte)1);
        else
          perso.modifEmplacementPerso((byte)1, (byte)0);
        sortieTrouve = true;
      }
      nbTourBoucle++;
    }
    while(!sortieTrouve && nbTourBoucle < 10);
  }

  void ouvrirPorte(byte x, byte y)
  {
    if (carteActuelle.valeurCase(x, y) == 'P')
      perso.ouvrirPorte();
  }

  void rushBossIA()
  {
    if (tournerDirectionEnnemi()) perso.attaquer();
    else
    {
    }
  }

  boolean ennemiPres(byte nbCase)
  {
    for (int i = 0; i < ennemis.size(); i++)
      if (abs(ennemis.get(i).returnXPerso() - perso.returnXPerso()) <= nbCase) return true;

    return false;
  }

  boolean tournerDirectionEnnemi()
  {
    try {
      if (carteActuelle.caseCarte((byte)(perso.returnXPerso()-1), perso.returnYPerso()).returnPersoQuiOccupe().returnEquipe() != perso.returnEquipe())
      {
        perso.changementDirectionRegarde((byte)2);
        return true;
      }
    }
    catch(Exception e) {
    }
    try {
      if (carteActuelle.caseCarte((byte)(perso.returnXPerso()+1), perso.returnYPerso()).returnPersoQuiOccupe().returnEquipe() != perso.returnEquipe())
      {
        perso.changementDirectionRegarde((byte)3);
        return true;
      }
    }
    catch(Exception e) {
    }
    try {
      if (carteActuelle.caseCarte(perso.returnXPerso(), (byte)(perso.returnYPerso()-1)).returnPersoQuiOccupe().returnEquipe() != perso.returnEquipe())
      {
        perso.changementDirectionRegarde((byte)0);
        return true;
      }
    }
    catch(Exception e) {
    }
    try {
      if (carteActuelle.caseCarte(perso.returnXPerso(), (byte)(perso.returnYPerso()+1)).returnPersoQuiOccupe().returnEquipe() != perso.returnEquipe())
      {
        perso.changementDirectionRegarde((byte)1);
        return true;
      }
    }
    catch(Exception e) {
    }
    return false;
  }
  
  void fuirPerso(Personnage persoAFuir)
  {
    try {
      if (persoAFuir.returnXPerso() < perso.returnXPerso()) // Gauche
      {
        perso.changementDirectionRegarde((byte)2);
        if(!carteActuelle.caseCarteDerriere(perso.returnXPerso(), perso.returnYPerso(), perso).rPiege())
          perso.modifEmplacementPerso((byte)+1, (byte)0);
      }
    } catch(Exception e) {}
    try {
      if (persoAFuir.returnXPerso() > perso.returnXPerso()) // Droite
      {
        perso.changementDirectionRegarde((byte)3);
        if(!carteActuelle.caseCarteDerriere(perso.returnXPerso(), perso.returnYPerso(), perso).rPiege())
          perso.modifEmplacementPerso((byte)-1, (byte)0);
      }
    } catch(Exception e) {}
    try {
      if (persoAFuir.returnYPerso() < perso.returnYPerso()) // Haut
      {
        perso.changementDirectionRegarde((byte)0);
        if(!carteActuelle.caseCarteDerriere(perso.returnXPerso(), perso.returnYPerso(), perso).rPiege())
          perso.modifEmplacementPerso((byte)0, (byte)+1);
      }
    } catch(Exception e) {}
    try {
      if (persoAFuir.returnYPerso() > perso.returnYPerso()) // Bas
      {
        perso.changementDirectionRegarde((byte)1);
        if(!carteActuelle.caseCarteDerriere(perso.returnXPerso(), perso.returnYPerso(), perso).rPiege())
          perso.modifEmplacementPerso((byte)0, (byte)-1);
      }
    } catch(Exception e) {}
  }

  boolean tournerDirectionAlliee()
  {
    try {
      if (carteActuelle.caseCarte((byte)(perso.returnXPerso()-1), perso.returnYPerso()).returnPersoQuiOccupe().returnEquipe() == perso.returnEquipe()) // Gauche
      {
        perso.changementDirectionRegarde((byte)2);
        return true;
      }
    }
    catch(Exception e) {
    }
    try {
      if (carteActuelle.caseCarte((byte)(perso.returnXPerso()+1), perso.returnYPerso()).returnPersoQuiOccupe().returnEquipe() == perso.returnEquipe()) // Droite
      {
        perso.changementDirectionRegarde((byte)3);
        return true;
      }
    }
    catch(Exception e) {
    }
    try {
      if (carteActuelle.caseCarte(perso.returnXPerso(), (byte)(perso.returnYPerso()-1)).returnPersoQuiOccupe().returnEquipe() == perso.returnEquipe()) // Haut
      {
        perso.changementDirectionRegarde((byte)0);
        return true;
      }
    }
    catch(Exception e) {
    }
    try {
      if (carteActuelle.caseCarte(perso.returnXPerso(), (byte)(perso.returnYPerso()+1)).returnPersoQuiOccupe().returnEquipe() == perso.returnEquipe()) // Bas
      {
        perso.changementDirectionRegarde((byte)1);
        return true;
      }
    }
    catch(Exception e) {
    }
    return false;
  }
  
  boolean tournerDirectionPiege()
  {
    try {
      if (carteActuelle.caseCarte((byte)(perso.returnXPerso()-1), perso.returnYPerso()).rPiege()) // Gauche
      {
        if(carteActuelle.caseCarteDevant(perso.returnXPerso(), perso.returnYPerso(), perso).returnPiegeQuiOccupe().returnEstAmorce())
        {
          perso.changementDirectionRegarde((byte)2); // returnEstAmorce()
          return true;
        }
      }
    }
    catch(Exception e) {
    }
    try {
      if (carteActuelle.caseCarte((byte)(perso.returnXPerso()+1), perso.returnYPerso()).rPiege()) // Droite
      {
        if(carteActuelle.caseCarteDevant(perso.returnXPerso(), perso.returnYPerso(), perso).returnPiegeQuiOccupe().returnEstAmorce())
        {
          perso.changementDirectionRegarde((byte)3);
          return true;
        }
      }
    }
    catch(Exception e) {
    }
    try {
      if (carteActuelle.caseCarte(perso.returnXPerso(), (byte)(perso.returnYPerso()-1)).rPiege()) // Haut
      {
        if(carteActuelle.caseCarteDevant(perso.returnXPerso(), perso.returnYPerso(), perso).returnPiegeQuiOccupe().returnEstAmorce())
        {
          perso.changementDirectionRegarde((byte)0);
          return true;
        }
      }
    }
    catch(Exception e) {
    }
    try {
      if (carteActuelle.caseCarte(perso.returnXPerso(), (byte)(perso.returnYPerso()+1)).rPiege()) // Bas
      {
        if(carteActuelle.caseCarteDevant(perso.returnXPerso(), perso.returnYPerso(), perso).returnPiegeQuiOccupe().returnEstAmorce())
        {
          perso.changementDirectionRegarde((byte)1);
          return true;
        }
      }
    }
    catch(Exception e) {
    }
    return false;
  }

  void defQuelIA(byte valeur)
  {
    quelIA = valeur;
  }
}