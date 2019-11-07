/*
 * Crée par Christian CHAUX en début 2016
 * Dernières modifications le 21/07/2016
 */

import java.util.ArrayList;
import processing.net.*;

/*  -------------- VARIABLES -------------- */

ArrayList <Personnage> ennemis     = new ArrayList <Personnage> ();
ArrayList <Personnage> ennemisVisible = new ArrayList <Personnage> ();
ArrayList <Personnage> persoMort   = new ArrayList <Personnage> ();
ArrayList <Personnage> persoNeutre = new ArrayList <Personnage> (); // Mimic allié
ArrayList <Coffre> coffres         = new ArrayList <Coffre> ();
ArrayList <Piege> pieges           = new ArrayList <Piege> ();
ArrayList <BombePose> bombesPose   = new ArrayList <BombePose> ();
ArrayList <Personnage>  equipe     = new ArrayList <Personnage> ();
ArrayList <String> progJoueur      = new ArrayList <String> ();
//ArrayList <Quete> quetesJoueur     = new ArrayList <Quete> ();
ArrayList <Projectile> proj        = new ArrayList <Projectile> ();
Quete[]       quetes               = new Quete[9];
Succes[]      succes               = {new Succes((byte)1), new Succes((byte)2), new Succes((byte)3), new Succes((byte)4), new Succes((byte)5), new Succes((byte)6)};
Personnage[]  listePersos          = new Personnage[5]; // Nombre de NPCs. Utilisé pour tous les afficher dans le menu. A convert en ArrayList...
boolean       pancarte; // Si le joueur est en train de lire une pancarte.
boolean       erreur; // Si une erreur se produit dans le jeu.
boolean       perdu; // Si le joueur à perdu
boolean       enPause; // Jeu en pause
boolean       selectCarteEscTrois; // Si on est dans la selection de carte du 3e escalier
boolean       inventaireOuvert;
boolean       debugFonctionsAutorise;
boolean       afficherBarActions;
boolean       afficherFrameRate;
boolean       afficherControle;
boolean       afficherJournalQuetes;
boolean       afficherOptions;
boolean       afficherEcranChangerTouches;
boolean       afficherEcranOrdres;
boolean       dansLeNoir; // Le joueur voir seulement les cases juste autour de lui.
boolean       dansLeFroid; // Perte de vie par sec
boolean       sariaInsane; // Sauf si amulette
boolean       pasDeMana;
boolean       seulementBerserker;
boolean       envoyerScore; // Envoyer les scores au serveur ?
boolean       sansPerdreVie; // Pour un succès
boolean       seul; // Pour un succès
byte          ordreQuelPerso;
byte          ordreQuelOrdre;
byte          modeDeJeu;
byte          ecran; // Endroit où est le joueur (menu, jeu, etc...)
byte          dialogue; // ?
byte          langue;
byte          niveauHistoire;
byte          niveauDonjonAlea;
byte          astuceEcranChargement;
byte          nbToursDraw;
byte          derniereToucheAppuyee;
byte          progIntro;
byte          progHistoire; // Pour l'histoire du jeu.
float         frameRateMin;
String        dernierMessagePancarte;
String        versionJeu = "Alpha 9";
String        versionSuivante = "Alpha 10"; // Utilisé dans le tableau des score pour définir la version en béta
String        pseudoJoueur;
short         progressionBarreChargementPourcent;
short         progressionBarreChargement;
short         transparanceAffLvlDonjonAlea; // Pour afficher à quel niveau est le joueur au début d'un niveau aléatoire
short         transparanceAffInfosEvents;
int           score; // Score du joueur en fin de partie.
int           toucheHaut;
int           toucheBas;
int           toucheDroite;
int           toucheGauche;
int           toucheAction;
int           toucheRotDroite;
int           toucheRotGauche;

String[][]      dialoguesPNJ = new String[10][20]; // Stock tous les dialogue des PNJs pour un niveau, non fonctionnelle
//String[]    dialoguePancarte = new String[10];
// Pour la génération de fichier texte

AffichageDegats[] dgts = new AffichageDegats[20];
byte curseurDgts;
short ecart = 200;

/* ---------------- OBJETS ---------------- */

Carte     carteActuelle; // Carte dans laquel le personnage est actuellement
Carte     menuP           = new Carte("menu");
Carte     testIA          = new Carte(null);
Carte     histoire;
Carte     lvlAlea         = new Carte(null);
Carte     tuto            = new Carte("ISN01");
Carte     amisHouse       = new Carte("Amira");
Carte     intro           = new Carte("intro01");
Compteur  comp            = new Compteur();
Compteur  boiteDial       = new Compteur(); // Utiliser dans BoiteDeDialogue.pde
Dialogues d               = new Dialogues();
Debug     debug           = new Debug(); // Permet de débuguer le jeu en affichant des informations dans la console.
File file;
AffichageDegats affDegats = new AffichageDegats();
Sauvegarde sStats         = new Sauvegarde();
Succes    passSecret      = new Succes((byte)1); // Non fonctionnel
BoiteDialogue dial        = new BoiteDialogue();
EnvoiServeur gestServ     = new EnvoiServeur();
Ecrire ecr                = new Ecrire();
Client c = new Client(this, "88.177.122.46", 7777);

Personnage thrug;
Personnage saria;
Personnage gandur;
Personnage kya;
Personnage elenia;
Personnage joueur;
Personnage mannequin;
Personnage mimic;
Personnage petiteSoeur;
Personnage environnement;
Personnage eve, boss1;
Personnage dernierQuiAttaqueJoueur;
Personnage klyx;
Personnage persoOrdreChoisit; // Perso choisit pour donner des ordres

Camera camJoueur;

PImage logoProcessing;

/* ---------------------------------------- */

void settings()
{
  short fenX = menuP.tailleFenX(); // Nombre de colonnes x taille d'une case
  short fenY = menuP.tailleFenY(); // Nombre de lignes x taille d'une case
  
  size(fenX+ecart, fenY); // ecart = 200
  println("Taille de la fenêtre: (" + fenX + " ; " + fenY + ")");
}

void setup()
{
  background(0);
  fill(255);
  textSize(20);
  text("Please wait...", menuP.tailleFenX()/2-10, menuP.tailleFenY()/2-10);
  
  debugFonctionsAutorise = false;
  noStroke();
  iniImages(); // Charge les images.
  
  surface.setTitle(versionJeu);
  
  logoProcessing = loadImage("logoProcessing.png");
  frameRate(60);
  
  pancarte = false;
  erreur   = false;
  perdu    = false;
  enPause  = false;
  selectCarteEscTrois = false;
  inventaireOuvert    = false;
  envoyerScore = true;
  afficherBarActions     = true;
  afficherFrameRate      = false;
  afficherControle       = false;
  afficherJournalQuetes  = false;
  afficherOptions        = false;
  afficherEcranChangerTouches = false;
  afficherEcranOrdres    = false;
  dansLeNoir         = false;
  dansLeFroid        = false;
  sariaInsane        = false;
  pasDeMana          = false;
  seulementBerserker = false;
  sansPerdreVie = false;
  seul          = true;
  
  pseudoJoueur = "";
  
  frameRateMin   = Byte.MAX_VALUE;
  langue         = 0; // 1 : anglais, 2 : français ; 0 pour que l'utilisateur choisisse lui même
  ecran          = -5; // -5 : Remerciements ; -4 : Ecran de chargement ; -3 : Selection de langue ; -2 : Affichage de création avec Processing ; 0 : Select classe ; -1 : Erreurs ; 0 : Menu ; 1 : Affichage map
  modeDeJeu      = 0; // 1 : Histoire ; 2 : Sans fin ; 0 = menu
  nbToursDraw    = 1;
  niveauHistoire = 1;
  progIntro      = 0;
  score          = 0;
  progHistoire   = 0;
  histoire = new Carte("00" + niveauHistoire);
  
  curseurDgts = 0;
  for(int i = 0 ; i < dgts.length ; i++)
  {
    dgts[i] = new AffichageDegats();
  }
  
  menuP.variableOk(); // Test divers (dimension fenetre, etc...)
  
  //                             Nom,             vie,        force,      mana,      coordonnées x, y,   équipe, sexe et id.
  joueur        = new Personnage("Joueur", (short)100, (short)15,  (short)100, (byte)18, (byte)16, (byte)1, 'M', (byte)1);
  thrug         = new Guerrier  ("Thrug",  (short)200, (short)20,  (short)150, (byte)34, (byte)1,  (byte)1, 'M', (byte)2);
  saria         = new Healer    ("Saria",  (short)50,  (short)3,   (short)200, (byte)35, (byte)17, (byte)1, 'F', (byte)3);
  gandur        = new Mage      ("Gandur", (short)60,  (short)2,   (short)350, (byte)1 , (byte)17, (byte)1, 'M', (byte)4);
  kya           = new Voleur    ("Kya",    (short)85,  (short)5,   (short)140, (byte)1,  (byte)1,  (byte)1, 'F', (byte)10);
  elenia        = new Archer    ("Elenia", (short)90,  (short)12,  (short)100, (byte)29, (byte)1 , (byte)1, 'F', (byte)11);
  petiteSoeur   = new Personnage("Sans nom",(short)30,  (short)3,  (short)20 , (byte)16, (byte)6 , (byte)1, 'F', (byte)15);
  klyx          = new Mage      ("Klyx",   (short)1259,(short)38,  (short)32000,(byte)5, (byte)1,  (byte)2, 'M', (byte)16);
  
  mimic         = new Personnage("Mimic", (short)1000, (short)1,   (short)0,   (byte)0,  (byte)0,  (byte)3, 'F', (byte)8);
  
  mannequin     = new Personnage("Mannequin d'entrainement", Short.MAX_VALUE, (short)0, (short)0, (byte)10, (byte)10, (byte)2, 'X', (byte)5);
  environnement = new Personnage("Environnement", Short.MAX_VALUE, (short)30000, (short)Short.MAX_VALUE, (byte)-1, (byte)-1, (byte)-1, 'X', (byte)0);
  
  equipe.add(joueur);
  
  listePersos[0] = thrug;
  listePersos[1] = saria;
  listePersos[2] = gandur;
  listePersos[3] = kya;
  listePersos[4] = elenia;
  
  carteActuelle = menuP;
  
  camJoueur = new Camera((byte)(menuP.tailleFenX()/menuP.returnTailleCase()), (byte)(menuP.tailleFenY()/menuP.returnTailleCase()), joueur);
}

void draw()
{
  nbToursDraw++;
  if(nbToursDraw > frameRate) nbToursDraw = 1;
  switch(ecran)
  {
  case -5 :
    background(0);
    textSize(20);
    fill(255);
    text(d.ecrirePseudo(), menuP.tailleFenX()/2-20, menuP.tailleFenY()/2-40);
    ecr.afficherTexte();
    if(ecr.rEntreePresse())
    {
      pseudoJoueur = ecr.rTexteEcrit();
      ecran = -3;
      joueur.changerNom(pseudoJoueur);
    }
    // remerciements();
    break;
    
  case -4 : // Ecran de chargement
	
    ecranChargement();
    lvlAlea.creationAlea();
	break;
  
  case -3 : // Selection de la langue
  
    afficherImage(fSelectLangue, 0, 0);
    textSize(30);
    fill(0);
    text("1) Français", menuP.tailleFenX()/2-170+ecart/2, menuP.tailleFenY()/6);
    text("2) English", menuP.tailleFenX()/2-170+ecart/2, 3*menuP.tailleFenY()/6);
    text("3) Polski"/*(tłumaczenie częściowie)*/, menuP.tailleFenX()/2-170+ecart/2, 5*menuP.tailleFenY()/6);
    textSize(15);
    text("Polish translation was made by Amira and Regixter.", menuP.tailleFenX()/2-190+ecart/2, 5*menuP.tailleFenY()/6+30);
    
    if(langue != 0)
    {
      comp.initialiser((short)2);
      ecran++;
      
      /*thrug.changerNom("Thrug " + d.titre("le Téméraire"));
      saria.changerNom("Saria " + d.titre("la Prudente"));
      gandur.changerNom("Gandur " + d.titre("le Puissant"));*/
    }
    break;
    
  case -2 : // Affichage avant le début du jeu
  
    background(0);
    textSize(30);
    fill(255);
    try{
    image(logoProcessing,  menuP.tailleFenX()/2-280+ecart/2, menuP.tailleFenY()/2-270);
    } catch(Exception fe) {
      println("Erreur, image 'logoProcessing' non trouvé");
    }
    text(d.creeProcessing(), menuP.tailleFenX()/2-320+ecart/2, menuP.tailleFenY()/2+220);
    if(comp.estFini())
      ecran = 0;
    break;
    
  case -1 : // Erreurs et Game Over
    if(perdu) dial.gameOver(dial.rMortRaisonP(), dial.rMortRaisonS());
    break;
    
  case 0 : // Selection de la classe, temporaire.
    background(0);
    textSize(30);
    fill(255);
    text("0) Introduction level (not finished yet)", menuP.tailleFenX()/2-170+ecart/2, menuP.tailleFenY()/2-200);
    text("1) Warrior", menuP.tailleFenX()/2-170+ecart/2, menuP.tailleFenY()/2-100);
    text("2) Healer (comming soon)", menuP.tailleFenX()/2-170+ecart/2, menuP.tailleFenY()/2-60);
    text("X) Mage (comming soon)", menuP.tailleFenX()/2-170+ecart/2, menuP.tailleFenY()/2-20);
    text("X) Thief (comming soon)", menuP.tailleFenX()/2-170+ecart/2, menuP.tailleFenY()/2+20);
    text("X) Archer (comming soon)", menuP.tailleFenX()/2-170+ecart/2, menuP.tailleFenY()/2+60);
    text("X) Necromancer (comming soon)", menuP.tailleFenX()/2-170+ecart/2, menuP.tailleFenY()/2+100);
    break;
    
  case 1 : // Changement de zone.
  background(0);
  textSize(30);
  fill(255);
  text("Loading...", menuP.tailleFenX()/2-50+ecart/2, menuP.tailleFenY()/2-15);
  carteActuelle.supprimerEnnemis(); // On supprime tous les ennemis pour pas "qu'ils sortent de leur zone".
  if(modeDeJeu == 1)
  {
    if(carteActuelle == tuto)
    {
      tuto.changerNomFile("fauxDonjon");
    }
    carteActuelle = tuto;
    tuto.lireTxt();
    if(tutoEvent == 3)
    {
      carteActuelle.remplirBrouillard();
      carteActuelle.placementBrouillard();
    }
    
  }
  else if(modeDeJeu == 2)
  {
    if(sansPerdreVie == true && equipe.size() == 4)
      succes[2].activerSucces();
    sansPerdreVie = true;
    if(niveauDonjonAlea > 0)
    {
      String contenuAAdd = "";
      contenuAAdd += joueur.returnNiveau();
      contenuAAdd += ";";
      contenuAAdd += joueur.returnVie();
      contenuAAdd += ";";
      if(dansLeNoir) contenuAAdd += "1";
      else if(dansLeFroid) contenuAAdd += "2";
      else if(sariaInsane) contenuAAdd += "3";
      else if(pasDeMana) contenuAAdd += "4";
      else if(seulementBerserker) contenuAAdd += "5";
      else contenuAAdd += "0";
      contenuAAdd += ";";
      for(int i = 1 ; i < 4 ; i ++)
      {
        try
        {
          if(equipe.get(i) == saria) contenuAAdd += "Sar";
          else if(equipe.get(i) == kya) contenuAAdd += "Kya";
          else if(equipe.get(i) == gandur) contenuAAdd += "Gan";
          else if(equipe.get(i) == thrug) contenuAAdd += "Thr";
          else if(equipe.get(i) == elenia) contenuAAdd += "Ele";
          else contenuAAdd += "Autre";
        } catch(Exception e) {contenuAAdd += "null";}
        contenuAAdd += ";";
      }
      progJoueur.add(contenuAAdd);
    }
    
    activationEvent(); // Voir evenement
    
    progressionBarreChargement = 0;
    progressionBarreChargementPourcent = 0;
    transparanceAffLvlDonjonAlea = 255; // Totalement non transparant
    
    if(niveauDonjonAlea %5 != 0 || niveauDonjonAlea == 0)
    {
      carteActuelle.iniGenAlea();
      carteActuelle = lvlAlea;
      ecran = -4; // Ecran de chargement.
      astuceEcranChargement = 0;
    }
    else
    {
      carteActuelle.supprimerEnnemis();
      lvlAlea.changerNomFile("Eve");
      lvlAlea.lireTxt();
      ecran++;
    }
  }
  else if(modeDeJeu == 3)
  {
    carteActuelle = testIA;
    testIA.lireTxt();
  }
  else if(modeDeJeu == 0)
  {
    carteActuelle = menuP;
    menuP.lireTxt();
    ennemis.add(mannequin);
    //ennemis.add(klyx);
  }
  else if(modeDeJeu == 4)
  {
    carteActuelle = amisHouse;
    amisHouse.lireTxt();
  }
  else if(modeDeJeu == 5)
  {
    carteActuelle = intro;
    intro.lireTxt();
    progIntro = 1;
  }
  else
    println("Erreur condition");
  if(ecran != -1 && modeDeJeu != 2) // Si il n'y a pas d'erreurs ou qu'on ne soit pas en génération aléatoire de map.
    ecran++;
  
  camJoueur.placementCamera();
  camJoueur.siCameraDoitDeplacer();
  break;
  
  case 2 : // Affichage map
    /* ---------------------- DEBUG ----------------------- */
    
    debug.infosCase(joueur);
    if(frameRate < frameRateMin) frameRateMin = frameRate;
    // println(mouseX + " ; " + mouseY);
    
    /* -------------- AFFICHAGES DE LA CARTE -------------- */
    
    try{
      affichage();
      carteActuelle.afficherMiniMap();
    } catch(Exception e) {
      dial.afficheBoiteErreur("Erreur dans l'affichage de la carte, " + e.getMessage());
    }
    
    /*  -------------- AFFICHAGES DES INFOS --------------- */
    
    for(int i = 0 ; i < ennemis.size() ; i++) // Affichage de la vie des ennemis
    {
      ennemis.get(i).afficherVie(ennemis.get(i).returnVie(), false, (byte)1);
    }
    for(int i = 0 ; i < equipe.size() ; i++) // Affichage de la vie des alliés
    {
      try{
        equipe.get(i).afficherVie(equipe.get(i).returnVie(), true,  (byte)1);
      } catch(Exception e) {}
    }
    
    if(joueur.returnVie() <= 0) // Si le joueur est mort car il n'a plus de vie.
      dial.gameOver("VIE_NULL", "MORT_INCONNU");
    
    for(byte i = 0 ; i < dgts.length ; i++) // Affichage des dégats.
    {
      try{
        dgts[i].afficher();
      } catch (NullPointerException ne) {}
    }
    for(byte i = 0 ; i < succes.length ; i++) succes[i].obtenirSucces(); // Verif si le succès est obtenu, si oui, lance affchage etc...
    
    if(modeDeJeu == 2)
    {
      affichageNiveauDonjonAlea(); // Affichage du niveau au début d'un étage en mode génération aléatoire.
      affichageInfosEvents();
    }
    if(enPause) ecranPause(); // Si le joueur est dans l'écran pause.
    if(afficherControle) ecranControle();
    if(afficherJournalQuetes) ecranJournalQuetes();
    if(afficherOptions) ecranOptions();
    if(inventaireOuvert) joueur.returnInventaire().afficherInventaire();
    if(afficherEcranChangerTouches) ecranChangerTouches();
    affBarAction();
    
    if(afficherFrameRate)
      afficherFPS();
	
    /*  ------------- GESTION DES EVENEMENTS -------------- */
    
    camJoueur.siCameraDoitDeplacer();
    carteActuelle.actualiserCarte();
    
    if(!enPause)
    {
      try{
        if(pancarte)
          dial.afficheBoiteInfo(dernierMessagePancarte);
        verifEmplacementEvent();
        if(nbToursDraw > 50 && nbToursDraw %12.5 == 0
        || nbToursDraw > 40 && nbToursDraw < 50 && nbToursDraw %10 == 0
        || nbToursDraw > 20 && nbToursDraw < 40  && nbToursDraw %5 == 0
        || nbToursDraw > 10 && nbToursDraw < 20 && nbToursDraw %2.5 == 0
        || nbToursDraw < 10 && nbToursDraw == 1 || nbToursDraw < 10 && nbToursDraw == 2 || nbToursDraw < 10 && nbToursDraw == 2 || nbToursDraw < 10 && nbToursDraw == 2) //4 actions pour les IA par tours de draw.
        {
          actionIA();
          for(byte i = 0 ; i < equipe.size() ; i++) equipe.get(i).restaure();
          for(byte i = 0 ; i < proj.size() ; i++) if(!proj.get(i).deplacer()) proj.remove(proj.get(i));
        }
        if(nbToursDraw == 1) // Certaines actions n'ont pas besoin d'être vérifié souvent (comme les succès)
        {
        }
      } catch(Exception e) {
        dial.afficheBoiteErreur("Erreur dans la gestion des évenements, " + e.getMessage());
      }
    }
    
    break;
    
   default :
     dial.afficheBoiteErreur("Erreur, la variable 'ecran' a atteint une valeur non attendu.\nProjetISNProcessing.pde, ligne 147.");
     break;
  }
  fill(255, 200, 200);
  textSize(10);
  text("This is a debug build, this may not represent the final version of the game. This is the version " + versionJeu + ".", menuP.tailleFenX()/2+275, 12);
}

void resetJeu()
{
  carteActuelle.supprimerEnnemis();
  equipe = null;
  progJoueur = null;
  equipe = new ArrayList <Personnage> ();
  progJoueur = new ArrayList <String> ();
  carteActuelle.supprimerEnnemis();
  noStroke();
  
  surface.setTitle(versionJeu);
  
  pancarte = false;
  erreur   = false;
  perdu    = false;
  enPause  = false;
  debugFonctionsAutorise = false;
  selectCarteEscTrois = false;
  inventaireOuvert    = false;
  sansPerdreVie = false;
  seul          = true;
  resetEvent();
  
  ecran          = 1; // -4 : Ecran de chargement ; -3 : Selection de langue ; -2 : Affichage de création avec Processing ; -1 : Erreurs ; 0 : Menu ; 1 : Affichage map
  modeDeJeu      = 0; // 1 : Histoire ; 2 : Sans fin ; 0 = menu
  nbToursDraw    = 1;      
  
  carteActuelle = menuP;
  joueur.defEmplacementPerso((byte)18, (byte)16);
  
  gestServ.resetMsgRecu();
}

void afficherFPS()
{
  fill(255, 0, 0);
  textSize(13);
  text("FPS: " + frameRate, 10, 20);
}

void ecranControle()
{
  fill(0, 0, 0, 100);
  rect(20, 20, carteActuelle.tailleFenX()-40, carteActuelle.tailleFenY()-40);
  fill(255, 255, 255, 200);
  textSize(30);
  text(d.affControles((byte)1), carteActuelle.tailleFenX()/2-5, 50);
  textSize(20);
  for(int i = 2 ; i <= 14 ; i++)
  {
    text(d.affControles((byte)i), 40, 42*i);
  }
}

void choixCarte()
{
  background(0);
  textSize(30);
  fill(255);
  text("Select a map:", menuP.tailleFenX()/2-70+ecart/2, menuP.tailleFenY()/2-60);
  text("1) 001", menuP.tailleFenX()/2-70+ecart/2, menuP.tailleFenY()/2-20);
  text("2) carteEx", menuP.tailleFenX()/2-70+ecart/2, menuP.tailleFenY()/2+20);
  text("3) testIA", menuP.tailleFenX()/2-70+ecart/2, menuP.tailleFenY()/2+60);
  text("4) Boss1", menuP.tailleFenX()/2-70+ecart/2, menuP.tailleFenY()/2+100);
}

void ecranChangerTouches()
{
  
}

void ecranOptions()
{
  short tailleX = 1000;
  short tailleY = 400;
  short coteG = (short)((menuP.tailleFenX()/2)-500); // coté gauche
  short coteH = (short)((menuP.tailleFenY()/2)-200); // coté haut
  short coteB = (short)(coteH + tailleY); // coté bas
  short coteD = (short)(coteG + tailleX);// coté droit
  // Evite d'utiliser des fonctions à rallonge.
  
  byte nbColonnes = 15;
  byte nbLignes = 8;
  byte tailleCase = (byte)(tailleY/nbLignes);
  
  fill(0);
  rect(coteG, coteH-20, tailleX, tailleY);
  stroke(10);
  
  if(envoyerScore) fill(0, 255, 0);
  else fill(255, 0, 0);
  rect(coteG+20, coteH+20, 25, 25);
  
  if(debugFonctionsAutorise) fill(0, 255, 0);
  else fill(255, 0, 0);
  rect(coteG+20, coteH+75, 25, 25);
  
  fill(139, 0, 0);
  rect(coteG+20, coteH+130, 25, 25);
  
  fill(139, 0, 0);
  rect(coteG+20, coteH+185, 25, 25);
  
  fill(255);
  textSize(20);
  text(d.ecranOptions((byte)1), carteActuelle.tailleFenX()/2-5, coteH+5); // "Options:"
  textSize(15);
  text(d.ecranOptions((byte)2), coteG+20+35, coteH+20+20); // "Send score to the server"
  text(d.ecranOptions((byte)3), coteG+20+35, coteH+20+75); // "Enable/Disable debug's functions"
  text(d.ecranOptions((byte)4), coteG+20+35, coteH+20+130); // "Fullscreen"
  text(d.ecranOptions((byte)10), coteG+20+35, coteH+20+185); // "Rebind keys."
  textSize(8);
  text(d.ecranOptions((byte)5), coteG+20+35, coteH+20+30); // "The informations sent are the version of your game, your score and the nickname you wrote in the beginning of the game."
  text(d.ecranOptions((byte)6), coteG+20+35, coteH+20+85); // "Enable debug's functions will disable the online scoarboard and the achievements."
  text(d.ecranOptions((byte)7), coteG+20+35, coteH+20+95); // "Once activated, this option can't be disable."
  text(d.ecranOptions((byte)8), coteG+20+35, coteH+20+105); // "Debug's functions may not be available in some places."
  text(d.ecranOptions((byte)9), coteG+20+35, coteH+20+140); // "Not available yet."
  text(d.ecranOptions((byte)9), coteG+20+35, coteH+20+195); // "Not available yet."
  noStroke();
}

void ecranJournalQuetes()
{
  short tailleX = 1000;
  short tailleY = 400;
  short coteG = (short)((menuP.tailleFenX()/2)-500); // coté gauche
  short coteH = (short)((menuP.tailleFenY()/2)-200); // coté haut
  short coteB = (short)(coteH + tailleY); // coté bas
  short coteD = (short)(coteG + tailleX);// coté droit
  // Evite d'utiliser des fonctions à rallonge.
  
  byte nbColonnes = 15;
  byte nbLignes = 8;
  byte tailleCase = (byte)(tailleY/nbLignes);
  
  fill(0);
  rect(coteG, coteH, tailleX, tailleY);
  stroke(10);
  
  int quelQuete = 0;
  for(byte i = 0 ; i < 3 ; i++)
  {
    for(byte y = 0 ; y < 3 ; y++)
    {
      fill(255);
      rect(coteG + i*(tailleX/3), coteH + y*(tailleY/3), tailleX/3, tailleY/3);
      fill(0);
      try
      {
        textSize(13);
        text(quetes[quelQuete].rNom(), coteG + i*(tailleX/3) + 10, coteH + y*(tailleY/3) + 10);
        textSize(8);
        text(quetes[quelQuete].rDescription(), coteG + i*(tailleX/3) + 5, coteH + y*(tailleY/3) + 20);
      } catch(NullPointerException ne) {
        println((i+1)*(y+1)-1);
      }
      quelQuete++;
    }
  }
  noStroke();
}

void affBarAction()
{
  if(afficherEcranOrdres)
  {
    for(byte i = 0 ; i < 8 ; i++)
    {
      afficherImage(fCaseInventaire, menuP.tailleFenX()/2-4*50+i*50, menuP.tailleFenY()-50);
      fill(0);
      textSize(12);
      text(i+1, menuP.tailleFenX()/2-4*50+i*50+35, menuP.tailleFenY()-10);
      if(persoOrdreChoisit == null)
      {
        if (equipe.size() > i+1)
         text(equipe.get(i+1).returnNom(), menuP.tailleFenX()/2-4*50+i*50+5, menuP.tailleFenY()-50+23);
        else
        {
         text("Cancel", menuP.tailleFenX()/2-4*50+i*50+5, menuP.tailleFenY()-50+23);
         break;
        }
      }
      else
      {
        if (i == 0)
          text("Follow/player", menuP.tailleFenX()/2-4*50+i*50+5, menuP.tailleFenY()-50+23);
      }
    }
  }
  else if(afficherBarActions) 
  {
    stroke(10);
    tint(255, 175);
    for(byte i = 0 ; i < 8 ; i++)
    {
      afficherImage(fCaseInventaire, menuP.tailleFenX()/2-4*50+i*50, menuP.tailleFenY()-50);
      fill(255, 0, 0, 50);
      try{
        if(!joueur.progCompteur(i).estFini())
          rect(menuP.tailleFenX()/2-4*50+i*50-50, menuP.tailleFenY(), 50, -(joueur.progCompteur(i).progression()));
      } catch(NullPointerException ne) {}
      fill(0, 0, 0, 175);
      if(i == 0)
        afficherImage(joueur.rIconeAtt((byte)1), menuP.tailleFenX()/2-4*50+i*50, menuP.tailleFenY()-50);
      else if(i == 1)
        afficherImage(joueur.rIconeAtt((byte)2), menuP.tailleFenX()/2-4*50+i*50, menuP.tailleFenY()-50);
      else if(i == 2)
        afficherImage(joueur.rIconeAtt((byte)3), menuP.tailleFenX()/2-4*50+i*50, menuP.tailleFenY()-50);
      else if(i == 3)
        afficherImage(joueur.rIconeAtt((byte)4), menuP.tailleFenX()/2-4*50+i*50, menuP.tailleFenY()-50);
      else if(i >= 4)
      {
        try{
          afficherImage(joueur.returnInventaire().returnObjet((byte)0, (byte)(i-4)).returnImage(), menuP.tailleFenX()/2-4*50+i*50, menuP.tailleFenY()-50);
          textSize(9);
          text(joueur.returnInventaire().returnObjet((byte)0, (byte)(i-4)).returnNbEmpile(), menuP.tailleFenX()/2-4*50+i*50+5, menuP.tailleFenY()-50+45);
        } catch(Exception e) {}
      }
      else
        afficherImage(fCaseInventaire, menuP.tailleFenX()/2-4*50+i*50, menuP.tailleFenY()-50);
        textSize(13);
      text(i+1, menuP.tailleFenX()/2-4*50+i*50+35, menuP.tailleFenY()-10);
    }
    noStroke();
  }
  tint(255, 255);
  textSize(13);
  fill(255);
  text(d.showHide(), menuP.tailleFenX()/2+4*50+5, menuP.tailleFenY()-15);
}

void affichage()
{
  afficherImage(fStatsPersos, menuP.tailleFenX(), 0);
  carteActuelle.affichage();
  short placementText = 150;
  for(int i = 0 ; i < equipe.size() ; i++)
  {
      textSize(15);
      fill(255, 0, 0);
      rect(menuP.tailleFenX()+20, placementText+35-7, equipe.get(i).returnPourcentVie(), 5); // Vie
      if(equipe.get(i).returnManaVig().equals("Mana")) // Selon si le personnage possède de la mana ou de la vigueur
        fill(0, 0, 255);
      else
        fill(0, 255, 0);
      rect(menuP.tailleFenX()+20, placementText+55-7, equipe.get(i).returnPourcentMana(), 5); // Mana
      fill(255, 0, 255);
      rect(menuP.tailleFenX()+20, placementText+75-7, equipe.get(i).returnPourcentXp(), 5); // XP
      
      fill(255);
      text(equipe.get(i).returnNom(), menuP.tailleFenX()+20, placementText);
      
      text(d.affichageStats("Vie: ") + equipe.get(i).returnVie(), menuP.tailleFenX()+20, placementText+35);
      text(equipe.get(i).returnManaVig() + ": " + equipe.get(i).returnMana(), menuP.tailleFenX()+20, placementText+55);
      text(d.affichageStats("XP") + ": " + equipe.get(i).returnXp(), menuP.tailleFenX()+20, placementText+75);
      textSize(10);
      text(equipe.get(i).returnClasse() + d.affichageStats(" niveau ") + equipe.get(i).returnNiveau(), menuP.tailleFenX()+20, placementText+15);
      if(i != 0)
      {
        text(d.affichageStats("Current Order") + ": ", menuP.tailleFenX()+20, placementText+90);
        if(equipe.get(i).returnOrdre() == null)
          text("None", menuP.tailleFenX()+90, placementText+90);
      }
      
      placementText += 120;
  }
  for(int i = 0 ; i < 4-equipe.size() ; i++)
  {
    text(d.affichageStats("Emplacement vide"), menuP.tailleFenX()+20, placementText);
    placementText += 120;
  }
  text(d.affichageStats("Or") + ": " + joueur.returnOr(), menuP.tailleFenX()+20, placementText+0);
}

void affichageNiveauDonjonAlea()
{
  if(transparanceAffLvlDonjonAlea > 0)
  {
    fill(255, transparanceAffLvlDonjonAlea);
    textSize(30);
    text(d.affichageStats("Niveau ") + niveauDonjonAlea, menuP.tailleFenX()/2-60, menuP.tailleFenY()/2-220);
    transparanceAffLvlDonjonAlea -= 3;
  }
}

void affichageInfosEvents()
{
  if(transparanceAffInfosEvents > 0)
  {
    fill(255, transparanceAffInfosEvents);
    textSize(20);
    text(d.dialogEvent(), menuP.tailleFenX()/2-260, menuP.tailleFenY()-100);
    transparanceAffInfosEvents -= 2;
  }
}

void ecranChargement()
{
  background(0);
  fill(255);
  rect(menuP.tailleFenX()/2-500+ecart/2, menuP.tailleFenY()/2-25, 1000, 50);
  textSize(50);
  text("Loading...", menuP.tailleFenX()/2-200+ecart/2, menuP.tailleFenY()/2-100);
  textSize(15);
  text(d.astuce(), menuP.tailleFenX()/2-600+ecart/2, menuP.tailleFenY()/2+200); // Affichage des astuces pendant le chargement.
  fill(0, 255, 0);
  progressionBarreChargement = (short)((progressionBarreChargementPourcent*1000)/100);
  rect(menuP.tailleFenX()/2-500+ecart/2, menuP.tailleFenY()/2-25, progressionBarreChargement, 50);
}

void ecranPause()
{
  fill(255);
  textSize(40);
  text(d.jeuPause(), menuP.tailleFenX()/2-300, menuP.tailleFenY()/2-20);
}

void remerciements()
{
  fill(255);
  textSize(20);
  text("This game was made by :", menuP.tailleFenX()/2-100, 30);
  text("Programmation :", 50, 160);
  text("Christian Chaux", 50, 185);
  
  text("Graphisms :", 50, 410);
  text("kunnuh (17 images)", 50, 435);
  text("Illyes Kadai (7 images)", 50, 460);
  text("Jeremy Michel (2 images)", 50, 485);
  text("Gurvan Lecoq (1 image)", 50, 510);
  
  text("Beta-testing :", 450, 160);
  text("Amira (since Alpha-1)", 450, 185);
  text("Clément Allyre (since Alpha-2/3/4)", 450, 210);
  text("Alexandre Gratton (since Alpha-2/3/4)",450, 235);
  text("Illyes Kadai (since Alpha-2/3/4)", 450, 260);
  
  text("English translation :", 1050, 160);
  text("Christian Chaux", 1050, 185);
  text("With the help of Alexis Brand", 1050, 210);
  
  text("Polish translation :", 1050, 410);
  text("Amira", 1050, 435);
  text("With the help of Regixster", 1050, 460);
  
  textSize(30);
  
  text("Note: This screen is temporary", 450, 410);
  fill(255, 100, 100);
  text("Press any key to continue...", menuP.tailleFenX()-220, menuP.tailleFenY()-40);
}

void redefClient() // Ne peux pas être fait dans une classe.
{
  c = new Client(this, "88.177.122.46", 7777);
}

void mousePressed()
{
  // Dans les options.
  if(mouseX > (menuP.tailleFenX()/2)-500+20 && mouseX < (menuP.tailleFenX()/2)-500+20+25 && mouseY > (menuP.tailleFenY()/2)-200+20 && mouseY < (menuP.tailleFenY()/2)-200+20+25)
    envoyerScore = !envoyerScore;
  if(mouseX > (menuP.tailleFenX()/2)-500+20 && mouseX < (menuP.tailleFenX()/2)-500+20+25 && mouseY > (menuP.tailleFenY()/2)-200+75 && mouseY < (menuP.tailleFenY()/2)-200+75+25)
    debugFonctionsAutorise = true; // Ne peux pas être désactivé
}

void keyPressed()
{
  if(keyCode == ESC) // Empeche le joueur de fermer le jeu avec la touche Echap
    key = 0;
  //debug.deplacements();
}

void keyReleased()
{
  if(ecran == -5) // Nom du joueur
  {
    if(keyCode == BACKSPACE) // Efface un charactère
      {
        ecr.backspace();
      }
      else if(keyCode == ENTER) // Confirmer
      {
        ecr.enter();
      }
      else if(key == ' ' || key == '|')
      {
      }
      else if(ecr.rPosCurseur() == 20)
      {
      }
      else
        ecr.autresTouches();
  }
  else  if(ecran == -3)
  {
    if(key == '2') // français
      langue = 1;
    else if(key == '1') // anglais
      langue = 2;
    else if(key == '3') // polonais
      langue = 3;
  }
  else if(ecran == -2) // Passe les affichages avant le début du jeu
  {
    ecran = 0;
  }
  else if(ecran == 0) // Selection de la classe
  {
    if(key == '0') // Intro
    {
      modeDeJeu = 5;
      ecran++;
    }
    else if(key == '1') // Warrior
    {
      equipe.remove(joueur);
      joueur = new Guerrier(pseudoJoueur, (short)100, (short)15,  (short)100, (byte)18, (byte)16, (byte)1, 'M', (byte)1);
      equipe.add(joueur);
      camJoueur = new Camera((byte)(menuP.tailleFenX()/menuP.returnTailleCase()), (byte)(menuP.tailleFenY()/menuP.returnTailleCase()), joueur);
      ecran++;
      quetes[0] = new Quete((byte)1);
    }
    /*else if(key == '2') // Healer
    {
      equipe.remove(joueur);
      joueur = new Healer(pseudoJoueur, (short)100, (short)15,  (short)100, (byte)18, (byte)16, (byte)1, 'M', (byte)1);
      equipe.add(joueur);
      camJoueur = new Camera((byte)(menuP.tailleFenX()/menuP.returnTailleCase()), (byte)(menuP.tailleFenY()/menuP.returnTailleCase()), joueur);
      ecran++;
    }*/
  }
  else if(ecran == -1)
  {
    if(keyCode == ENTER) // Dans le cas d'une erreur ou si le joueur à perdu
    {
      if(perdu == false)
        System.exit(1);
      else
      {
        resetJeu();
      }
    }
    if(key == '1' && joueur.returnVie() > 0)
    {
      testIA.changerNomFile("001");
      ecran = 1;
    }
    else if(key == '2' && joueur.returnVie() > 0)
    {
      testIA.changerNomFile("carteEx");
      ecran = 1;
    }
    else if(key == '3' && joueur.returnVie() > 0)
    {
      testIA.changerNomFile("testIA");
      ecran = 1;
    }
    else if(key == '4' && joueur.returnVie() > 0)
    {
      testIA.changerNomFile("Boss1");
      ecran = 1;
    }
  }
  else if(ecran == 2)
  {
    if(keyCode == ESC && !inventaireOuvert && !afficherBarActions && !afficherJournalQuetes && !afficherOptions) // Le joueur peut fermer l'inventaie avec echap
      enPause = !enPause;
    if(keyCode == BACKSPACE && ennemis.size() == 0)
    {
      //resetJeu();
    }
      
    if(!enPause/* && dial.returnProgRecrutement() > 0*/)
    {
      derniereToucheAppuyee = (byte)(((byte)key)-48);
      println("Dernière touche appuyé: " + derniereToucheAppuyee);
    }
    if(!enPause && dial.returnProgRecrutement() == 0) // Si on est pas en pause et qu'on n'est pas en train de recruter qqun.
    {
      if (key == 'z' || key == 'Z' || keyCode == UP)
      {
        joueur.changementDirectionRegarde((byte)0);
        joueur.modifEmplacementPerso((byte)0, (byte)-1);
      }
      if (key == 's' || key == 'S' || keyCode == DOWN)
      {
        joueur.changementDirectionRegarde((byte)1);
        
        joueur.modifEmplacementPerso((byte)0, (byte)1);
      }
      if (key == 'q' || key == 'Q' || keyCode == LEFT)
      {
        joueur.changementDirectionRegarde((byte)2);
        joueur.modifEmplacementPerso((byte)-1, (byte)0);
      }
      if (key == 'd' || key == 'D' || keyCode == RIGHT)
      {
        joueur.changementDirectionRegarde((byte)3);
        joueur.modifEmplacementPerso((byte)1, (byte)0);
      }
      if(key == 'a' || key == 'A') // Tourne à gauche
      {
        if(joueur.returnDirectionRegarde() == 0) joueur.changementDirectionRegarde((byte)2);
        else if(joueur.returnDirectionRegarde() == 1) joueur.changementDirectionRegarde((byte)3);
        else if(joueur.returnDirectionRegarde() == 2) joueur.changementDirectionRegarde((byte)1);
        else if(joueur.returnDirectionRegarde() == 3) joueur.changementDirectionRegarde((byte)0);
      }
      if(key == 'e' || key == 'E') // Tourne à droite
      {
        if(joueur.returnDirectionRegarde() == 0) joueur.changementDirectionRegarde((byte)3);
        else if(joueur.returnDirectionRegarde() == 1) joueur.changementDirectionRegarde((byte)2);
        else if(joueur.returnDirectionRegarde() == 2) joueur.changementDirectionRegarde((byte)0);
        else if(joueur.returnDirectionRegarde() == 3) joueur.changementDirectionRegarde((byte)1);
      }
      if(key == 'i' || key == 'I' || keyCode == ESC && inventaireOuvert)
      {
        inventaireOuvert = !inventaireOuvert; // Ouverture/fermeture de l'inventaire
      }
      if(key == ',')
      {
        afficherControle = !afficherControle;
      }
      if(key == 'h' || key == 'H' || keyCode == ESC && afficherBarActions)
      {
        afficherBarActions = !afficherBarActions; // Barre qui permet de voir les attaques et les potions
      }
      if(key == 'j' || key == 'J' || keyCode == ESC && afficherJournalQuetes)
      {
        afficherJournalQuetes = !afficherJournalQuetes;
      }
      if(key == 'o' || key == 'O' || keyCode == ESC && afficherOptions)
      {
        afficherOptions = !afficherOptions;
      }
      if(key == '²')
      {
        afficherFrameRate = !afficherFrameRate;
      }
      if(key == '.')
      {
        afficherEcranOrdres = !afficherEcranOrdres;
      }
      if(key == '0' && joueur.returnInventaire().rechercherObjet((byte)10)) // Bombe
      {
        bombesPose.add(new BombePose(joueur.returnXPerso(), joueur.returnYPerso()));
        joueur.returnInventaire().diminuerDeUn((byte)10);  // Bombe
      }
      debug.deverouillePortes(); // Marche pas.
      if(key == '1') // Pour attaquer un ennemi
        joueur.attaquer();
      if(key == '2')
        joueur.attaquerSec();
      if(key == '3')
        joueur.attaquerTer();
      if(key == '4')
        joueur.attaquerLast();
      if(key == '5')
        joueur.returnInventaire().utiliserBarreAction((byte)5);
      if(key == '6')
        joueur.returnInventaire().utiliserBarreAction((byte)6);
      if(key == '7')
        joueur.returnInventaire().utiliserBarreAction((byte)7);
      if(key == '8')
        joueur.returnInventaire().utiliserBarreAction((byte)8);
      if(keyCode == ENTER && carteActuelle.caseCarteDevant(joueur.returnXPerso(), joueur.returnYPerso(), joueur).rPiege()
      && joueur.returnInventaire().rechercherObjet((byte)9) // Planche
      && carteActuelle.caseCarteDevant(joueur.returnXPerso(), joueur.returnYPerso(), joueur).returnPiegeQuiOccupe().returnEstAmorce()) // Desamorce un trou si le joueur a des plances.
      {
        carteActuelle.caseCarteDevant(joueur.returnXPerso(), joueur.returnYPerso(), joueur).returnPiegeQuiOccupe().desamorcePiege();
        joueur.returnInventaire().diminuerDeUn((byte)9); // Planche
      }
      if(keyCode == ENTER && carteActuelle.caseCarteDevant(joueur.returnXPerso(), joueur.returnYPerso(), joueur).rCoffre()) // Ouverture d'un coffre.
      {
        carteActuelle.caseCarteDevant(joueur.returnXPerso(), joueur.returnYPerso(), joueur).returnCoffreQuiOccupe().ouvrirCoffre();
      }
      if(keyCode == ENTER && carteActuelle.caseCarteDevant(joueur.returnXPerso(), joueur.returnYPerso(), joueur).returnValeur() == 'P')
      {
        joueur.ouvrirPorte();
      }
      if(keyCode == ENTER && carteActuelle.caseCarteDevant(joueur.returnXPerso(), joueur.returnYPerso(), joueur).returnValeur() == 'L')
      {
        derniereToucheAppuyee = 0;
        dial.changementVarPancarte();
        if(joueur.returnInventaire().rechercherObjet((byte)5)) // Clé
        {
          dernierMessagePancarte = "OUVRIR_PORTE";
        }
        else
        {
          d.porteFermee();
        }
      }
      if(keyCode == ENTER && carteActuelle.caseCarteDevant(joueur.returnXPerso(), joueur.returnYPerso(), joueur).returnValeur() == '*')
      {
        joueur.returnInventaire().ajouterObjet(new Objet((byte)5, (short)1));
        carteActuelle.changerValeurCaseDevant(joueur.returnXPerso(), joueur.returnYPerso(), '.', joueur);
      }
      if(keyCode == ENTER && carteActuelle.caseCarte(joueur.returnXPerso(), joueur.returnYPerso()).returnValeur() == '*')
      {
        joueur.returnInventaire().ajouterObjet(new Objet((byte)5, (short)1));
        carteActuelle.changerValeurCase(joueur.returnXPerso(), joueur.returnYPerso(), '.');
      }
     if(debugFonctionsAutorise) debug.actions();
    }
    if(modeDeJeu == 0) // Dans le menu
    {
      if(joueur.returnXPerso() == 33 && joueur.returnYPerso() == 2 && keyCode == ENTER && joueur.returnDirectionRegarde() == 0)
      {
        dial.changementVarPancarte();
        d.testPancarte();
      }
    }
    if(key == 'u') // Ne se déclanche pas.
      {
        dial.changementVarPancarte();
        dernierMessagePancarte = "DIGIT8";
        derniereToucheAppuyee = -1;
      }
      if(keyCode == ENTER && dial.returnProgRecrutement() == 0)
      {
        try{
          if(carteActuelle.caseCarteDevant(joueur.returnXPerso(), joueur.returnYPerso(), joueur).returnPersoQuiOccupe().returnId() == 2 && thrug.returnVie() >= 0) // Thrug
          {
            dial.changementVarPancarte();
            if(!thrug.returnDansEquipe())
            {
              dernierMessagePancarte = "RECRUTEMENT_THRUG";
              derniereToucheAppuyee = 0;
            }
            else
            {
              d.thrugAttente();
            }
            thrug.augmenterImpatience((byte)1);
          }
        }catch(Exception e){}
        try{
          if(carteActuelle.caseCarteDevant(joueur.returnXPerso(), joueur.returnYPerso(), joueur).returnPersoQuiOccupe().returnId() == 3 && saria.returnVie() >= 0) // Saria
          {
            dial.changementVarPancarte();
            if(!saria.returnDansEquipe())
            {
              dernierMessagePancarte = "RECRUTEMENT_SARIA";
              derniereToucheAppuyee = 0;
            }
            else
            {
              d.sariaAttente();
            }
            saria.augmenterImpatience((byte)1);
          }
        }catch(Exception e){}
        try{
          if(carteActuelle.caseCarteDevant(joueur.returnXPerso(), joueur.returnYPerso(), joueur).returnPersoQuiOccupe().returnId() == 4 && gandur.returnVie() >= 0) // Gandur
          {
            dial.changementVarPancarte();
            if(!gandur.returnDansEquipe())
            {
              dernierMessagePancarte = "RECRUTEMENT_GANDUR";
              derniereToucheAppuyee = 0;
            }
            else
            {
              d.gandurAttente();
            }
            gandur.augmenterImpatience((byte)1);
          }
        }catch(Exception e){}
        try{
          if(carteActuelle.caseCarteDevant(joueur.returnXPerso(), joueur.returnYPerso(), joueur).returnPersoQuiOccupe().returnId() == 8 && mimic.returnVie() >= 0) // Mimic allié
          {
            dial.changementVarPancarte();
            if(mimic.rAmitie() >= 3)
              dernierMessagePancarte = "QUETE_MIMI";
            else if(mimic.rAmitie() >= 0)
              dernierMessagePancarte = "MIMI";
            else
              dernierMessagePancarte = d.dialogMimi((byte)0);
          }
        }catch(Exception e){}
        try{
          if(carteActuelle.caseCarteDevant(joueur.returnXPerso(), joueur.returnYPerso(), joueur).returnPersoQuiOccupe().returnId() == 10 && kya.returnVie() >= 0) // Kya
          {
            dial.changementVarPancarte();
            if(!kya.returnDansEquipe())
            {
              dernierMessagePancarte = "RECRUTEMENT_KYA";
              derniereToucheAppuyee = 0;
            }
            else
            {
              d.kyaAttente();
            }
            kya.augmenterImpatience((byte)1);
          }
        }catch(Exception e){}
        try{
          if(carteActuelle.caseCarteDevant(joueur.returnXPerso(), joueur.returnYPerso(), joueur).returnPersoQuiOccupe().returnId() == 11 && elenia.returnVie() >= 0) // Elenia
          {
            dial.changementVarPancarte();
            if(!elenia.returnDansEquipe())
            {
              dernierMessagePancarte = "RECRUTEMENT_ELENIA";
              derniereToucheAppuyee = 0;
            }
            else
            {
              d.eleniaAttente();
            }
            elenia.augmenterImpatience((byte)1);
          }
        }catch(Exception e){}
        try{
          if(carteActuelle.caseCarteDevant(joueur.returnXPerso(), joueur.returnYPerso(), joueur).returnPersoQuiOccupe().returnId() == 15 && petiteSoeur.returnVie() >= 0) // Petite soeur
          {
            derniereToucheAppuyee = -1;
            dial.changementVarPancarte();
            dernierMessagePancarte ="DIAL_INTRO";
          }
        }catch(Exception e){}
    }
    else if(pancarte == true && dial.returnProgRecrutement() == 0)
    {
      pancarte = false;
    }
  }
}