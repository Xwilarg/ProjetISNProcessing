/*
 * Crée par Christian CHAUX en début 2016
 * Dernières modifications le 23/07/2016
 */

class Personnage
{
  String nom;
  short vie, vieMax;
  short mana, manaMax;
  short xp, xpMax;
  byte niveau;
  short force;
  byte xPerso;
  byte yPerso;
  byte impatience;
  byte boostDegats;
  boolean dansEquipe;
  boolean empoisonne;
  boolean utiliseMana; // true: mana, false: vigueur
  boolean utiliseBouclier; // Guerrier
  char sexe;
  byte quelEquipe; // 1: joueur & ses alliées ; 2: ennemis ; 3: Persos neutre || Si un ennemi est dans l'équipe 3, il s'agit d'un "ennemi allié" qui pourra intérargir avec le joueur.
  IA IABot;
  IA ordre; // Pour donner des ordres au IA (fuire, suivre joueur, etc..). Est prioritaire sur IABot.
  short dernierDegatsInfliges;
  byte id; // 0: environnement, 1: joueur, 2: thrug, 3: saria, 4: gandur, 5: mannequin, 6: ennemis, 7: boss, 8: mimic, 9: ennemisDeux, 10: kya, 11: elenia, 12: berserker, 13: healer ennemi, 14: poule, 15: petite soeur
  // 16: klyx
  short or;
  PImage imagePerso;
  byte classe = 0; // 0: rien ; 1: guerrier ; 2: mage ; 3: healer ; 4: voleur ; 5: archer
  Inventaire inventaire;
  boolean estDecouvert;
  Arme arme;
  short amitie;
  Compteur compAttUn     = new Compteur();
  Compteur compAttDeux   = new Compteur();
  Compteur compAttTrois  = new Compteur();
  Compteur compAttQuatre = new Compteur();
  Compteur estStun       = new Compteur();
  PImage attUn, attDeux, attTrois, attQuatre; // Icone des attaques.
  
  short ennemisTues;
  
  Personnage(String nom, short vie, short force, short mana, byte xPerso, byte yPerso, byte quelEquipe, char sexe, byte id)
  {
    this.nom = nom;
    this.vie = vie;
    vieMax = vie;
    this.force = force;
    this.xPerso = xPerso;
    this.yPerso = yPerso;
    impatience = 0;
    dansEquipe = false;
    this.quelEquipe = quelEquipe;
    this.mana = mana;
    manaMax = mana;
    xp = 0;
    xpMax = 30;
    niveau = 1;
    this.sexe = sexe;
    this.id = id;
    IABot = new IA(this);
    defIA();
    ennemisTues = 0;
    or = 0;
    defClasse();
    defImagePerso();
    inventaire = new Inventaire(this);
    if(id > 5)
      estDecouvert = false;
    else
      estDecouvert = true;
    empoisonne = false;
    arme = new Arme();
    amitie = 0;
    utiliseMana = false;
    utiliseBouclier = false;
    attUn = fCaseInventaire;
    attDeux = fCaseInventaire;
    attTrois = fCaseInventaire;
    attQuatre = fCaseInventaire;
    boostDegats = 1;
  }
  
  void defClasse()
  {
    classe = 0;
  }
  
  void defImagePerso()
  {
    println("ID :" + id);
    if(id == 1 || id == 2)
      imagePerso = iGuerrierH;
    else if(classe == 2)
      imagePerso = iMage;
    else if(id == 3)
      imagePerso = iHealer;
    else if(id == 6)
      imagePerso = iArcher;
    else if(id == 8)
      imagePerso = loadImage("Images/CoffreBoisFerme.png");
    else if(id == 9)
      imagePerso = iSlime;
    else if(id == 10)
      imagePerso = iKya;
    else if(id == 11)
      imagePerso = iElenia;
    else if(id == 12)
      imagePerso = iBerserker;
    else if(id == 13)
      imagePerso = iHealerEnnemi;
    else if(id == 14)
      imagePerso = iPoule;
    else if(id == 15)
      imagePerso = iSoeur;
    else if(id == 16)
      imagePerso = iKlyx;
    else
      imagePerso = iMannequin;
  }
  
  void defIA()
  {
    if(id == 1 || id == 8 && quelEquipe == 1 || id == 5) // Joueur, mimic amical, mannequin d'entrainement
      IABot.defQuelIA((byte)0);
    // else if(id == 6/* || id == 7 || id == 9*/) // boss, ennemi 1 et ennemi 2.
       // IABot.defQuelIA((byte)1); // rotation IA
    else if(id == 3 && quelEquipe == 1) // Saria
      IABot.defQuelIA((byte)2);
    /*else if(id == 7)
      IABot.defQuelIA((byte)3);*/ // IA boss
    else if(id == 2 || id == 9) // Thrug
      IABot.defQuelIA((byte)4);
    else if(id == 12 || id == 3 && quelEquipe == 2) // Berserker
      IABot.defQuelIA((byte)5);
    else if(id == 13) // Healer ennemi
      IABot.defQuelIA((byte)6);
    else if(id == 4) // Gandur, IA 'flashHealer'
      IABot.defQuelIA((byte)7);
    else if(id == 10) // Kya
      IABot.defQuelIA((byte)8);
    else if(id == 14) // Fuire perso plus proche (poule)
      IABot.defQuelIA((byte)9);
    else if(id == 6) // Archer
      IABot.defQuelIA((byte)10);
    else if(id == 6) // Klyx
      IABot.defQuelIA((byte)11);
    else
      IABot.defQuelIA((byte)99);
  }
  
  void botFaireAction()
  {
    if(estDecouvert) // Que si l'IA n'est pas dans le brouillard.
      IABot.faireAction();
    
    if(!estDecouvert && carteActuelle.caseEstCache(xPerso, yPerso) == 0)
      estDecouvert = true;
  }
 
  void modifEmplacementPerso(byte decalageX, byte decalageY)
  {
    if(deplacementPossible((byte)(xPerso + decalageX), (byte)(yPerso + decalageY)) && peuxAttaquerSoisMeme()) // peuxAttaquerSoisMeme() permet de verif si le joueur n'est pas stun.
    {
      xPerso += decalageX;
      yPerso += decalageY;
      carteActuelle.actualiserCarte();
      if(dansLeNoir && this == joueur) carteActuelle.enleverBrouillardAutour(joueur);
      for(byte i = 0 ; i < pieges.size() ; i++)
      {
        try
        {
          if(carteActuelle.caseCarte(pieges.get(i).returnX(), pieges.get(i).returnY()).rPerso())
          {
            pieges.get(i).effet(carteActuelle.caseCarte(pieges.get(i).returnX(), pieges.get(i).returnY()).returnPersoQuiOccupe()); // Lorsque le joueur marche sur un piège
            if(joueur.returnVie() <= 0) dial.gameOver("VIE_NULL", "TOMBE_PIEGE");
          }
        } catch(IndexOutOfBoundsException ie) {}
      }
    }
    else if(carteActuelle.valeurCase((byte)(xPerso + decalageX), (byte)(yPerso + decalageY)) == 'P')
      ouvrirPorte();
  }
  
  boolean reculer(Personnage celonQui)
  {
    boolean aReturn;
    if(celonQui.returnDirectionRegarde() == 0)
    {
      if(celonQui.deplacementPossible(xPerso, (byte)(yPerso-1)))
      {
        yPerso--;
        aReturn = true;
      }
      else
        aReturn = false;
    }
    else if(celonQui.returnDirectionRegarde() == 1)
    {
      if(celonQui.deplacementPossible(xPerso, (byte)(yPerso+1)))
      {
        yPerso++;
        aReturn = true;
      }
      else
        aReturn = false;
    }
    else if(celonQui.returnDirectionRegarde() == 2)
    {
      if(celonQui.deplacementPossible((byte)(xPerso-1), yPerso))
      {
        xPerso--;
        aReturn = true;
      }
      else
        aReturn = false;
    }
    else // 3
    {
      if(celonQui.deplacementPossible((byte)(xPerso+1), yPerso))
      {
        xPerso++;
        aReturn = true;
      }
      else
        aReturn = false;
    }
    carteActuelle.actualiserCarte();
    if(dansLeNoir && this == joueur) carteActuelle.enleverBrouillardAutour(joueur);
    for(byte i = 0 ; i < pieges.size() ; i++)
    {
      try
      {
        if(carteActuelle.caseCarte(pieges.get(i).returnX(), pieges.get(i).returnY()).rPerso())
        {
          pieges.get(i).effet(carteActuelle.caseCarte(pieges.get(i).returnX(), pieges.get(i).returnY()).returnPersoQuiOccupe()); // Lorsque le joueur marche sur un piège
          if(joueur.returnVie() <= 0) dial.gameOver("VIE_NULL", "TOMBE_PIEGE");
        }
      } catch(IndexOutOfBoundsException ie) {}
    }
    return aReturn;
  }
  
  boolean deplacementPossible(byte x, byte y)
  {
    if(carteActuelle.caseCarte(x, y).returnEstTraversable())
      return true;
    else
      return false;
  }
  void defEmplacementPerso(byte emplX, byte emplY)
  {
    xPerso = emplX;
    yPerso = emplY;
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
         short degats = (short)(force+random(5)-3);
         if(degats < 0) degats = 0;
          
         cible.diminuerVie((short)(degats), this); // random: intervalle de dégats
         dernierDegatsInfliges = degats;
         if(cible == joueur) dernierQuiAttaqueJoueur = this;
          
         monstreTue(cible);
      }
      else
        genererAffDgts(99999); // Out of mana
      }
    } catch(Exception e){}
  }
  void attaquerCible(Personnage cible)
  {
    if(vie > 0)
    {
      short degats = (short)(force+random(10)-5);
      if(degats < 0) degats = 0;
        
      cible.diminuerVie(degats, this); // random: intervalle de dégats
      dernierDegatsInfliges = degats;
      
      monstreTue(cible);
    }
  }
  
  void attaquerSec()
  {}
  
  void attaquerTer()
  {}
  
  void attaquerLast()
  {}
  
  void monstreTue(Personnage cible)
  {
    if(cible.returnVie() == 0)
      {
        byte orGagne = (byte)(random(20));
        byte xpGagne = 10;
        
        ennemisTues++;
        xp += xpGagne;
        if(xp >= xpMax)
          lvlUp();
        or+=orGagne;
        genererAffDgts(100000+orGagne);
        genererAffDgts(200000+xpGagne);
        tuerPerso(cible);
        carteActuelle.diminuerNbEnnemis();
      }
  }

  void tuerPerso(Personnage cible)
  {
    dansEquipe = false;
    persoMort.add(cible);
    ennemis.remove(cible);
    equipe.remove(cible);
    persoNeutre.remove(cible);
    ennemisVisible.remove(cible);
    if(joueur.returnVie() <= 0) dial.gameOver("VIE_NULL", "TUER_ENNEMI");
  }
  
  boolean peuxAttaquer(Personnage cible)
  {
    if(carteActuelle.caseCarteDevant(xPerso, yPerso, this).rPerso())
    {
      if(carteActuelle.caseCarteDevant(xPerso, yPerso, this).returnPersoQuiOccupe().returnEquipe() == quelEquipe) return false;
    }
    else return false;
    if(cible.rUtiliseBouclier())
    {
      byte estProtege = (byte)(random(10)+1);
      if(estProtege != 1) return false;
    }
    if(estStun.estFini() && vie > 0)
      return true;
    else
      return false;
  }
  
  boolean peuxSoigner(Personnage cible)
  {
    if(carteActuelle.caseCarteDevant(xPerso, yPerso, this).rPerso())
    {
      if(carteActuelle.caseCarteDevant(xPerso, yPerso, this).returnPersoQuiOccupe().returnEquipe() != quelEquipe) return false;
    }
    else return false;
      
    if(estStun.estFini() && vie > 0)
      return true;
    else
      return false;
  }
  
  boolean peuxAttaquerSoisMeme()
  {
    if(estStun.estFini() && vie > 0)
      return true;
    else
      return false;
  }
  
  void gagneOr(short valeur)
  {
    or += valeur;
    genererAffDgts(100000+valeur);
  }
  
  void lvlUp()
  {
    vieMax +=30;
    manaMax += 20;
    xp = (short)(xpMax - xp);
    xpMax += 50;
    vie = vieMax;
    if(utiliseMana && !pasDeMana || !utiliseMana) // event 4
      mana = manaMax;
    niveau++;
  }
  
  void afficherVie(short tailleBarreVie, boolean estAllie, int compteur)
  {
    if(estDecouvert)
    {
      if(tailleBarreVie < 0)
        tailleBarreVie = 0;
      
      if(tailleBarreVie > 200)
      {
        /*if(tailleBarreVie > 1000) fill(0);
        else if(tailleBarreVie > 1000) fill(255, 255, 0);
        fill(0, 0, 255);
        rect(xPerso*carteActuelle.returnTailleCase()-camJoueur.returnPointXGauche()*carteActuelle.returnTailleCase(),
        yPerso*carteActuelle.returnTailleCase()-camJoueur.returnPointYGauche()*carteActuelle.returnTailleCase(), 200/2, 5);
        if(tailleBarreVie > 200)afficherVie((short)(tailleBarreVie-200), estAllie);*/
        afficherVie((short)(tailleBarreVie-200), estAllie, compteur+1);
      }
      else
      {
        if(estAllie)
          fill(0, 100, 0);
        else
          fill(255, 0, 0);
          
        rect(xPerso*carteActuelle.returnTailleCase()-camJoueur.returnPointXGauche()*carteActuelle.returnTailleCase(),
        yPerso*carteActuelle.returnTailleCase()-camJoueur.returnPointYGauche()*carteActuelle.returnTailleCase(), tailleBarreVie/2, 5);
        
        textSize(10);
        fill(255, 255, 0);
        text("x" + compteur, xPerso*carteActuelle.returnTailleCase()-camJoueur.returnPointXGauche()*carteActuelle.returnTailleCase() -7,
        yPerso*carteActuelle.returnTailleCase()-camJoueur.returnPointYGauche()*carteActuelle.returnTailleCase(), tailleBarreVie/2 -5);
      }
    }
  }
  
  void ouvrirPorte()
  {
    if(carteActuelle.caseCarteDevant(xPerso, yPerso, this).returnEstOuvrable())
    {
      carteActuelle.changerValeurCaseDevant(xPerso, yPerso, '.', this);
      if(modeDeJeu == 2 && dansLeNoir == false || modeDeJeu == 1)
        carteActuelle.enleverBrouillard(returnDirectionRegarde(), returnXPerso(), returnYPerso());
    }
  }
  
  void genererAffDgts(int valeur)
  {
    if(curseurDgts > dgts.length-1)
      curseurDgts = 0;
      
    dgts[curseurDgts].activer(valeur, xPerso, yPerso);
    curseurDgts++;
  }
  
  void diminuerVie(int valeur, Personnage attaquant)
  {     
    genererAffDgts(valeur);
    if(this == mimic && attaquant == joueur) // Si on frappe un Mimic, son amitié envers le joueur descend.
      mimic.modifAmitie((byte)-1);
    if(quelEquipe == 1 && valeur > 0)
      sansPerdreVie = false;
    
      
    if(valeur < 100000)
    vie -= valeur;
    if(vie < 0)
    {
      vie = 0;
      carteActuelle.actualiserCase(xPerso, yPerso);
      tuerPerso(this);
    }
    if(vie > vieMax)
      vie = vieMax;
  }
  
  void restaureMana(byte valeur)
  {
    if(utiliseMana && !pasDeMana || !utiliseMana) // event 4
    {
      joueur.diminuerVie(400000 + valeur, this);
      mana += valeur;
      if(mana > manaMax) mana = manaMax;
    }
  }
  
  void restaureVigueur(byte valeur)
  {
    joueur.diminuerVie(500000 + valeur, this);
    mana += valeur;
    if(mana > manaMax) mana = manaMax;
  }
  
  void restaure()
  {
    if(utiliseMana && !pasDeMana || !utiliseMana) // event 4
    {
      mana++;
      if(mana > manaMax) mana = manaMax;
    }
  }
  
  void verifEvent()
  {}
  
  void changementDirectionRegarde(byte direction)
  {
    if(this == joueur)
    {
      if(direction == 0) imagePerso = iGuerrierH;
      else if(direction == 1) imagePerso = iGuerrierB;
      else if(direction == 2) imagePerso = iGuerrierG;
      else if(direction == 3) imagePerso = iGuerrierD;
    }
    directionRegarde = direction;
  }
  
  byte directionRegarde; // 0 haut, 1 bas, 2 gauche, 3 droite
  
  void stunPerso(){estStun.initialiser((byte)2);}
  boolean estStun(){if(!estStun.estFini()) return true; else return false;}
  PImage returnImagePerso(){return imagePerso;}
  void augmenterImpatience(byte valeur){impatience+=valeur;}
  String returnNom(){return nom;}
  byte returnImpatience(){return impatience;}
  byte returnDirectionRegarde(){return directionRegarde;}
  byte returnXPerso(){return xPerso;}
  byte returnYPerso(){return yPerso;}
  short returnVie(){return vie;}
  short returnVieMax(){return vieMax;}
  short returnMana(){return mana;}
  short returnXp(){return xp;}
  short returnOr(){return or;}
  byte returnNiveau(){return niveau;}
  byte returnEquipe(){return quelEquipe;}
  byte returnId(){return id;}
  boolean returnDansEquipe(){return dansEquipe;}
  byte viePerdu(){return (byte)(vieMax-vie);}
  void resetMana(){mana = 0;}
  void changerNom(String nouvNom){nom = nouvNom;}
  void boosterForce(){boostDegats = 2;}
  Compteur progCompteur(byte lequel)
  {
    if(lequel == 1) return compAttUn;
    else if(lequel == 2) return compAttDeux;
    else if(lequel == 3) return compAttTrois;
    else if(lequel == 4) return compAttQuatre;
    else return null;
  }
  void augmenterXp(short valeur)
  {
    xp+=valeur;
    if(xp >= xpMax) lvlUp();
  }
  short returnPourcentVie()
  {
    if(vie > 0) return (short)((vie*100)/vieMax);
    else return 0;
  }
  short returnPourcentMana()
  {
    if(mana > 0) return (short)((mana*100)/manaMax);
    else return 0;
  }
  short returnPourcentXp()
  {
    if(xp > 0) return (short)((xp*100)/xpMax);
    else return 0;
  }
  void changerEtatDansEquipe(){dansEquipe = !dansEquipe;}
  
  String returnManaVig(){return d.affichageStats("Vigueur");}
  byte returnValeurClasse(){return classe;}
  String returnClasse()
  {
    if(sexe == 'F') return d.affichageStats("Aventurière");
    else return d.affichageStats("Aventurier");
  }
  
  void modifAmitie(byte valeur)
  {
    amitie += valeur;
  }
  short rAmitie(){return amitie;}
  
  boolean returnUtiliseMana(){return utiliseMana;}
  boolean rUtiliseBouclier(){return utiliseBouclier;}
  byte rBoostForce(){return boostDegats;}
  PImage rIconeAtt(byte lequel)
  {
    if(lequel == 1) return attUn;
    else if(lequel == 2) return attDeux;
    else if(lequel == 3) return attTrois;
    else return attQuatre;
  }
  
  Inventaire returnInventaire(){return inventaire;}
  
  IA returnOrdre(){return ordre;}
}