/*
 * Crée par Christian CHAUX le 08/04/2016
 * Dernières modifications le 02/07/2016
 */
 
 PImage iPierreCassable, iPierreIncassable, iArcher, iEscalierB, iEscalierH, iPorteH, iPorteV, iSolBois, iTrou, iPancarte, iPillier, iPassageSecret, iTrouBouche;
 PImage iPiegeOurs, iPiegeOursD;
 PImage iBrouillard; // Quand une zone n'est pas visible par le personnage
 PImage iHerbe, iEau, iSable, iBarriere;
 PImage iMage, iGuerrierH, iGuerrierB, iGuerrierG, iGuerrierD, iHealer, iSang, iVoleur, iElenia, iKya, iSoeur, iKlyx;
 PImage iObjetSol; // Objet au sol
 PImage textureManquante;
 PImage iSlime, iBerserker, iHealerEnnemi, iMannequin, iPoule;
 PImage fStatsPersos, fBoiteDialogue, fCaseInventaire, fGrandBoiteDialogue, fSelectLangue;
 PImage icAttaquer, icKick, icBuffAtt, icBouclier, icHeal;
 PImage iPotionVie, iPotionMana, iPotionVigueur, iPotionMalus, iCle;
 PImage iAmulette, iChocolat, iLivre, iPlanche, iBombe;
 PImage efBoostForce, efStun, efBouclier;
 PImage iFleche;
 
 void iniImages()
 {
    try
    {
      //textureManquante  = loadImage("Images/TextureManquante");
      iPierreCassable     = loadImage("Images/Pierre.png");
      iPierreIncassable   = loadImage("Images/Pierre_Incassable.png");
      iArcher             = loadImage("Images/Archer.png");
      iEscalierB          = loadImage("Images/EscaliersDescendant.png");
      iEscalierH          = loadImage("Images/EscaliersMontant.png");
      iPorteH             = loadImage("Images/Porte_H.png");
      iPorteV             = loadImage("Images/Porte_V.png");
      iSolBois            = loadImage("Images/Sol_Bois.png");
      iTrou               = loadImage("Images/Trou.png");
      iPancarte           = loadImage("Images/Pancarte.png");
      iPillier            = loadImage("Images/Pillier.png");
      iMage               = loadImage("Images/Mage.png");
      iHealer             = loadImage("Images/Healer.png");
      iGuerrierH          = loadImage("Images/GuerrierH.png");
      iGuerrierB          = loadImage("Images/GuerrierB.png");
      iGuerrierD          = loadImage("Images/GuerrierD.png");
      iGuerrierG          = loadImage("Images/GuerrierG.png");
      iSang               = loadImage("Images/Sang.png");
      iSlime              = loadImage("Images/Slime.png");
      iHerbe              = loadImage("Images/Herbe.png");
      iEau                = loadImage("Images/Eau.png");
      fStatsPersos        = loadImage("Images/FontInfosPersos.png");
      fBoiteDialogue      = loadImage("Images/BoiteDialogue.png");
      iBrouillard         = loadImage("Images/Brouillard.png");
      iObjetSol           = loadImage("Images/Etoile.png");
      fCaseInventaire     = loadImage("Images/CaseInventaire.png");
      icAttaquer          = loadImage("Images/IconeAttaquer.png");
      iPotionVie          = loadImage("Images/PotionVie.png");
      iPotionMana         = loadImage("Images/PotionMana.png");
      iPotionMalus        = loadImage("Images/PotionMalus.png");
      iPotionVigueur      = loadImage("Images/PotionVigueur.png");
      iPassageSecret      = loadImage("Images/PassageSecret.png");
      iVoleur             = loadImage("Images/Voleur.png");
      iCle                = loadImage("Images/Cle.png");
      iBerserker          = loadImage("Images/Berserker.png");
      iHealerEnnemi       = loadImage("Images/HealerEnnemi.png");
      iElenia             = loadImage("Images/Elenia.png");
      iKya                = loadImage("Images/Kya.png");
      iTrouBouche         = loadImage("Images/TrouBouche.png");
      iAmulette           = loadImage("Images/Amulette.png");
      iChocolat           = loadImage("Images/Chocolat.png");
      iLivre              = loadImage("Images/Livre.png");
      iPlanche            = loadImage("Images/Planches.png");
      iBombe              = loadImage("Images/Bombe.png");
      iPiegeOurs          = loadImage("Images/PiegeOurs.png");
      iPiegeOursD         = loadImage("Images/PiegeOursFerme.png");
      icKick              = loadImage("Images/IconeKick.png");
      icBuffAtt           = loadImage("Images/IconeBuffAttaque.png");
      icBouclier          = loadImage("Images/IconeBouclier.png");
      icHeal              = loadImage("Images/IconeHeal.png");
      iMannequin          = loadImage("Images/Mannequin.png");
      fGrandBoiteDialogue = loadImage("Images/GrandBoiteDialogue.png");
      efBoostForce        = loadImage("Images/EffetBoostForce.png");
      efStun              = loadImage("Images/EffetStun.png");
      efBouclier          = loadImage("Images/EffetBouclier.png");
      iSable              = loadImage("Images/Sable.png");
      iBarriere           = loadImage("Images/Barriere.png");
      iPoule              = loadImage("Images/Poule.png");
      fSelectLangue       = loadImage("Images/selectionLangue.png");
      iSoeur              = loadImage("Images/Soeur.png");
      iFleche             = loadImage("Images/Fleche.png");
      iKlyx               = loadImage("Images/Klyx");
    } catch(NullPointerException nfe) { // N'entre pas dedans
      dial.afficheBoiteErreur("Error, an image is not found. \nPlease check if the file is on the right folder.");
    }
 }
 
 void afficherImage(PImage imageALire, int x, int y)
 {
   image(imageALire, x, y);
 }
 
 void afficherPerso(PImage imageALire, int x, int y, Personnage perso) // Permet de gérer l'orientation du personnage
 {
   /*if(perso.returnDirectionRegarde() == 1)
   {
     rotate(HALF_PI);
     translate(x, y);
   }*/
   image(imageALire, x, y);
 }
 
 void afficherCasesCartes(PImage imageALire, int x, int y)
 {
   //println((menuP.tailleFenX()-ecart)/carteActuelle.returnNbColonnes() + " ; " + menuP.tailleFenY()/carteActuelle.returnNbLignes()); <-- Trop de perte de FPS...
   //imageALire.resize(carteActuelle.returnTailleCase(), carteActuelle.returnTailleCase());
   image(imageALire, x, y);
 }