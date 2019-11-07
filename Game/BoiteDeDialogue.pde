/*
 * Crée par Christian CHAUX en début 2016
 * Dernières modifications le 30/06/2016
 */

class BoiteDialogue
{
  BoiteDialogue()
  {
    progressionRecrutement = 0;
    code = "";
    codeCorrect = false;
  }

  void gameOver(String pRaison, String sRaison)
  {
    mortRaisonP = pRaison;
    mortRaisonS = sRaison;
    
    ecran = -1;
    perdu = true;
    String aEnvoyer = "ISN|" + versionJeu + "|" + pseudoJoueur + "|";

    textSize(40);
    background(0);
    fill(255);
    text(d.gameOver(), menuP.tailleFenX()/2-100, menuP.tailleFenY()/2-250);
    textSize(20);
    if (pRaison == "VIE_NULL")
      text(d.vousEtesMort(), menuP.tailleFenX()/2-60, menuP.tailleFenY()/2-180);

    if (sRaison == "MORT_INCONNU")
      text(d.mortRaisonInconnu(), menuP.tailleFenX()/2-130, menuP.tailleFenY()/2-120);
    else if (sRaison == "TOMBE_PIEGE")
      text(d.mortTombeTrou(), menuP.tailleFenX()/2-130, menuP.tailleFenY()/2-120);
    else if(sRaison == "TUER_ENNEMI")
      text(d.tuerEnnemi(), menuP.tailleFenX()/2-130, menuP.tailleFenY()/2-120);
    else if(sRaison == "TUER_BOMBE")
      text(d.tuerBombe(), menuP.tailleFenX()/2-130, menuP.tailleFenY()/2-120);
      
    textSize(15);
    text(d.astuce(), menuP.tailleFenX()/2-600+ecart/2, menuP.tailleFenY()-30); // Affichage des astuces pendant le chargement.
    
    textSize(50);
    text(d.affScore((byte)1), menuP.tailleFenX()/2-50, menuP.tailleFenY()/2+5); // Score
    
    textSize(20); // nv parcouru, or gagné, lvl joueur, (debug)blocs détruit, (débug)ennemi tué, (debug)tp spawn, (debug)insta-regen
    text(d.affScore((byte)2) + niveauDonjonAlea + " ; +" + (niveauDonjonAlea-1)*100, 50, menuP.tailleFenY()/2+55);
    text(d.affScore((byte)3) + joueur.returnOr() + " ; +" + joueur.returnOr(), 50, menuP.tailleFenY()/2+80);
    text(d.affScore((byte)4) + joueur.returnNiveau() + " ; +" + (joueur.returnNiveau()-1)*100, 50, menuP.tailleFenY()/2+105);
    text(d.affScore((byte)5) + debug.returnUDetruit() + " ; -" + debug.returnUDetruit()*200, 50, menuP.tailleFenY()/2+130);
    text(d.affScore((byte)6) + debug.returnUInstaKill() + " ; -" + debug.returnUInstaKill()*300, 50, menuP.tailleFenY()/2+155);
    text(d.affScore((byte)7) + debug.returnUTPSpawn() + " ; -" + debug.returnUTPSpawn()*10000, 50, menuP.tailleFenY()/2+180);
    text(d.affScore((byte)8) + debug.returnURestoreVie() + " ; -" + debug.returnURestoreVie()*90000, 50, menuP.tailleFenY()/2+205);
    score = (niveauDonjonAlea-1)*100 + joueur.returnOr() + (joueur.returnNiveau()-1)*100 - debug.returnUDetruit()*200 - debug.returnUInstaKill()*300 - debug.returnUTPSpawn()*10000 - debug.returnURestoreVie()*90000;
    
    textSize(50);
    text(score, menuP.tailleFenX()/2+100, menuP.tailleFenY()/2+5);
    aEnvoyer += score + "|";
    
    textSize(20);
    fill(255, 0, 0);
    text(d.affScore((byte)9),  menuP.tailleFenX()-550, menuP.tailleFenY()/2+55); // Infos supplémentaires
    
    fill(255);
    text(d.affScore((byte)10) + frameRateMin,  menuP.tailleFenX()-550, menuP.tailleFenY()/2+80); // FPS min
    textSize(15);
    for(int i = 0 ; i < progJoueur.size() ; i++)
    {
      text(progJoueur.get(i), menuP.tailleFenX()-550, menuP.tailleFenY()/2+105+i*20);
    }
    
    text(d.affScore((byte)11),  menuP.tailleFenX()-250, menuP.tailleFenY()/2+55); // Meilleurs scores
    if(!debugFonctionsAutorise && envoyerScore)
    {
      gestServ.envoiServ(aEnvoyer);
    
      if(gestServ.rMsgRecu() != null)
        gestionScoreRecu();
      else if(gestServ.rNbEssais() < 50) // Connection...
        text(d.affScore((byte)12), menuP.tailleFenX()-250, menuP.tailleFenY()/2+85);
      else // Connexion impossible
        text(d.affScore((byte)13), menuP.tailleFenX()-250, menuP.tailleFenY()/2+85);
    }
    else if(!envoyerScore) text(d.affScore((byte)14), menuP.tailleFenX()-250, menuP.tailleFenY()/2+85);
    else text(d.affScore((byte)15), menuP.tailleFenX()-250, menuP.tailleFenY()/2+85); //si commande de debug activé (debugFonctionsAutorise == true)
  }
  
  void gestionScoreRecu()
  {
    String[] msgRecu = {"", "", "", "", "", "", "", "", "", ""};
    byte nbColonnes = 0;
    for(byte i = 0 ; nbColonnes < msgRecu.length ; i++)
    {
      try {
        if(gestServ.rMsgRecu().charAt(i) == '\n')
          nbColonnes++;
        else
          msgRecu[nbColonnes] += gestServ.rMsgRecu().charAt(i);
      } catch(Exception e) {
        //nbColonnes++;
      }
    }
    for (byte i = 0 ; i < msgRecu.length ; i++) // Analyse la version de chaques place pour l'afficher de couleurs différentes
    {
      String version = "";
      for(byte y = 0 ; msgRecu[i].charAt(y) != ';' ; y++)
      {
        version += msgRecu[i].charAt(y);
      }
      if(version.equals(versionJeu)) fill(255);
      else if(version.equals(versionSuivante)) fill(0, 191, 255);
      else fill(255, 0, 0);
      //text(msgRecu[i], menuP.tailleFenX()-250, menuP.tailleFenY()/2+85+18*i);
    }
    text(gestServ.rMsgRecu(), menuP.tailleFenX()-250, menuP.tailleFenY()/2+85+18);
  }

  void afficheBoiteInfo(String message)
  {
    if(dernierMessagePancarte.equals("RECRUTEMENT_KYA")) // Le système de recrutement passe par une autre fonction (voir plus bas)
      recrutement(kya);
    else if(dernierMessagePancarte.equals("RECRUTEMENT_GANDUR"))
      recrutement(gandur);
    else if(dernierMessagePancarte.equals("RECRUTEMENT_SARIA"))
      recrutement(saria);
    else if(dernierMessagePancarte.equals("RECRUTEMENT_THRUG"))
      recrutement(thrug);
    else if(dernierMessagePancarte.equals("RECRUTEMENT_ELENIA"))
      recrutement(elenia);
    else if(dernierMessagePancarte.equals("OUVRIR_PORTE"))
      ouvrirPorte((byte)1);
    else if(dernierMessagePancarte.equals("MIMI"))
      dialogueMimi();
    else if(dernierMessagePancarte.equals("QUETE_MIMI"))
      queteMimi();
    else if(dernierMessagePancarte.equals("DIGIT8"))
      digicodeHuit();
    else if(dernierMessagePancarte.equals("DIAL_INTRO"))
      dialIntro();
    else
    {
      if (pancarte)
        fill(0);
      afficherImage(fBoiteDialogue, menuP.tailleFenX()/2-250, menuP.tailleFenY()/2-100);
      fill(255);
      textSize(15);
      try
      {
        text(message, menuP.tailleFenX()/2-220, menuP.tailleFenY()/2-50);
      } 
      catch(NullPointerException ex) {
        afficheBoiteErreur("Erreur dans BoiteDeDialogue.pde, afficheBoiteInfo(), NullPointerException");
        System.exit(1);
      }
    }
  }
  
  void dialIntro()
  {
    progressionRecrutement = 1;
    if (pancarte)
      fill(0);
    afficherImage(fBoiteDialogue, menuP.tailleFenX()/2-250, menuP.tailleFenY()/2-100);
    fill(255);
    textSize(15);
    try
    {
      text("Oh, " + joueur.returnNom() + " !\nCan you please go in the cellar and take back bread for me,\nplease ?", menuP.tailleFenX()/2-220, menuP.tailleFenY()/2-60);
      text("1) Yes.", menuP.tailleFenX()/2-220, menuP.tailleFenY()/2+50);
      text("2) Yes.", menuP.tailleFenX()/2-220, menuP.tailleFenY()/2+70);
    } 
    catch(NullPointerException ex) {
      afficheBoiteErreur("Erreur dans BoiteDeDialogue.pde, dialogues(), NullPointerException");
      System.exit(1);
    }
    if(derniereToucheAppuyee == 1 || derniereToucheAppuyee == 2)
    {
      dernierMessagePancarte = "I'm counting on you.";
      derniereToucheAppuyee = -1;
      progressionRecrutement = 0;
    }
    
  }
  
  void afficheBoiteErreur(String message)
  {  
    ecran = -1;

    afficherImage(fBoiteDialogue, menuP.tailleFenX()/2-250, menuP.tailleFenY()/2-100);
    fill(255);
    textSize(20);
    try {
      text(message, menuP.tailleFenX()/2-220, menuP.tailleFenY()/2-50);
      text("Press Enter to exit...", menuP.tailleFenX()/2-220, menuP.tailleFenY()/2+75);
    } 
    catch(Exception e) {
      println("Erreur : " + e.getMessage());
    }
  }
  
  void dialogueMimi()
  {
    progressionRecrutement = 1;
    if (pancarte)
      fill(0);
    afficherImage(fBoiteDialogue, menuP.tailleFenX()/2-250, menuP.tailleFenY()/2-100);
    fill(255);
    textSize(15);
    try
    {
      text(d.dialogMimi((byte)1), menuP.tailleFenX()/2-220, menuP.tailleFenY()/2-60);
      if(joueur.returnInventaire().rechercherObjet((byte)6)) // Chocolat
        text("1) " + d.dialogMimi((byte)2), menuP.tailleFenX()/2-220, menuP.tailleFenY()/2+50);
      text("2) " + d.dialogMimi((byte)3), menuP.tailleFenX()/2-220, menuP.tailleFenY()/2+70);
    } 
    catch(NullPointerException ex) {
      afficheBoiteErreur("Erreur dans BoiteDeDialogue.pde, dialogues(), NullPointerException");
      System.exit(1);
    }
    if(derniereToucheAppuyee == 1 && joueur.returnInventaire().rechercherObjet((byte)6)) // Chocolat
    {
      dernierMessagePancarte = d.dialogMimi((byte)4);
      joueur.returnInventaire().diminuerDeUn((byte)6); // Chocolat
      mimic.modifAmitie((byte)1);
      progressionRecrutement = 0;
    }
    else if(derniereToucheAppuyee == 2)
    {
      dernierMessagePancarte = d.dialogMimi((byte)5);
      progressionRecrutement = 0;
    }
  }
  
  void queteMimi()
  {
    if (pancarte)
      fill(0);
    afficherImage(fGrandBoiteDialogue, menuP.tailleFenX()/2-450, menuP.tailleFenY()/2-200);
    fill(255);
    textSize(12);
    try
    {
      if(progressionRecrutement < 2) text(d.queteMimi(progressionRecrutement), menuP.tailleFenX()/2-400, menuP.tailleFenY()/2-140);
      else text(d.queteMimi((byte)(progressionRecrutement-1)), menuP.tailleFenX()/2-400, menuP.tailleFenY()/2-140);
      text("1) " + d.accepter(), menuP.tailleFenX()/2-400, menuP.tailleFenY()/2+30);
      text("2) " + d.refuser(), menuP.tailleFenX()/2-400, menuP.tailleFenY()/2+50);
      text("3) " + d.queteMimi((byte)6), menuP.tailleFenX()/2-400, menuP.tailleFenY()/2+70);
      text("4) " + d.queteMimi((byte)7), menuP.tailleFenX()/2-400, menuP.tailleFenY()/2+90);
      text("5) " + d.queteMimi((byte)8), menuP.tailleFenX()/2-400, menuP.tailleFenY()/2+110);
      text("6) " + d.queteMimi((byte)9), menuP.tailleFenX()/2-400, menuP.tailleFenY()/2+130);
    } 
    catch(NullPointerException ex) {
      afficheBoiteErreur("Erreur dans BoiteDeDialogue.pde, dialogues(), NullPointerException");
      System.exit(1);
    }
    if(progressionRecrutement == 0) progressionRecrutement = 1;
    if(derniereToucheAppuyee == 1)
    {
      dernierMessagePancarte = d.queteMimi((byte)10);
      progressionRecrutement = 0;
    }
    else if(derniereToucheAppuyee == 2)
    {
      dernierMessagePancarte = d.queteMimi((byte)11);
      progressionRecrutement = 0;
    }
    else if(derniereToucheAppuyee > 2 && derniereToucheAppuyee < 7)
    {
      progressionRecrutement = derniereToucheAppuyee;
    }
    derniereToucheAppuyee = -1;
  }
  
  void ouvrirPorte(byte cleNecessaire) // 1: Clé normal
  {
    progressionRecrutement = 1;
    if (pancarte)
      fill(0);
    afficherImage(fBoiteDialogue, menuP.tailleFenX()/2-250, menuP.tailleFenY()/2-100);
    fill(255);
    textSize(15);
    try
    {
      text(d.ouvrirPorteFermee((byte)1), menuP.tailleFenX()/2-220, menuP.tailleFenY()/2-60);
      text("1) " + d.oui(), menuP.tailleFenX()/2-220, menuP.tailleFenY()/2+50);
      text("2) " + d.non(), menuP.tailleFenX()/2-220, menuP.tailleFenY()/2+70);
    } 
    catch(NullPointerException ex) {
      afficheBoiteErreur("Erreur dans BoiteDeDialogue.pde, dialogues(), NullPointerException");
      System.exit(1);
    }
    
    if(derniereToucheAppuyee == 1)
    {
      joueur.returnInventaire().diminuerDeUn((byte)5); // Clé
      carteActuelle.changerValeurCaseDevant(joueur.returnXPerso(), joueur.returnYPerso(), 'P', joueur);
      dernierMessagePancarte = d.ouvrirPorteFermee((byte)3);
      progressionRecrutement = 0;
    }
    else if(derniereToucheAppuyee == 2)
    {
      dernierMessagePancarte = d.ouvrirPorteFermee((byte)2);
      progressionRecrutement = 0;
    }
  }

  void demCompteur(String message, Personnage surQui) // A utiliser avant parlerPerso()
  {
    boiteDial.initialiser((short)3);
    msgParlerPerso = message;
    msgSurQui = surQui;
    dialAff = true;
  }

  void parlerPerso() // Quand les IAs parlent dans le donjon.
  {
    short x = (short)(msgSurQui.returnXPerso()*carteActuelle.returnTailleCase()-camJoueur.returnPointXGauche()*carteActuelle.returnTailleCase()+carteActuelle.returnTailleCase());
    short y = (short)(msgSurQui.returnYPerso()*carteActuelle.returnTailleCase()-camJoueur.returnPointYGauche()*carteActuelle.returnTailleCase()-carteActuelle.returnTailleCase());
    fill(255, 255, 255, 100);
    tint(255, 100);
    rect(x, y, 125, 25);
    textSize(13);
    fill(0, 0, 0, 150);
    text(msgParlerPerso, x+10, y+15);
    tint(255, 255);

    if (boiteDial.estFini()) dialAff = false;
  }

  void recrutement(Personnage perso)
  {
    if (progressionRecrutement == 0) progressionRecrutement = 1; // Commencement du recrutement.
    if (pancarte)
      fill(0);
    afficherImage(fBoiteDialogue, menuP.tailleFenX()/2-250, menuP.tailleFenY()/2-100);
    fill(255);
    textSize(10);
    try
    {
      if (progressionRecrutement == 1 || progressionRecrutement == 6)
        text(d.recrutementDial(perso, progressionRecrutement), menuP.tailleFenX()/2-220, menuP.tailleFenY()/2-60);
      else if(progressionRecrutement == 2)
        text(d.presentationPersos(perso), menuP.tailleFenX()/2-220, menuP.tailleFenY()/2-60);
      
      text("1- " + d.choixRecrutement((byte)1), menuP.tailleFenX()/2-220, menuP.tailleFenY()/2+30);
      if (progressionRecrutement == 1 || progressionRecrutement == 6)
        text("2- " + d.choixRecrutement((byte)2), menuP.tailleFenX()/2-220, menuP.tailleFenY()/2+50);
      else if(progressionRecrutement == 2)
        text("2- " + d.choixRecrutement((byte)4), menuP.tailleFenX()/2-220, menuP.tailleFenY()/2+50);
      text("3- " + d.choixRecrutement((byte)3), menuP.tailleFenX()/2-220, menuP.tailleFenY()/2+70);
    } 
    catch(NullPointerException ex) {
      afficheBoiteErreur("Erreur dans BoiteDeDialogue.pde, dialogues(), NullPointerException");
      System.exit(1);
    }
    
    
    if(derniereToucheAppuyee == 1)
    {
      if(equipe.size() >= 4)
      {
        dernierMessagePancarte = d.recrutementDial(perso, (byte)5);
        progressionRecrutement = 0;
      }
      else
      {
        equipe.add(perso);
        progressionRecrutement = 0;
        dernierMessagePancarte = d.recrutementDial(perso, (byte)3);
        perso.changerEtatDansEquipe();
        quetes[0].ajouterQuetePerso(perso);        
      }
    }
    else if(derniereToucheAppuyee == 2 && progressionRecrutement == 1 || derniereToucheAppuyee == 2 && progressionRecrutement == 6)
    {
      progressionRecrutement = 2;
    }
    else if(derniereToucheAppuyee == 2 && progressionRecrutement == 2)
    {
      progressionRecrutement = 6;
    }
    else if(derniereToucheAppuyee == 3)
    {
      progressionRecrutement = 0;
      dernierMessagePancarte = d.recrutementDial(perso, (byte)4);
    }
    derniereToucheAppuyee = -1;
  }
  
  void digicodeHuit()
  {
    progressionRecrutement = 1;
    if (pancarte)
      fill(0);
    afficherImage(fBoiteDialogue, menuP.tailleFenX()/2-250, menuP.tailleFenY()/2-100);
    fill(255);
    textSize(15);
    try
    {
      text("Waiting input...", menuP.tailleFenX()/2-220, menuP.tailleFenY()/2-60);
      for(int i = 1 ; i < progressionRecrutement ; i++)
      {
        text("...", menuP.tailleFenX()/2-220, menuP.tailleFenY()/2+50);
      }
    } 
    catch(NullPointerException ex) {
      afficheBoiteErreur("Erreur dans BoiteDeDialogue.pde, dialogues(), NullPointerException");
      System.exit(1);
    }
    if(derniereToucheAppuyee <= 10 && derniereToucheAppuyee >= 0)
    {
      progressionRecrutement++;
      code += derniereToucheAppuyee;
    }
    if(derniereToucheAppuyee == -38) // Entrée
    {
      if(code == "95621515")
      {
        dernierMessagePancarte = "Correct password.";
        codeCorrect = true;
        progressionRecrutement = 0;
      }
      else
      {
        dernierMessagePancarte = "Wrong password.";
        progressionRecrutement = 0;
      }
      code = "";
    }
    derniereToucheAppuyee = -1;
  }

  void changementVarPancarte() // Permet de laisser la boite de dialogue ouverte, a appeler avant afficherBoiteInfo()
  {
    pancarte = !pancarte;
  }

  void arbreDeRecrutement()
  {
    changementVarPancarte();
  }

  byte       progressionRecrutement; // 0: non commencé
  String     msgParlerPerso;
  Personnage msgSurQui;
  boolean    dialAff;
  String     code;
  boolean    codeCorrect;
  
  String mortRaisonP;
  String mortRaisonS;
  String rMortRaisonP(){return mortRaisonP;}
  String rMortRaisonS(){return mortRaisonS;}

  boolean returnDialAff() {
    return dialAff;
  }
  byte returnProgRecrutement() {
    return progressionRecrutement;
  }
}