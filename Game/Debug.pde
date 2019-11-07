/*
 * Crée par Christian CHAUX en début 2016
 * Dernières modifications le 04/07/2016
 */
 
import java.io.FileWriter;
import java.io.FileNotFoundException;

class Debug{
  Debug()
  {
    uDetruit = 0;
    uInstaKill = 0;
    uRestoreVie = 0;
    uTPSpawn = 0;
  }
  
  void montrerCase(byte x, byte y, color couleur)
  {
    fill(couleur);
    rect(x*carteActuelle.returnTailleCase(), y*carteActuelle.returnTailleCase(), carteActuelle.returnTailleCase(), carteActuelle.returnTailleCase());
  }
  
  void infosCase(Personnage perso)
  {
    if(xConsole != perso.returnXPerso() || yConsole != perso.returnYPerso())
    {
      println("(" + perso.returnXPerso() + ";" + perso.returnYPerso() + "). Valeur: " + carteActuelle.valeurCase(perso.returnXPerso(), perso.returnYPerso()));
      try{println("Valeur case devant: " + carteActuelle.valeurCaseDevant(perso.returnXPerso(), perso.returnYPerso(), perso) + "\n");}catch(Exception NullPointerException){}
    }
    xConsole = perso.returnXPerso();
    yConsole = perso.returnYPerso();
  }
  
  void deverouillePortes()
  {
    if(key == '0' && carteActuelle.valeurCaseDevant(joueur.returnXPerso(), joueur.returnYPerso(), joueur) == 'L') // Ne marche pas
    {
      dial.changementVarPancarte();
      d.porteDeverouille();
      joueur.ouvrirPorte();
    }
  }
  
  void actions()
  {
    if(modeDeJeu != 0 && modeDeJeu != 4 && debugFonctionsAutorise)
    {
      if(key == '+') // Tp au spawn
      {
        ecran = 1;
        modeDeJeu = 0;
        joueur.defEmplacementPerso((byte)18, (byte)16);
        uTPSpawn++;
      }
      else if(key == '-') // Restaure toute la vie du joueur.
      {
        joueur.diminuerVie(-30000, null);
        uRestoreVie++;
      }
      else if(key == '*') // Détruit obstacle
      {
        carteActuelle.changerValeurCaseDevant(joueur.returnXPerso(), joueur.returnYPerso(), '.', joueur);
        carteActuelle.actualiserCaseDevant(joueur.returnXPerso(), joueur.returnYPerso(), joueur);
        uDetruit++;
        if(modeDeJeu == 2 && dansLeNoir == false || modeDeJeu == 1) carteActuelle.enleverBrouillard(joueur.returnDirectionRegarde(), joueur.returnXPerso(), joueur.returnYPerso());
      }
      else if(key == '/' && carteActuelle.caseCarteDevant(joueur.returnXPerso(), joueur.returnYPerso(), joueur).returnEstAttaquable()) // Inflige d'énorme dégats
      {
        for(byte i = 0 ; i < ennemis.size() ; i++)
        {
          try{
            if(ennemis.get(i).returnXPerso() == carteActuelle.caseCarteDevant(joueur.returnXPerso(), joueur.returnYPerso(), joueur).returnX()
            && ennemis.get(i).returnYPerso() == carteActuelle.caseCarteDevant(joueur.returnXPerso(), joueur.returnYPerso(), joueur).returnY())
              environnement.attaquerCible(ennemis.get(i));
          } catch(NullPointerException ne) {} // Si une case du tableau est vide, considérer le faite de remplacer par des ArrayList ?
        }
        uInstaKill++;
      }
    }
  }
  
  void deplacements()
  {
    if(ecran > 0)
    {
     if (key == '8')
      {
        if(carteActuelle.caseCarteDevant(joueur.returnXPerso(), joueur.returnYPerso(), joueur).returnEstOuvrable()) // Peut etre réduit en étant mis dans une fonction.
        {
          joueur.ouvrirPorte();
          carteActuelle.actualiserCaseDevant(joueur.returnXPerso(), joueur.returnYPerso(), joueur);
        }
        else
        {
          joueur.changementDirectionRegarde((byte)0);
          joueur.modifEmplacementPerso((byte)0, (byte)-1);
          }
        }
      }
      if (key == '2')
      {
        if(carteActuelle.caseCarteDevant(joueur.returnXPerso(), joueur.returnYPerso(), joueur).returnEstOuvrable())
        {
          joueur.ouvrirPorte();
          carteActuelle.actualiserCaseDevant(joueur.returnXPerso(), joueur.returnYPerso(), joueur);
        }
        else
        {
          joueur.changementDirectionRegarde((byte)1);
          joueur.modifEmplacementPerso((byte)0, (byte)1);
        }
      }
      if (key == '4')
      {
        if(carteActuelle.caseCarteDevant(joueur.returnXPerso(), joueur.returnYPerso(), joueur).returnEstOuvrable())
        {
          joueur.ouvrirPorte();
          carteActuelle.actualiserCaseDevant(joueur.returnXPerso(), joueur.returnYPerso(), joueur);
        }
        else
        {
          joueur.changementDirectionRegarde((byte)2);
          joueur.modifEmplacementPerso((byte)-1, (byte)0);
        }
      }
      if (key == '6')
      {
        if(carteActuelle.caseCarteDevant(joueur.returnXPerso(), joueur.returnYPerso(), joueur).returnEstOuvrable())
        {
          joueur.ouvrirPorte();
          carteActuelle.actualiserCaseDevant(joueur.returnXPerso(), joueur.returnYPerso(), joueur);
        }
        else
        {
          joueur.changementDirectionRegarde((byte)3);
          joueur.modifEmplacementPerso((byte)1, (byte)0);
        }
      }
    }
  short uDetruit, uInstaKill, uRestoreVie, uTPSpawn;
  int xConsole = -1, yConsole = -1;
  boolean dejaEcritTxt = false;
  
  short returnUDetruit(){return uDetruit;}
  short returnUInstaKill(){return uInstaKill;}
  short returnURestoreVie(){return uRestoreVie;}
  short returnUTPSpawn(){return uTPSpawn;}
}