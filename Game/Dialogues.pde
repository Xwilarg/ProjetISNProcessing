/*
 * Crée par Christian CHAUX en début 2016
 * Dernières modifications le 21/07/2016
 */

class Dialogues
{
  String affichageStats(String aTrad)
  {
    if (aTrad.equals("Guerrier") || aTrad.equals("Guerrière"))
    {
      if (langue == 2) return aTrad;
      else if (langue == 3) return "Woj";
      else return "Warrior";
    } else if (aTrad.equals("Soigneur") || aTrad.equals("Soigneuse"))
    {
      if (langue == 2) return aTrad;
      else if (langue == 3) return "Uzdrowiciel";
      else return "Healer";
    } else if (aTrad.equals("Aventurier") || aTrad.equals("Aventurière"))
    {
      if (langue == 2) return aTrad;
      else if (langue == 3) return "Poszukiwacz przygód";
      else return "Fighter";
    } else if (aTrad.equals("Archer") || aTrad.equals("Archère"))
    {
      if (langue == 2) return aTrad;
      else return "Archer";
    } else if (aTrad.equals("Voleur") || aTrad.equals("Voleuse"))
    {
      if (langue == 2) return aTrad;
      else return "Thief";
    } else if (aTrad.equals("Mage"))
    {
      if (langue == 2) return aTrad;
      else if (langue == 3) return "Czarnoksiężnik";
      else return "Wizard";
    } else if (aTrad.equals("Vie: "))
    {
      if (langue == 2) return aTrad;
      else if (langue == 3) return "Życie: ";
      else return "Life: ";
    } else if (aTrad.equals("Vigueur"))
    {
      if (langue == 2) return aTrad;
      else if (langue == 3) return "Tężyzna fizyczna";
      else return "Vigor";
    } else if (aTrad.equals("XP"))
    {
      if (langue == 3) return "PD";
      else return aTrad;
    } else if (aTrad.equals(" niveau "))
    {
      if (langue == 2) return aTrad;
      else if (langue == 3) return " poziom ";
      else return " level ";
    } else if (aTrad.equals("Niveau "))
    {
      if (langue == 2) return aTrad;
      else if (langue == 3) return "Poziom ";
      else return "Level ";
    } else if (aTrad.equals("Or"))
    {
      if (langue == 2) return aTrad;
      else if (langue == 3) return "Sztuk złota";
      else return "Gold";
    } else if(aTrad.equals("Emplacement vide"))
    {
      if (langue == 2) return aTrad;
      else if (langue == 3) return "Brak towarzysza";
      else return "Empty emplacement";
    }
    else if (aTrad.equals("Current Order"))
    {
      if (langue == 2) return "Ordre Actuel";
      else return aTrad;
    }
    return aTrad;
  }

  String titre(String aTrad)
  {
    if (aTrad.equals("le Téméraire"))
    {
      if (langue == 2) return aTrad;
      else if(langue == 3) return "Krótkowzroczny";
      else return "the Reckless";
    }
    if (aTrad.equals("la Prudente"))
    {
      if (langue == 2) return aTrad;
      else if (langue == 3) return "Rozważna";
      else return "the Prudent";
    }
    if (aTrad.equals("le Puissant"))
    {
      if (langue == 2) return aTrad;
      else if (langue == 3) return "Niezwyciężony";
      else return "the Powerful";
    }
    if (aTrad.equals("Joueur"))
    {
      if (langue == 2) return aTrad;
      else if(langue == 3) return "Gracz";
      else return "Player";
    }
    return aTrad;
  }
  
  String miniMapNonDispo()
  {
    if (langue == 2) return "Mini map\nnon disponible.";
    else if(langue == 3) return "Minimapa\nniedostępna";
    else return "Mini map\nnot available.";
  }
  
  String dialogEvent()
  {
    if(dansLeNoir) 
    {
      if(langue == 2) return "Je peux à peine voir quelque chose...";
      else if(langue == 3) return "Prawie niczego nie mogę dostrzec...";
      else return "I barely can see something...";
    }
    else if(dansLeFroid)
    {
      if(langue == 2) return "J'ai si froid... Je vais mourir si je ne pars pas rapidement d'ici.";
      else if(langue == 3) return "Zimno... Musimy prędko się stąd wydostać... Zaraz zamarznę.";
      else return "I'm so cold... I will die if I don't quickly go out of here.";
    }
    else if(sariaInsane)
    {
      if(langue == 2) return "Saria, est-ce que tu va bien ?";
      else if(langue == 3) return "Saria, czy wszystko w porządku ?";
      else return "Saria, are you alright ?";
    }
    else if(pasDeMana)
    {
      if(langue == 2) return "Quelque chose ne va pas... Comme si il y avais un grand champs anti-magie...";
      else if(langue == 3) return "Czuję się dziwnie... Jakby gdzieś tutaj było pole antymagiczne...";
      else return "Something is not normal... Like if there was a big anti-mana field...";
    }
    else if(seulementBerserker)
    {
      if(langue == 2) return "Je peux sentir le sol trembler...";
      else if(langue == 3) return "Podłoga drży...";
      else return "I can feel the floor shaking...";
    }
    else
    {
      if(langue == 2) return "Tout semble aller bien. Allons-y !";
      else if(langue == 3) return "Wszystko wydaje się w porządku. Ruszajmy !";
      else return "Everything seems to be fine. Let's go !";
    }
  }

  String astuce()
  {
    if (astuceEcranChargement == 0)
      astuceEcranChargement = (byte)(Math.random()*8+1);
    switch(astuceEcranChargement)
    {
    case 1 :
      if (langue == 2) return "Conseil: Restez près de vos alliés, il ne sont pas encore très bon pour éviter les murs...";
      else if (langue == 3) return "Porada: Trzymaj się blisko swej drużyny. Nadal lubią wchodzić w ściany...";
      else return "Tip: Stay close your team, they aren't really good to avoid walls yet...";

    case 2 :
      if (langue == 2) return "Conseil: Prenez bien soin de visiter entièrement les niveaux, il serait dommage de rater des coffres.";
      else if(langue == 3) return "Porada: Zadbaj o to, by zwiedzić całe lochy. Wielką stratą byłoby przeoczenie skrzyń.";
      else return "Tip: Take good care of visiting entirely the levels, it would be bad to miss some chests.";

    case 3 :
      if (langue == 2) return "Conseil: Mangez 5 fruits et légumes par jour.";
      else if (langue == 3) return "Porada: Jedz 5 porcji owoców i warzyw dziennie.";
      else return "Tip: Eat 5 fruits and vegetables everyday.";
      
    case 4 :
      if (langue == 2) return "Conseil: Varsovie est la capital de la Pologne.";
      else if(langue == 3) return "Porada: Warszawa jest stolicą Polski.";
      else return "Tip: Warsaw is the capital of the Poland.";
      
    case 5 :
      if (langue == 2) return "Conseil: Certains personnages peuvent avoir des capacités cachées.";
      else return "Tip: Some characters can have hidden capacities.";
      
    case 6 :
      if (langue == 2) return "Conseil: Essayez de ne pas gacher vos bombes/planches, elles vous serront très utile si un mur/trou vous empêche d'avancer.";
      else if(langue == 3) return "Porada: Nie marnuj swych bomb i desek, gdyż mogą okazać się przydatne, gdy mury lub dziury uniemożliwiają dalszą wyprawę.";
      else return "Tip: Don't waste your bombs/boards, they would be useful is a wall/pit prevents you to move forward.";
      
    case 7 :
      if (langue == 2) return "Conseil: Le niveau 5 est pratiquement impossible à réussir, mais l'atteindre est déja un exploit en soit. Essayez de faire le meilleur score que vous pouvez :).";
      else if(langue == 3) return "Porada: Pokonanie 5 poziomu jest niemal niemożliwe do wykonania. Mimo to, postaraj się uzyskać największy wynik.";
      else return "Tip: Beat the level 5 is nearly impossible, but reaches it is already an exploit. Try to do the best score you can :).";
      
    case 8 :
      if (langue == 2) return "Conseil: Le jeu n'est pas 'impossible'. Si vous trouvez une fonctionnalité trop dur, peut-être que vous ne faîtes pas quelque chose de la bonne façon ?.";
      else if(langue == 3) return "Porada: Gra nie jest 'niemożliwa'. Jeżeli uznasz, że mechanika jest zbyt trudna wiedz, że robisz coś źle. ";
      else return "Tip: The game is not 'impossible'. If you find a functionality too hard, maybe you don't do something the right way ?";

    default :
      return "";
    }
  }
  /*
  text("The informations sent are the version of your game, your score and the nickname you wrote in the beginning of the game.", coteG+20+35, coteH+20+30);
  text("Enable debug's functions will disable the online scoarboard and the achievements.", coteG+20+35, coteH+20+85);
  text("Once activated, this option can't be disable.", coteG+20+35, coteH+20+95);
  text("Not available yet.", coteG+20+35, coteH+20+140);*/
  String ecranOptions(byte valeur)
  {
    if (valeur == 1)
    {
      if(langue == 3) return "Opcje:";
      else return "Options:";
    }
    else if (valeur == 2)
    {
      if(langue == 2) return "Envoyer les scores au serveur";
      else if(langue == 3) return "Wyślij wyniki do serwera.";
      else return "Send scores to the server";
    }
    else if (valeur == 3)
    {
      if(langue == 2) return "Activer/Désactiver les fonctions de debug";
      else if(langue == 3) return "Włącz/Wyłącz opcje debugowania.";
      else return "Enable/Disable debug's functions";
    }
    else if (valeur == 4)
    {
      if(langue == 2) return "Pleine écran";
      else if(langue == 3) return "Pełny ekran";
      else return "Fullscreen";
    }
    else if (valeur == 5)
    {
      if(langue == 2) return "Les informations envoyés sont la version de votre jeu, votre score et le pseudo que vous avez entrée en début de partie.";
      else if(langue == 3) return "Informacje wysyłane przez grę zawierają: wersję gry, wynik oraz pseudonim gracza.";
      else return "The informations sent are the version of your game, your score and the nickname you wrote in the beginning of the game.";
    }
    else if (valeur == 6)
    {
      if(langue == 2) return "Activer les fonctions de debug désactivera le tableau des scores en ligne et les succès.";
      else if(langue == 3) return "Włączenie opcji debugowania wyłączy tablicę wyników w internecie oraz osiągnięcia.";
      else return "Enable debug's functions will disable the online scoarboard and the achievements.";
    }
    else if (valeur == 7)
    {
      if(langue == 2) return "Une fois activé, cette fonction ne peut pas être désactivé.";
      else if(langue == 3) return "Wraz z włączeniem, opcja ta nie może być wyłączona.";
      else return "Once activated, this option can't be disable.";
    }
    else if (valeur == 8)
    {
      if(langue == 2) return "Les fonctions ne debug peuvent ne pas être disponible à certains endroits.";
      else if(langue == 3) return "Funkcje debugowania mogą nie działać w pewnych lokacjach.";
      else return "Debug's functions may not be available in some places.";
    }
    else if (valeur == 9)
    {
      if(langue == 2) return "Non disponible pour le moment.";
      else if(langue == 3) return "Jeszcze niedostępne.";
      else return "Not available yet.";
    }
    else if (valeur == 10)
    {
      if(langue == 2) return "Modifier les touches.";
      else if(langue == 3) return "Ustawienia klawiszy.";
      else return "Rebind keys.";
    }
    else return "ERROR";
  }
  
  String affScore(byte valeur)
  {
    if(valeur == 1)
    {
      if(langue == 3) return "Wynik:";
      return "Score:";
    }
    else if(valeur == 2)
    {
      if(langue == 2) return "Niveaux parcourus: ";
      else if(langue == 3) return "Przebyte lochy: ";
      else return "Levels traveled: ";
    }
    else if(valeur == 3)
    {
      if(langue == 2) return "Or gagné: ";
      else if(langue == 3) return "Zarobione złoto: ";
      else return "Gold earned: ";
    }
    else if(valeur == 4)
    {
      if(langue == 2) return "Niveau du joueur: ";
      else if(langue == 3) return "Poziom gracza: ";
      else return "Player's level: ";
    }
    else if(valeur == 5)
    {
      if(langue == 2) return "Commande de debug ; Blocs détruits: ";
      else if(langue == 3) return "Komenda debugowania ; Zniszczone bloki: ";
      else return "Debug's command ; Blocs destroyed: ";
    }
    else if(valeur == 6)
    {
      if(langue == 2) return "Commande de debug ; Ennemis tués: ";
      else if(langue == 3) return "Komenda debugowania ; Zabici przeciwnicy: ";
      else return "Debug's command ; Enemis killed: ";
    }
    else if(valeur == 7)
    {
      if(langue == 2) return "Commande de debug ; Téléportation au spawn: ";
      else if(langue == 3) return "Komenda debugowania ; Teleportacja do miejsca odrodzenia: ";
      else return "Debug's command ; Teleportation to spawn: ";
    }
    else if(valeur == 8)
    {
      if(langue == 2) return "Commande de debug ; Insta-regen: ";
      else if(langue == 3) return "Komenda debugowania ; Natychmiastowa regeneracja: ";
      else return "Debug's command ; Insta-regen: ";
    }
    else if(valeur == 9)
    {
      if(langue == 2) return "Infos supplémentaires: ";
      else if(langue == 3) return "Dodatkowe informacje: ";
      else return "Additionnal informations: ";
    }
    else if(valeur == 10)
    {
      return "FPS min:";
    }
    else if(valeur == 11)
    {
      if(langue == 2) return "Meilleurs scores: ";
      else if(langue == 3) return "Najlepszy wynik: ";
      else return "Best scores: ";
    }
    else if(valeur == 12)
    {
      if(langue == 2) return "Connexion en cours...";
      else if(langue == 3) return "Łączenie...";
      else return "Connecting...";
    }
    else if(valeur == 13)
    {
      if(langue == 2) return "Impossible de se connecter au serveur.";
      else if(langue == 3) return "Nie można połączyć się z serwerem.";
      else return "Can't connect to the server.";
    }
    else if(valeur == 14)
    {
      if(langue == 2)       return "Le tableau des score en ligne à été désactivé dans les\noptions.";
      else if(langue == 3)  return "Internetowa tablica wyników została wyłączona w opcjach.";
      else                  return "Online scoreboard were disable in the options.";
    }
    else if(valeur == 15)
    {
      if(langue == 2)       return "Vous ne pouvez pas utiliser le tableau des scores en ligne\nquand les fonctions de debug sont activées.";
      else if(langue == 3)  return "Nie możesz używać internetowej tablicy wyników kiedy\nopcje debugowania są włączone.";
      else                  return "You can't use the online scoreboard when the debug\nfunctions are enable.";
    }
    else return "ERROR";
  }
  
  String ecrirePseudo()
  {
    if (langue == 2) return "Veuillez entrer votre pseudo:";
    else if (langue == 3) return "Proszę podaj swój pseudonim:";
    else return "Please write your nickname:";
  }
  
  String dialogMimi(byte lequel)
  {
    if(lequel == 0)
    {
      if(langue == 2) return "Vous avez fait mal à Mimi, Mimi ne veux pas parler avec vous.";
      else if(langue == 3) return "Zraniłeś Mimi. Mimi nie będzie z tobą rozmawiać.";
      else return "You hurt Mimi, Mimi doesn't want to speak with you.";
    }
    if(lequel == 1)
    {
      if (langue == 2)
        return "Mimi veut du chocolat !";
      else if (langue == 3)
        return "Daj Mimi czekoladki !";
      else
        return "Mimi want chocolate !";
    }
    else if(lequel == 2)
    {
      if(langue == 2) return "Prend ça. (Donner 1 chocolat)";
      else if(langue == 3) return "Proszę. (Daj 1 czekoladkę)";
      else return "Take this. (Give 1 chocolate)";
    }
    else if(lequel == 3)
    {
      if(langue == 2) return "Je n'ai pas de chocolat.";
      else if(langue == 3) return "Nie mam czekoladki.";
      else return "I don't have chocolate.";
    }
    else if(lequel == 4)
    {
      if(langue == 2) return "Merci ! Donc Mimi va le prendre ♪.";
      else if(langue == 3) return "Dziękuję! Mimi weźmie ♪.";
      else return "Thank you ! So Mimi will take it ♪.";
    }
    else if(lequel == 5)
    {
      if(langue == 2) return "Reviens voir Mimi quand tu aurras du chocolat.";
      else if (langue == 3) return "Wróć do Mimi jak znajdziesz czekoladki.";
      else return "Come back to see Mimi when you will have chocolate.";
    }
    else if(lequel == 6)
    { 
      byte quelDial = (byte)(random(3)+1);
      if(quelDial == 1)
      {
        if(langue == 2) return "Ca fait mal ! Pourquoi frappez-vous Mimi ?";
        else return "It's hurts ! Why are you hitting Mimi ?";
      }
      else if(quelDial == 2)
      {
        if(langue == 2) return "Arrètez ça, Mimi ne veut pas mourrir !";
        else return "Stop this, Mimi don't want to die !";
      }
      else if(quelDial == 3)
      {
        if(langue == 2) return "N-non, Mimi est une gentille Mimic. *sob*";
        else return "N-no, Mimi is a friendly Mimic. *sob*";
      }
    }
    else if(lequel == 7)
    {
      if(langue == 2) return "...Pourquoi... Mimi voulais juste du chocolat... Je n'ai rien fait pour mériter ça...";
      else return "...Why... Mimi just wanted chocolate... I did nothing deserve that...";
    }
    
    return "ERROR";
  }
  
  String affControles(byte lequel)
  {
    if(lequel == 1)
    {
      if(langue == 2) return "Controles:";
      else if(langue == 3) return "Sterowanie:";
      else return "Controls:";
    }
    else if(lequel == 2)
    {
      if(langue == 2) return "Déplacements: Pavé directionel";
      else if(langue == 3) return "Poruszanie się: Strzałki";
      else return "Movements: Directionnal keypad";
    }
    else if(lequel == 3)
    {
      if(langue == 2) return "Tourner le joueur: A et E";
      else if(langue == 3) return "Obrót gracza: A i E";
      else return "Turn the player: A and E";
    }
    else if(lequel == 4)
    {
      if(langue == 2) return "Attaquer: 1 à 4 (Pavé numérique)";
      else if(langue == 3) return "Atak: 1-4 (Numpad)";
      else return "Attack: 1 to 4 (Numpad)";
    }
    else if(lequel == 5)
    {
      if(langue == 2) return "Action: Entrée";
      else if(langue == 3) return "Akcja: Enter";
      else return "Action: Enter";
    }
    else if(lequel == 6)
    {
      if(langue == 2) return "Potions: 5 à 8 (Pavé numérique)";
      else if(langue == 3) return "Eliksiry: 5-8 (Numpad)";
      else return "Potions: 5 to 8 (Numpad)";
    }
    else if(lequel == 7)
    {
      if(langue == 2) return "Bombe: 0 (Pavé numérique)";
      else if(langue == 3) return "Użycie bomby: 0 (Numpad)";
      else return "Bomb: 0 (Numpad)";
    }
    else if(lequel == 8)
    {
      if(langue == 2) return "Inventaire: i";
      else if(langue == 3) return "Ekwipunek: i";
      else return "Inventory: i";
    }
    else if(lequel == 9)
    {
      if(langue == 2) return "Ouvrir/Fermer le journal des quètes: j";
      else if(langue == 3) return "Otwórz/Zamknij listę zadań: j";
      else return "Open/Close the quest journal: j";
    }
    else if(lequel == 10)
    {
      if(langue == 2) return "Afficher/Cacher la barre d'action: h";
      else if(langue == 3) return "Pokaż/Ukryj pasek akcji: h";
      else return "Show/Hide action bar: h";
    }
    else if(lequel == 11)
    {
      if(langue == 3) return "Opcje: o";
      else return "Options: o";
    }
    else if(lequel == 12)
    {
      if(langue == 2) return "Afficher/Cacher les FPS: ²";
      else if(langue == 3) return "Pokaż/Ukryj FPS: ²";
      else return "Show/Hide FPS: ²";
    }
    else if(lequel == 13)
    {
      if(langue == 2) return "Retourner au menu principale: Retour Arrière (seulement si tous les ennemis du niveau sont mort)";
      else if(langue == 3) return "Wróć do menu głównego: Backspace (tylko pod warunkiem unicestwienia wszystkich przeciwników na danym poziomie)";
      else return "Go back to the main menu: Backspace (only if all the enemis of the actual level are dead)";
    }
    else if(lequel == 14)
    {
      if(langue == 2) return "Donner un ordre: .";
      else return "Give an order: .";
    }
    else return "ERROR";
  }
  
  String showHide()
  {
    if(langue == 2) return "H: Afficher/Cacher";
    else if(langue == 3) return "H: Pokaż/Ukryj";
    else return "H: Show/Hide";
  }

  String infoChargementLvlAlea(byte avanceChargement)
  {
    switch(avanceChargement)
    {
    case 0 :
      if (langue == 2) return "Génération du niveau...";
      else if(langue == 3) return "Kreowanie lochów...";
      else return "Generating the stage...";

    case 1 :
      return "...";

    case 2 :
      if (langue == 2) return "Placement des pièges...";
      else if(langue == 3) return "Ustawianie pułapek...";
      else return "Setting traps...";

    case 3 :
      if (langue == 2) return "Invoquation des ennemies...";
      else if (langue == 3) return "Dodawanie przeciwników...";
      else return "Invoking the ennemies...";

    case 4 :
      if (langue == 2) return "Hiding treasures...";
      else if(langue == 3) return "Ukrywanie skarbów...";
      else return "Dissimulation des trésors...";

    case 5 :
      if (langue == 2) return "Actualisation de la carte...";
      else if (langue == 3) return "Modernizowanie mapy...";
      else return "Updating the map...";

    case 6 :
      if (langue == 2) return "Chargement terminé, amusez-vous bien :).";
      else if (langue == 3) return "Ładowanie zakończone. Miłej zabawy. :)";
      else return "Loading complete, have fun :).";

    default :
      return "";
    }
  }
  
  String utilisationImpossible()
  {
    if(langue == 2) return "Vous ne pouvez pas utiliser ça.";
    else if(langue == 3) return "Nie możesz tego użyć.";
    else return "You can't use this.";
  }

  String gameOver()
  {
    if (langue == 2) return "Partie finie";
    else if (langue == 3) return "Gra skończona";
    return "Game over";
  }

  String vousEtesMort()
  {
    if (langue == 2) return "Vous êtes mort";
    else if (langue == 3) return "Nie żyjesz. Jesteś trupem.";
    else return "You are dead.";
  }

  String mortTombeTrou()
  {
    if (langue == 2) return "Raison: Vous avez marcher dans un piège.";
    else if(langue == 3) return "Powód: Wlazłeś w pułapkę.";
    else return "Reason: You walked in a trap.";
  }
  
  String tuerEnnemi()
  {//// 0: environnement, 1: joueur, 2: thrug, 3: saria, 4: gandur, 5: mannequin, 6: ennemis, 7: boss, 8: mimic, 9: ennemisDeux, 10: kya, 11: elenia, 12: berserker, 13: healer ennemi
    String ennemiQuiTue;
    if(dernierQuiAttaqueJoueur != null)
    {
      if(dernierQuiAttaqueJoueur.returnId() == 3) ennemiQuiTue = "Saria";
      else if(dernierQuiAttaqueJoueur.returnId() == 6) ennemiQuiTue = "un ennemi";
    }
    else
      ennemiQuiTue = "un ennemi";
    
    if (langue == 2) return "Raison: Un ennemi vous à tuer.";
    else if(langue == 3) return "Powód: Zabił cię przeciwnik.";
    else return "Reason: An ennemy killed you.";
  }

  String mortRaisonInconnu()
  {
    if (langue == 2) return "Raison: Votre vie à atteint 0 (ou moins)";
    else if (langue == 3) return "Powód: Twój stan zdrowia osiągnął 0 (lub mniej)";
    else return "Reason: Your life reached 0 (or less)";
  }

  String outOfMana()
  {
    if (langue == 2) return "Mana épuisée";
    else if (langue == 3) return "Brak many";
    else return "Out of mana";
  }
  
  String tuerBombe()
  {
    if (langue == 1) return "Reason: You blown up into pieces.";
    else if(langue == 3) return "Powód: Wybuch rozerwał cię na strzępy.";
    else return "Raison: Vous avez exploser en morceaux.";
  }

  void testPancarte()
  {
    if (langue == 2) dernierMessagePancarte = "Ceci est une pancarte.";
    else if(langue == 3) dernierMessagePancarte = "To jest znak.";
    else dernierMessagePancarte = "This is a sign.";
  }
  
  String oui()
  {
    if(langue == 2) return "Oui.";
    else if(langue == 3) return "Tak.";
    else return "Yes.";
  }
  
  String non()
  {
    if(langue == 2) return "Non.";
    else if(langue == 3) return "Nie.";
    else return "No.";
  }

  String ouvrirPorteFermee(byte progressionPorte)
  {
    if(progressionPorte == 1)
    {
      if(langue == 2) return "Voulez-vous ouvrir la porte ? Il vous faut une clé.";
      else if(langue == 3) return "Czy chcesz otworzyć drzwi? Potrzeba ci klucza.";
      else return "Do you want to open the door ? You will need one key.";
    }
    else if(progressionPorte == 2)
    {
      if(langue == 2) return "La porte est toujours fermée.";
      else if(langue == 3) return "Drzwi są nadal zamknięte.";
      else return "The door is still locked.";
    }
    else if(progressionPorte == 3)
    {
      if(langue == 2) return "La porte est maintenant ouverte.";
      else if(langue == 3) return "Drzwi są teraz otwarte.";
      else return "The door is now open.";
    }
    return "ERROR";
  }

  void porteDeverouille()
  {
    if(langue == 3) dernierMessagePancarte = "Nieważne...";
    else dernierMessagePancarte = "Nevermind...";
  }

  void porteFermee()
  {
    if(carteActuelle == intro)
    {
      if(langue == 2)
        dernierMessagePancarte = "C'est fermé.\nJ'immagine que même une petite soeur peut avoir ses secrets.";
      else if(langue == 3)
        dernierMessagePancarte = "Zamknięte. Uważam, że nawet mała siostrzyczka może mieć swoje sekrety.";
      else
        dernierMessagePancarte = "It's locked.\nI guess even a little sister can have her secrets.";
    }
    else
    {
      dialogue = (byte)(Math.random()*3+1);
      if (langue == 2)
      {
        if (dialogue == 1) dernierMessagePancarte = "C'est fermé.";
        else if (dialogue == 2) dernierMessagePancarte = "Je n'arrive pas à l'ouvrir.";
        else dernierMessagePancarte = "Peut être si je tire un peu plus fort...\nNon, c'est définitivement fermé.";
      } else if (langue == 3) dernierMessagePancarte = "Drzwi są zamknięte.";
      else
      {
        if (dialogue == 1) dernierMessagePancarte = "It's locked.";
        else if (dialogue == 2) dernierMessagePancarte = "I can't open it.";
        else dernierMessagePancarte = "Maybe if I try a little harder...\nNope, it's definitely locked.";
      }
      /*
      Drzwi są zamknięte. - Door is closed.
       Skrzynia jest zamknięta. - Chest is closed.
       Zamknięte. - It's closed.
       */
    }
  }

  String creeProcessing()
  {
    if (langue == 2) return "Ce jeu a été crée avec Processing.";
    else if (langue == 3) return "Gra została stworzona przy użyciu Processing";
    else return "This game was created with Processing.";
  }

  String jeuPause()
  {
    if (langue == 2) return "Appuyez sur Echap pour revenir au jeu.";
    else if (langue == 3) return "Wciśnij przycisk escape aby powrócić do gry.";
    else return "Press escape to unpause the game.";
  }

  void thrugAttente()
  {
    if (modeDeJeu == 0)
    {
      if (langue == 2)
        dernierMessagePancarte = "On devrait y aller.";
      else if (langue == 3)
        dernierMessagePancarte = "Powinniśmy już iść.";
      else
        dernierMessagePancarte = "We should go.";
    }
    else
    {
      byte quelDialogue = (byte)(random(2)+1);
      if(dansLeNoir)
      {
        if (quelDialogue == 1)
        {
          if (langue == 2)
            dernierMessagePancarte = "Je ne vois rien, c'est pénible.";
          else if (langue == 3)
            dernierMessagePancarte = "Prawie nic nie widzę. Strasznie mnie to wkurza.";
          else
            dernierMessagePancarte = "I can't see anything, it's annoying.";
        } else
        {
          if (langue == 2)
            dernierMessagePancarte = "Je penserais à ammener une torche la prochaine fois...";
          else if (langue == 3)
            dernierMessagePancarte = "Następnym razem muszę pamiętać o zabraniu pochodni.";
          else
            dernierMessagePancarte = "I will think to take a torch the next time...";
        }
      }
      else if(dansLeFroid)
      {
        if (quelDialogue == 1)
        {
          if (langue == 2)
            dernierMessagePancarte = "Un vrai guerrier n'a jamais froid !";
          else if (langue == 3)
            dernierMessagePancarte = "Prawdziwemu wojowi nigdy nie jest zimno!";
          else
            dernierMessagePancarte = "A real warrior never is cold !";
        } else
        {
          if (langue == 2)
            dernierMessagePancarte = "Bien que je n'ai pas froid, je pense qu'on devrais se dépécher.";
          else if (langue == 3)
            dernierMessagePancarte = "Chociaż nie jest mi aż tak zimno i tak powinniśmy się pospieszyć.";
          else
            dernierMessagePancarte = "Even if I'm not cold, I think we should hurry.";
        }
      }
      else if(sariaInsane)
      {
        if (quelDialogue == 1)
        {
          if (langue == 2)
            dernierMessagePancarte = "Je me demande ce qu'il est arrivé à Saria...";
          else if (langue == 3)
            dernierMessagePancarte = "Ciekawe co stało się z Sarią...";
          else
            dernierMessagePancarte = "I wonder what happened to Saria...";
        } else
        {
          if (langue == 2)
            dernierMessagePancarte = "Amie ou non, si Saria m'attaque, je la plante avec mon épée.";
          else if (langue == 3)
            dernierMessagePancarte = "Przyjaciel czy nie, jeżeli Saria mnie zaatakuje, zabiję.";
          else
            dernierMessagePancarte = "Friend or not, if Saria attack me, I stab her with my sword.";
        }
      }
      else if(seulementBerserker)
      {
        if (quelDialogue == 1)
        {
          if (langue == 2)
            dernierMessagePancarte = "Peu importe le danger, je ne fuierais pas.";
          else if (langue == 3)
            dernierMessagePancarte = "Nie dbam o niebezpieczeństwo, ja nie zamierzam uciekać.";
          else
            dernierMessagePancarte = "Whatever the danger, I won't run away.";
        } else
        {
          if (langue == 2)
            dernierMessagePancarte = "Mon épée est prête.";
          else if (langue == 3)
            dernierMessagePancarte = "Mój miecz jest gotów !";
          else
            dernierMessagePancarte = "My sword is ready.";
        }
      }
      else
      {
        if (quelDialogue == 1)
        {
          if (langue == 2)
            dernierMessagePancarte = "Je couvre tes arrières. Maintenant, allons-y.";
          else if (langue == 3)
            dernierMessagePancarte = "Osłaniam cię. Idź.";
          else
            dernierMessagePancarte = "I cover your back. Now, let's go.";
        } else
        {
          if (langue == 2)
            dernierMessagePancarte = "Qu'est ce que tu veux ?";
          else if (langue == 3)
            dernierMessagePancarte = "Czego chcesz ?";
          else
            dernierMessagePancarte = "What do you want ?";
        }
      }
      
    }
  }
  void sariaAttente()
  {
    if (modeDeJeu == 0)
    {
      if (langue == 2)
        dernierMessagePancarte = "Je suis prête à partir.";
      else if (langue == 3)
        dernierMessagePancarte = "Jestem gotowa.";
      else
        dernierMessagePancarte = "I am ready to go.";
    }
    else
    {
      byte quelDialogue = (byte)(random(2)+1);
      if(dansLeNoir)
      {
        if (quelDialogue == 1)
        {
          if (langue == 2)
            dernierMessagePancarte = "C'est peut-être étrange, mais j'aime l'obscurité.\n" +
                                     "Les gens font plus attention aux détails et ils restent regroupés.\n" +
                                     "Ca me fait me sentir mieux.";
          else if (langue == 3)
            dernierMessagePancarte = "To może brzmieć dziwnie, ale lubię mrok.\n" + 
                                     "Ludzie wyostrzają zmysły i trzymają się bliżej innych.\n" +
                                     "Czuję się troszkę pewniej.";
          else
            dernierMessagePancarte = "It's may be weird, but I like darkness.\n" +
                                     "People make more attention to details and they stay close each others.\n" +
                                     "It's making me feel better.";
        } else
        {
          if (langue == 2)
            dernierMessagePancarte = "Nous devrions tous rester ensemble, ou nous allons nous perdre.";
          else if (langue == 3)
            dernierMessagePancarte = "Musimy wszyscy trzymać się razem albo się zgubimy.";
          else
            dernierMessagePancarte = "We should all stay together, or we will be lost.";
        }
      }
      else if(dansLeFroid)
      {
        if (quelDialogue == 1)
        {
          if (langue == 2)
            dernierMessagePancarte = "J'ai si froid, nous devons sortir d'ici rapidement, s'il vous plait...";
          else if (langue == 3)
            dernierMessagePancarte = "Jest mi strasznie zimno... Musimy się jak najszbyciej stąd wydostać, proszę.";
          else
            dernierMessagePancarte = "I'm so cold, we need to get out of here quickly, please...";
        } else
        {
          if (langue == 2)
            dernierMessagePancarte = "Uuuh... J'aurrais dût prendre des vêtements plus chaud...";
          else if (langue == 3)
            dernierMessagePancarte = "Brrr... Powinnam zabrać ze sobą cieplejsze odzienie...";
          else
            dernierMessagePancarte = "Uuuh... I should have take warmer clothes...";
        }
      }
      else if(sariaInsane)
      {
        if (quelDialogue == 1)
        {
          if (langue == 2)
            dernierMessagePancarte = "Je suis désolé ! Vraiment vraiment désolé !\n" +
                                     "Je promet que je vous expliquerais quand on serra de retour au rez-de-chaussé, donc ne m'abandonnez pas s'il vous plait !";
          else if (langue == 3)
            dernierMessagePancarte = "Przepraszam! Naprawdę, naprawdę przepraszam!\n" +
                                     "Obiecuję, że wszystko wyjaśnię kiedy tylko wydostaniemy się na zewnątrz, tylko proszę, nie zostawiaj mnie!";
          else
            dernierMessagePancarte = "I'm sorry ! Really really sorry !" +
                                     "I promise I'll explain you when we will be back to the ground floor, so please don't abandon me !";
        } else
        {
          if (langue == 2)
            dernierMessagePancarte = "Je suis désolé ! J'aurrais dût vous vous expliquer plus tôt, attendez juste que l'on soit de retour au rez-de-chaussé et je vous dirais tout !";
          else if (langue == 3)
            dernierMessagePancarte = "Przepraszam! Powinnam ci wszystko wyjaśnić, proszę poczekaj tylko aż wrócimy na powietrzchnię i opowiem ci wszystko! ";
          else
            dernierMessagePancarte = "I'm sorry ! I should have explain you before, just wait until we are back to the gound floor and I will say you everything !";
        }
      }
      else if(pasDeMana)
      {
        if (quelDialogue == 1)
        {
          if (langue == 2)
            dernierMessagePancarte = "Je me sens si... faible...";
          else if (langue == 3)
            dernierMessagePancarte = "Czuję się... bardzo słaba...";
          else
            dernierMessagePancarte = "I'm feeling so... weak...";
        } else
        {
          if (langue == 2)
            dernierMessagePancarte = "Je... ne pense pas que je pourrais te soigner, désolé...";
          else if (langue == 3)
            dernierMessagePancarte = "N-nie wiem czy mogę uzdrawiać... przepraszam.";
          else
            dernierMessagePancarte = "I... don't think I will be able to heal you, sorry...";
        }
      }
      else if(seulementBerserker)
      {
        if (quelDialogue == 1)
        {
          if (langue == 2)
            dernierMessagePancarte = "J-je vais rester un peu plus proche de vous, si ça ne vous dérange pas...";
          else if (langue == 3)
            dernierMessagePancarte = "B-będę trzymała się bliżej ciebie, jeżeli ci to nie przeszkadza...";
          else
            dernierMessagePancarte = "I-I will stay closer to you, if it's not disturb you...";
        } else
        {
          if (langue == 2)
            dernierMessagePancarte = "J'ai un mauvais présentiment à propos de ça...";
          else if (langue == 3)
            dernierMessagePancarte = "Mam złe przeczucia...";
          else
            dernierMessagePancarte = "I have a bad feeling about this...";
        }
      }
      else
      {
        if (quelDialogue == 1)
        {
          if (langue == 2)
            dernierMessagePancarte = "N-ne vous inquiétez pas, je suis derrière vous !";
          else if (langue == 3)
            dernierMessagePancarte = "Nie bój się, I-idę za tobą !";
          else
            dernierMessagePancarte = "D-don't worry, I'm behind you !";
        } 
        else
        {
          if (langue == 2)
            dernierMessagePancarte = "Ce donjon est un peu effrayant...";
          else if (langue == 3)
            dernierMessagePancarte = "Te lochy są trochę straszne...";
          else
            dernierMessagePancarte = "This dungeon is a little scary...";
        }
      }
    }
  }
  void kyaAttente()
  {
    if (modeDeJeu == 0)
    {
      dernierMessagePancarte = "...";
    } 
    else
    {
      byte quelDialogue = (byte)(random(2)+1);
      if(dansLeNoir)
      {
        if (quelDialogue == 1)
        {
          if (langue == 2)
            dernierMessagePancarte = "Je suis habitué aux ténèbres.";
          else if (langue == 3)
            dernierMessagePancarte = "Przyzwyczaiłam się do ciemności.";
          else
            dernierMessagePancarte = "I'm used of the darkness.";
        } else
        {
          if (langue == 2)
            dernierMessagePancarte = "Silence, j'ai besoin de me concentrer pour voir.";
          else if (langue == 3)
            dernierMessagePancarte = "Cicho bądź. Muszę się skoncentrować.";
          else
            dernierMessagePancarte = "Be quit, I need to concentrate to see.";
        }
      }
      else if(dansLeFroid)
      {
        if (quelDialogue == 1)
        {
          if (langue == 2)
            dernierMessagePancarte = "Le froid engourdit mes muscles.";
          else if (langue == 3)
            dernierMessagePancarte = "To zimno paraliżuje mięśnie.";
          else
            dernierMessagePancarte = "The coldness numb my muscles.";
        } else
        {
          if (langue == 2)
            dernierMessagePancarte = "Nous devons sortir d'ici rapidement.";
          else if (langue == 3)
            dernierMessagePancarte = "Musimy szybko się stąd wydostać.";
          else
            dernierMessagePancarte = "We need to quickly get out of here.";
        }
      }
      else if(sariaInsane)
      {
        if (quelDialogue == 1)
        {
          if (langue == 2)
            dernierMessagePancarte = "J'ai toujours su que quelque chose n'allais pas avec elle.";
          else if (langue == 3)
            dernierMessagePancarte = "Zawsze wiedziałam, że coś z nią jest nie tak.";
          else
            dernierMessagePancarte = "I always knew there was something wrong with her...";
        } else
        {
          if (langue == 2)
            dernierMessagePancarte = "Une malédiction ?";
          else if (langue == 3)
            dernierMessagePancarte = "Klątwa ?";
          else
            dernierMessagePancarte = "A curse ?";
        }
      }
      else if(seulementBerserker)
      {
        if (quelDialogue == 1)
        {
          if (langue == 2)
            dernierMessagePancarte = "Sois prudent.";
          else if (langue == 3)
            dernierMessagePancarte = "Uważaj.";
          else
            dernierMessagePancarte = "Be careful.";
        } else
        {
          if (langue == 2)
            dernierMessagePancarte = "Essaie de ne pas mourir.";
          else if (langue == 3)
            dernierMessagePancarte = "Postaraj się nie umrzeć.";
          else
            dernierMessagePancarte = "Try to not die.";
        }
      }
      else
      {
        if (quelDialogue == 1)
        {
          if (langue == 2)
            dernierMessagePancarte = "Je n'ai pas le temps de parler.";
          else if (langue == 3)
            dernierMessagePancarte = "Nie mam czasu z tobą pomówić.";
          else
            dernierMessagePancarte = "I don't have the time to speak.";
        } else
        {
          if (langue == 2)
          {
            dernierMessagePancarte = "Ne me parlez pas, concentrez vous sur le donjon.";
          }
          else if (langue == 3)
          {
            dernierMessagePancarte = "Nie będziemy rozmawiać, skupmy się na lochu.";
          }
          else
          {
            dernierMessagePancarte = "Don't speak to me, concentrate on the dungeon.";
          }
        }
      }
    }
  }
  void gandurAttente()
  {
    if (modeDeJeu == 0)
    {
      if (langue == 2)
        dernierMessagePancarte = "J'ai hâte de découvrir des nouvelles choses.";
      else if (langue == 3)
        dernierMessagePancarte = "Nie mogę się doczekać poznania nowych rzeczy.";
      else
        dernierMessagePancarte = "I can't wait to discover new things.";
    }
    else
    {
      byte quelDialogue = (byte)(random(2)+1);
      if(dansLeNoir)
      {
        if (quelDialogue == 1)
        {
          if (langue == 2)
            dernierMessagePancarte = "J'avais un sort pour faire le la lumière, mais j'ai oublié l'incantation...";
          else if (langue == 3)
            dernierMessagePancarte = "Znałem kiedyś dobre zaklęcie oświetlające, ale zapomniałem...";
          else
            dernierMessagePancarte = "I had a spell to make light, but I forgot the incantation...";
        } else
        {
          if (langue == 2)
            dernierMessagePancarte = "Essaie de ne pas marcher dans un piège.";
          else if (langue == 2)
            dernierMessagePancarte = "Postaraj się nie wpaść w pułapkę.";
          else
            dernierMessagePancarte = "Try to not walk in a trap.";
        }
      }
      else if(dansLeFroid)
      {
        if (quelDialogue == 1)
        {
          if (langue == 2)
            dernierMessagePancarte = "Même si je manipule la magie du feu, ça serais trop dangereux de l'utiliser pour nous réchauffer.";
          else if (langue == 3)
            dernierMessagePancarte = "Chociaż znam się na magii ognia użycie jej do ogrzania się w tych ciasnych pomieszczeniach byłoby ciut niebezpieczne.";
          else
            dernierMessagePancarte = "Even if I'm manipulating fire magic, using it to warm ourselves would be too dangerous.";
        } else
        {
          if (langue == 2)
            dernierMessagePancarte = "Nous devrions acheter des vêtements plus chaud la prochaine fois.";
          else if (langue == 3)
            dernierMessagePancarte = "Następnym razem powinniśmy kupić cieplejsze ubrania.";
          else
            dernierMessagePancarte = "We should buy warmer clothes the next time.";
        }
      }
      else if(sariaInsane)
      {
        if (quelDialogue == 1)
        {
          if (langue == 2)
            dernierMessagePancarte = "Je me demande pourquoi c'est arrivé, mais je devrais être en mesure de régler ça temporairement.";
          else if (langue == 3)
            dernierMessagePancarte = "Zastanawia mnie to, co dokładnie się wydarzyło. Chwilowo jednak problem rozwiązałem.";
          else
            dernierMessagePancarte = "I wonder why that's happened, but I should be able to temporary solve the problem.";
        } else
        {
          if (langue == 2)
            dernierMessagePancarte = "Um... Ca ressemble à une malédiction...";
          else if (langue == 3)
            dernierMessagePancarte = "Hmmm... Wygląda na klątwę.";
          else
            dernierMessagePancarte = "Um... It's look like a curse...";
        }
      }
      else if(pasDeMana)
      {
        if (quelDialogue == 1)
        {
          if (langue == 2)
            dernierMessagePancarte = "Je ne vous serrais d'aucune utilité sans ma magie, désolé...";
          else if (langue == 3)
            dernierMessagePancarte = "Bez Mocy nie będę przydatny, wybacz.";
          else
            dernierMessagePancarte = "I will be useless without my magic, sorry...";
        } else
        {
          if (langue == 2)
            dernierMessagePancarte = "Y a t-il quelque chose qui génère ce champs d'anti-magie ?.";
          else if (langue == 3)
            dernierMessagePancarte = "Czy coś tutaj przypadkiem nie wytwarza pola antymagicznego ?";
          else
            dernierMessagePancarte = "Is there something that generate this anti-magic field ?";
        }
      }
      else if(seulementBerserker)
      {
        if (quelDialogue == 1)
        {
          if (langue == 2)
            dernierMessagePancarte = "Si tu croises un berserker, fuis juste.";
          else if (langue == 3)
            dernierMessagePancarte = "Jeżeli spotkasz berserkera po prostu uciekaj gdzie pieprz rośnie.";
          else
            dernierMessagePancarte = "If you meet a berserker, just run away.";
        } else
        {
          if (langue == 2)
            dernierMessagePancarte = "Fait attention, quelque chose de dangereux est près de nous.";
          else if (langue == 3)
            dernierMessagePancarte = "Uważaj. Wyczuwam coś niebezpiecznego w pobliżu.";
          else
            dernierMessagePancarte = "Be careful, something dangerous is near us.";
        }
      }
      else
      {
        if (quelDialogue == 1)
        {
          if (langue == 2)
            dernierMessagePancarte = "Essaie de ne pas rester trop près de moi quand je lance mes sorts,\nje ne voudrais pas que tu sois blessé.";
          else if (langue == 3)
            dernierMessagePancarte = "Nie zbliżaj się, kiedy rzucam zaklęcie. Nie chcę cię zranić.";
          else
            dernierMessagePancarte = "Try to don't stay too close of me when I'm launching my spell,\nI don't want you to get hurt.";
        } else
        {
          if (langue == 2)
          {
            dernierMessagePancarte = "Je ne pensais pas que ce donjon serait si... vide ?.";
          }
          else if (langue == 3)
          {
            dernierMessagePancarte = "Nigdy nie przypuszczałem, iż ów loch może okazać się tak... pusty.";
          }
          else
          {
            dernierMessagePancarte = "I didn't through that dungeon would be so... empty ?.";
          }
        }
      }
    }
  }
  
  void eleniaAttente()
  {
    if (modeDeJeu == 0)
    {
      if (langue == 2)
        dernierMessagePancarte = "Je pense que nous devrions y aller le plus tôt possible.";
      else if (langue == 3)
        dernierMessagePancarte = "Powinniśmy udać się do lochów czym prędzej.";
      else
        dernierMessagePancarte = "I think we should go as soon as possible.";
    }
    else
    {
      byte quelDialogue = (byte)(random(2)+1);
      if(dansLeNoir)
      {
        if (quelDialogue == 1)
        {
          if (langue == 2)
            dernierMessagePancarte = "Ne vous inquiétez pas pour moi, je peux voir dans le noir.";
          else if (langue == 3)
             dernierMessagePancarte = "Nie martw się o mnie. Świetnie widze w ciemności.";
          else
            dernierMessagePancarte = "Don't worry for me, I can see in the dark.";
        } else
        {
          if (langue == 2)
            dernierMessagePancarte = "Je suis nyctalope, alors je n'ai que pas vraiment de problème avec le noir.";
          else if (langue == 3)
            dernierMessagePancarte = "Jestem elfką. Nie mam najmniejszego problemu z mrokiem.";
          else
            dernierMessagePancarte = "I'm nyctalope, so I don't really have problem with the dark.";
        }
      }
      else if(dansLeFroid)
      {
        if (quelDialogue == 1)
        {
          if (langue == 2)
            dernierMessagePancarte = "Etant une elfe, je n'ai pasparticulièrement froid.";
          else if (langue == 3)
            dernierMessagePancarte = "Jako elfka lepiej znoszę chłód.";
          else
            dernierMessagePancarte = "As an elf, I'm not particualiry cold.";
        } else
        {
          if (langue == 2)
            dernierMessagePancarte = "Vous semblez vraiment avoir froid, nous devrions nous dépêcher.";
          else if (langue == 3)
            dernierMessagePancarte = "Wyglądasz na zaziębionego. Ruszajmy.";
          else
            dernierMessagePancarte = "You really seem to be cold, we should hurry.";
        }
      }
      else if(sariaInsane)
      {
        if (quelDialogue == 1)
        {
          if (langue == 2)
            dernierMessagePancarte = "Elle ne semblais pas pouvoir se contrôler, je ne pense pas que l'on devrait lui en tenir rigueur.";
          else if(langue == 3)
            dernierMessagePancarte = "Saria nie mogła się kontrolować. Nie powinniśmy jej winić.";
          else
            dernierMessagePancarte = "She didn't seem to be able to control herself, I don't think we should blame her.";
        } else
        {
          if (langue == 2)
            dernierMessagePancarte = "Comment soigner ça...? Peut-être que si on l'assomme...";
          else if (langue == 3)
            dernierMessagePancarte = "Jak to wyleczyć ? Może gdybyśmy ją ogłuszyli ?";
          else
            dernierMessagePancarte = "How to cure that...? Maybe if we stun her...";
        }
      }
      else if(seulementBerserker)
      {
        if (quelDialogue == 1)
        {
          if (langue == 2)
            dernierMessagePancarte = "Si nous rencontrons des berserkers, je pense que nous devrions juste fuire, ils sont bien trop fort.";
          else if (langue == 3)
            dernierMessagePancarte = "Jeżeli spotkamy berserkerów powinniśmy uciec. Są zbyt silni.";
          else
            dernierMessagePancarte = "If we meet berserker, I think we should just run away, they are too strong.";
        } else
        {
          if (langue == 2)
            dernierMessagePancarte = "Essayer de faire tomber les ennemies dans des trous nous permettrais d'éviter les combats.";
          else if (langue == 3)
            dernierMessagePancarte = "Spróbuj wpędzić przeciwnika w pułapkę. Możemy w ten sposób unikać niepotrzebnej walki.";
          else
            dernierMessagePancarte = "Try to make our ennemy fail in traps would allow us to avoid fights.";
        }
      }
      else
      {
        if (quelDialogue == 1)
        {
          if (langue == 2)
            dernierMessagePancarte = "Je ne me sens pas à l'aise dans ce donjon,\nil y a beaucoup trop de pierre.";
          else if (langue == 3)
            dernierMessagePancarte = "Niezbyt dobrze czuję się w tych locach. Zbyt wiele tu zimnych kamieni.";
          else
            dernierMessagePancarte = "I'm not in ease in this dungeon,\nthere are way too much stones.";
        } else
        {
          if (langue == 2)
          {
            dernierMessagePancarte = "Si vous trouvez des plantes, je pourrais faire des potions.";
          }
          else if (langue == 3)
          {
            dernierMessagePancarte = "Jeśli znajdziesz trochę ziół, mogę zrobić z nich eliksiry.";
          }
          else
          {
            dernierMessagePancarte = "If you find plants, I can make some potions.";
          }
        }
      }
    }
  }

  String dialogueAleaNiveau(Personnage perso)
  {
    byte quelDialogue = (byte)(random(2)+1);
    if (perso == saria)
    {
      if (quelDialogue == 1)
      {
        if (langue == 2) return "J'espère que le fait que je vous suive ne vous dérange pas...";
        else return "I hope that the fact I'm following you wont disturb you...";
      } else
      {
        if (langue == 2)
          return "Uh... Ma robe est toute sâle...";
        else
          return "Uh... My dress is all dirty...";
      }
    }
    if (perso == thrug)
    {
      if (quelDialogue == 1)
      {
        if (langue == 2) return "Essaie de ne pas marcher dans les trous.";
        else return "Try to don't walk in the holes.";
      } else
      {
        if (langue == 2)
          return "Ne t'éloigne pas trop de moi, si tu ne veux pas mourir.";
        else
          return "Don't go too far from me, if you don't want to die.";
      }
    }
    if (perso == gandur)
    {
      if (quelDialogue == 1)
      {
        if (langue == 2) return "Essaie de ne pas marcher dans les trous.";
        else return "Try to don't walk in the holes.";
      } else
      {
        if (langue == 2)
          return "Ne t'éloigne pas trop de moi, si tu veux pas mourir.";
        else
          return "Don't go too far away from me, if you don't want to die.";
      }
    }
    return "ERROR";
  }
  
  String recrutementDial(Personnage perso, byte avanceRecrutement)
  {
    if(avanceRecrutement == 1) // Présentation
    {
      if(perso == kya)
      {
        if (langue == 2) {
          return "Je m'apelle Kya.\n" +
            "Ravie de te rencontrer...";
        } else if (langue == 3) {
          return "Jestem Kya.\n" +
            "Miło cię poznać... ";
        } else {
          return "I'm Kya.\n" +
            "Nice to meet ya...";
        }
      } else if(perso == gandur) {
        if (langue == 2) {
          return "Je suis Gandur le Puissant !\n" +
            "Tant que tu ne reste pas trop près de mes incantations,\ntu serras en sécurité avec moi.\n" +
            "Ahah, ne t'inquiète pas, je sais ce que je fait, ravi de te rencontrer !";
        } else if (langue == 3) {
          return "Jam jest Gandur Niezwyciężony !\n" +
            "Dopóki nie wejdziesz w drogę mym zaklęciom nic ci się ne stanie.\n" +
            "Cha, cha, cha! Nie przejmuj się, wiem co robię. Miło cię poznać.";
        } else {
          return "I am Gandur the Powerful !\n" +
            "As long as you don't stay too close of my incantations,\nyou will be safe with me.\n" +
            "Haha, don't worry, I know what I'm doing, nice to meet you !";
        }
      } else if(perso == thrug) {
        if (langue == 2) {
          return "Je suis Thrug le Téméraire !\n" +
            "Même si je ne sais pas ce que 'téméraire' veut dire, ça doit surement être positif.\n" +
            "Dans tous les cas, heureux de te recontrer !";
      } else if (langue == 3) {
          return "Jestem Thrug Krótkowzroczny!\n" +
            "Nawet jeżeli nie wiem co znaczy 'krótkowzroczny' nie obawiam się, że to coś złego.\n" +
            "Tak w ogóle, to miło cię poznać.";
      } else {
          return "I am Thrug the Reckless !\n" +
            "Even if I don't know what does 'reckless' mean, it should be positive.\n" +
            "Anyway, I'm glad to meet you !";
        }
      } else if(perso == saria) {
        if (langue == 2) {
          return "J-je m'appelle Saria.\n" +
            "Je pratique la magie de la vie, d-donc je pourrais vous soigner si besoin...\n" +
            "J-j'espère que nous pourrons nous entendre !";
        } else if (langue == 3) {
          return "N-nazywam się Saria.\n" +
            "Uczę się magii leczniczej, w-więc mogłabym cię leczyć, jeżeli chcesz...\n" +
            "M-mam nadzieję, że wszystko dobrze się ułoży! ";
        } else {
          return "M-my name is Saria.\n" +
            "I'm practicing the magic of life, s-so I would be able to heal you, if needed...\n" +
            "I-I hope we will get along !";
        }
      } else if(perso == elenia) {
        if (langue == 2) {
          return "Mon nom est Elenia.\n" +
            "Je viens des forêts du nord, et je me débrouille bien à l'arc.\n" +
            "C'est un honneur de vous rencontrer.";
        } else if (langue == 3) {
          return "Moje imię to Elenia.\n" +
            "Pochodzę z lasów na północy. Znam się na łucznictwie.\n" +
            "Honorem jest poznać ciebie.";
        } else {
          return "My name is Elenia.\n" +
            "I'm from the northern forests, and I'm pretty good at archery.\n" +
            "It's an honour to meet you.";
        }
      }
    }
    else if(avanceRecrutement == 3) // Recrutement accepté
    {
      if(perso == kya)
      {
        if (langue == 2) {
          return "Compris.\n" +
            "Prête à partir.";
        } else if (langue == 3) {
          return "Zrozumiano.\n" +
            "Gotowa do drogi.";
        } else {
          return "Understood.\n" +
            "Ready to go.";
        }
      } else if(perso == gandur) {
        if (langue == 2) {
          return "Je suis prêt à braver l'inconnu !";
        } else if (langue == 3) {
          return "Gotów jestem zmierzyć się z nieznanym !";
        } else {
          return "I am ready to face the unknown !";
        } 
      } else if(perso == thrug) {
        if (langue == 2) {
          return "Mes ennemis vont craindre mon épée !";
        } else if (langue == 3) {
          return "Moi wrogowie będą lękać się mego ostrza.";
        } else {
          return "My ennemies will fear my sword !";
        }
      } else if(perso == saria) {
        if (langue == 2) {
          return "Je peux rejoindre votre équipe ? Vraiment ?\nMerci beaucoup, je vais faire de mon mieux !";
        } else if (langue == 3) {
          return "Naprawdę mogę dołączyć? Naprawdę?\nDziękuję! Zrobię wszystko co w mojej mocy!";
        } else {
          return "I can join your team ? Really ?\nThanks a lot, I'll do my best !";
        }
      } else if(perso == elenia) {
        if (langue == 2) {
          return "Mon arc est votre.";
        } else if (langue == 3) {
          return "Mój łuk należy do ciebie.";
        } else {
          return "My bow is yours.";
        }
      }
    }
    else if(avanceRecrutement == 4) // Quitter
    {
      if(perso == kya) {
        return "...";
      } else if(perso == gandur) {
        if (langue == 2) {
          return "J'espère qu'on se reverra.";
        } else if (langue == 3) {
          return "Mam nadzieję, że jeszcze się spotkamy.";
        } else {
          return "I hope we will meet again.";
        }
      } else if(perso == thrug) {
        if (langue == 2) {
          return "N'hésite pas à revenir me voir si besoin !";
        } else if (langue == 3) {
          return "Nie obawiam się wrócić, jeżeli będziesz mnie potrzebować.";
        } else {
          return "Don't hesitate to come see me again, if necessary !";
        }
      } else if(perso == saria) {
        if (langue == 2) {
          return "B-bien, je vais attendre ici, au cas où vous auriez besoin de moi.";
        } else if (langue == 3) {
          return "D-dobrze. Poczekam tu w razie gdybyś mnie potrzebował.";
        } else {
          return "A-alright, I'll wait here, in case you need me.";
        }
      } else if(perso == elenia) {
        if (langue == 2) {
          return "Je vous souhaite une bonne journée.";
        } else if (langue == 3) {
          return "Miłego dnia.";
        } else {
          return "I wish you a nice day.";
        }
      }
    }
    else if(avanceRecrutement == 5) // Trop de personnes
    {
      if(perso == kya)
      {
        if (langue == 2) {
          return "Vous êtes déja 4,\n" +
            "Je suis sûre que vous ne serrez pas capable de gagner assez d'or pour nous tous.\n" +
            "Je n'veux pas vous rejoindre.";
        } else if (langue == 3) {
          return "Jest was już czwórka.\n" +
            "Jestem pewna, że nie będziesz w stanie równo podzielić złota dla nas wszystkich.\n" +
            "Nie chcę do ciebie dołączyć.";
        } else {
          return "You're already are 4,\n" +
            "I'm sure you won't be able to earn enough gold for all of us.\n" +
            "Don't wanna join you.";
        }
      } else if(perso == gandur) {
        if (langue == 2) {
          return "Erm... Je vois que vous êtes déja 4, et, tu vois je lance des sorts...\n" +
            "Et disons que j'ai déja eu quelques... problèmes avec mon ancienne équipe lié à ça...\n" +
            "Donc voilà, je préfèrerais venir si vous étiez moins, pour éviter les dommages colatéraux...";
        } else if (langue == 3) {
          return "Ech... Widzę, że twoja drużyna jest już pełna.\n" +
            "Widzisz... właśnie rzucam pewne zaklęcie... Powiedzmy, że pojawiły się pewne... trudności.\n" +
            "Ostatnio w drużynie pojawiły się pewne problemy, więc wolałbym raczej unikać dodatkowych kłopotów...";
        } else {
          return "Erm... I can see you're already 4, and you see, I'm launching spell...\n" +
            "Let's say that I already had some... problems with my last team because of that...\n" +
            "So I would prefer if we were less, to avoid collateral damages...";
        }
      } else if(perso == thrug) {
        if (langue == 2) {
          return "Vous êtes déja 4, non ?\n" +
            "Un jour un tavernier m'a dit 'Si tu fais une équipe, le nombre idéal serait de 4 personnes'.\n" +
            "Et tu sais, ces gens sont toujours à parler avec des aventuriers, alors il doit avoir raison.\n" +
            "Reviens me voir quand vous serrez moins.";
        } else if (langue == 3) {
          return "Czyż twoja drużyna nie składa się już z czterech kompanów ?\n" +
            "Pewnego dnia podróżnik powiedział mi, że idealna drużyna powinna być złożona właśnie z czwórki kompanów.\n" +
            "Tacy ludzie jak on często rozmawiają z poszukiwaczami przygód, więc coś w tym musi być.\n" +
            "Wróć do mnie, kiedy zwolni się dla mnie miejsce.";
        } else {
          return "You're already 4, don't you ?\n" +
            "One day, a tavernier told me 'If you're making a team, it should be made of 4 adventurers.\n" +
            "And you know, these people always speak with adventurers, so he must be right.\n" +
            "Come back when there will be room to fill in your team.";
        }
      } else if(perso == saria) {
        if (langue == 2) {
          return "O-oh, vous avez déja beaucoup de personne dans votre équipe...\n" +
            "Ce n'est pas que je ne veux pas vous joindre, mais soigneur est un travail difficile,\n" +
            "et vous voyez, je ne voudrais pas être réponsable de la mort de quelqu'un...\n" +
            "V-vous devriez trouver quelqu'un meilleur que moi à la place...\n" +
            "Désolé d'être aussi égoiste !";
        } else if (langue == 3) {
          return "O-och... Już masz wystarczająco towarzyszy w swej drużynie...\n" +
            "To nie tak, że nie chcę dołączyć, ale uzdrowiciel to ciężka praca i widzisz...\n" +
            "nie chcę być odpowiedzialna za czyjąś śmierć...\n" +
            "P-powinieneś poszukać kogoś lepszego ode mnie... Bardzo przepraszam za bycie samolubną!";
        } else {
          return "O-oh, you already have a lot of persons in your team...\n" +
            "It's not that I don't want to join you, but healer is sure an hard job,\n" +
            "and you see, I don't want to be responsible of the death of someone...\n" +
            "Y-you should try to find someone better than me instead...\n" +
            "I'm sorry for being so selfish !";
        }
      } else if(perso == elenia) {
        if (langue == 2) {
          return "Ca serais un honneur de travailler avec vous.\n" +
            "Mais je peux vous dire que 4 personnes est suffisant pour une équipe.\n" +
            "Je pense qu'il va y avoir plein de problèmes si nous sommes trop nombreux.\n" +
            "Mais si pour une raison, vous êtes moins, je serrais honoré de me joindre à vous.";
        } else if (langue == 3) {
          return "Honorem byłaby walka ramię w ramię z tobą u boku.\n" +
            "Widzę jednak, że czwórka to już pełna kompania.\n" +
            "Im więcej ludzi, tym więcej problemów..\n" +
            "Jeżeli coś się jednak wydarzy... mogłabym dołączyć.";
        } else {
          return "It would be an honor to work with you,\n" +
            "But I can tell you that 4 people is enough for a team.\n" +
            "I think there will be a lot of problem if we are too many.\n" +
            "But if for one reason you are less, I would be honored to join you.";
        }
      }
    }
    else if(avanceRecrutement == 6) // Quitter
    {
      if(perso == kya) {
        if (langue == 2) {
          return "Pour gagner de l'or bien sûre, je suis une voleuse.\n" +
          "...Ok, peut-être qu'il n'y à pas que ça... Mais tu n'as pas besoin de savoir sur le champs.\n" +
          "Je t'expliquerais peut-être si on le trouve.";
        } else if (langue == 3) {
          return "Chcę zarobić, to przecież oczywiste, w końcu jestem złodziejką.\n" +
          "No dobrze... może jest inny powód... ale nie musisz o nim teraz wiedzieć.\n" +
          "Może wyjaśnię ci później.";
        } else {
          return "For earning gold of course, I'm a thief.\n" +
          "...Ok, maybe there is another reason... But you don't need to know right now.\n" +
          "I'll maybe explain you if we find it.";
        }
      } else if(perso == gandur) {
        if (langue == 2) {
          return "Eh bien, j'ai entendu dire qu'il y avais un très ancien grimier sur\n" +
          "les foundations de la magie du feu, dans ce donjon...\n" +
          "Mais c'est une source fiable ! Ne serais-ce pas formidable de mettre la main dessus ?";
        } else if (langue == 3) {
          return "Cóż... Słyszałem, że w lochach tych znaleźć można bardzo starą księgę\n" +
          "o sztuce tkania ognia...\n" +
          "Pewien jestem tych informacji! Czyż nie byłoby wspaniałością odnaleźć ową księgę ?";
        } else {
          return "Well, I've heard that there is a very old grimoire about.\n" +
          "the fondations of the fire's magic, in this dungeon...\n" +
          "But it's a reliable source ! Wouldn't it be great to get our hands on ?";
        }
      } else if(perso == thrug) {
        if (langue == 2) {
          return "Ce donjon est célèbre car personne n'as atteint le fond.\n" +
          "Un donjon infini, c'est pas possible, j'irais donc tout en bas.\n" +
          "T'immagine un peu ça ? Je serais le premier à l'avoir fait !";
        } else if (langue == 3) {
          return "Ten loch jest bardzo znany, gdyż nikomu jeszcze nie udało się dotrzeć do końca.\n" +
          "Niekończąca się przygoda? To niemożliwe! Dotrę do końca tego lochu.\n" + 
          "Wyobrażasz to sobie? Będę pierwszym, który to uczyni !";
        } else {
          return "This dungeon is popular because nobody reach the end.\n" +
          "An endless dungeon, it's not possible. I'll go to at the bottom.\n" +
          "Can you immagine that ? I would be the first to do that !";
        }
      } else if(perso == saria) {
        if (langue == 2) {
          return "You voyez, il y a un médaillon très important dans ce donjon...\n" +
          "Je ne peux pas vous donnez plus de détails, mais c'est très important pour moi !\n" +
          "C'est vraiment vraiment important pour moi !";
        } else if (langue == 3) {
          return "Widzisz... w tym lochu znajduje się pewien ważny medalion...\n" +
          "Nie mogę powiedzieć więcej, ale proszę, uwierz mi!\n" +
          "To dla mnie naprawdę ważne...";
        } else {
          return "You see, there are a really important medaillon in this dungeon...\n" +
          "I can't really give you more details, but please believe me !\n" +
          "It's really really important for me !";
        }
      } else if(perso == elenia) {
        if (langue == 2) {
          return "Nous venons de nous rencontrer, laissez moi un peu vous connaître avant de vous raconter celà.\n" +
          "Mais ne vous inquiétez pas, je serais à la hauteur pour réaliser votre but.";
        } else if(langue == 3) {
          return "Dopiero co się poznaliśmy, daj mi trochę czasu nim powiem ci więcej." +
          "But don't worry, I will meet your expectations to realise your goal.";
        } else {
          return "We just met, let me some times to know you before telling you this.\n" +
          "But don't worry, I will meet your expectations to realise your goal.";
        }
      }
    }
    return "ERROR";
  }
  
  String accepter()
  {
    if(langue == 2) return "Accepter";
    else if(langue == 3) return "Akceptuj.";
    else return "Accept";
  }
  
  String refuser()
  {
    if(langue == 2) return "Refuser";
    else if(langue == 3) return "Odrzuć.";
    else return "Refuse";
  }
  
  String queteMimi(byte quelDialogue)
  {
    if(quelDialogue == 1)
    {
      if(langue == 2)
      {
        return "Tu as été gentil avec Mimi, Mimi sais donc que qu'elle peux vous faire confiance. Mimi à donc quelque chose à vous demander.\n" +
        "Le coffre de Mimi est très bien, mais il commence à s'abimer et Mimi aimerais un coffre plus jolie.\n" +
        "Il faut donc que Mimi trouve un nouveau coffre, Mimi aimerais donc se joindre à votre équipe et aller en trouver un meilleur.\n" +
        "Sauf que Mimi n'as habituellement pas besoin de sortir, donc Mimi vie nue dans son coffre... Il faudrait donc des vetêments pour Mimi avant.\n" +
        "Mimi aimerais pas attraper froid... Mais Mimi veut des vetêments, les armures sont trop lourde.\n" +
        "Une fois que Mimi aurras ses vetêments, elle pourra sortir vous suivre. Mimi n'a pas grand chose à vous offrir, si ce n'est quelques objet que Mimi à trouver par terre.\n" +
        "Vous voulez bien aider Mimi ?";
      }
      else if(langue == 3)
      {
        return "Jesteś bardzo miły dla Mimi, więc Mimi chyba może ci zaufać. Mimi chce też cię o coś zapytać...\n" +
          "Skrzyneczka Mimi jest bardzo wygodna, ale jest troszkę uszkodzona i Mimi chciałaby ją wymienić na ładniejszą.\n" +
          "Mimi potrzebuje nowej skrzynki i Mimi chciałaby dołączyć do drużyny, aby poszukać nowego mieszkanka.\n" +
          "Ale... Mimi nie opuszcza często swej skrzyneczki, bo Mimi siedzi w niej nago... Więc Mimi potrzeba najpierw ubranek.\n" +
          "Mimi nie chce się przeziębić... Mimi chce ubranek, bo pancerze są za ciężkie dla Mimi. Kiedy Mimi znajdzie ubranka, to będzie mogła dołączyć do drużyny i iść za tobą.\n" +
          "Mimi nie ma wielu rzeczy do zaoferowania, poza kilkoma przedmiotami, które Mimi znalazła na podłodze.\n" +
          "Czy pomożesz Mimi?";
      }
      else
      {
        return "You are nice with Mimi, so Mimi know that she can believe you. And so Mimi want to ask you something.\n" +
        "Mimi's chest is really good, but it's starting to get damaged, and Mimi would like a prettiest chest.\n" +
        "So Mimi need to find a new chest, Mimi would like to join your team to find a better one.\n" +
        "But Mimi don't usually go outside, so Mimi is naked in her chest... So Mimi would need some clothes before.\n" +
        "Mimi wouln't like to catch a cold... But Mimi want clothes, armors are too heavy.\n" +
        "When Mimi will have these clothes, she will be able to follow you. Mimi don't have a lot of things to offer you, except some objects Mimi found on the floor.\n" +
        "Are you agree to help Mimi ?";
      }
    }
    else if(quelDialogue == 2)
    {
      if(langue == 2) 
      {
        return "Non, Mimi ne va pas souvent en dehors de son coffre, si Mimi voit un enemi elle reste caché dans son coffre.\n" +
        "Je... ne sais pas également bien courrir, car Mimi ne sort que si il n'y a aucun danger\n" +
        "et Mimi ne s'éloigne jamais de son coffre.";
      }
      else if(langue == 3)
      {
        return "Nie, Mimi nie wychodzi ze skrzynki często. Jeżeli Mimi zobaczy łobuza, to się chowa w skrzyni.\n" +
          "M-mimi nie wie jak szybko biegać, bo Mimi wychodzi tylko jeżeli jest bezpiecznie\n" +
          "i Mimi nie oddala się nigdy od skrzyneczki.";
      }
      else
      {
        return "No, Mimi don't go ouside of her chest often, if Mimi see an enemi, she stay hidden in her chest.\n" +
        "I... also don't know how to run fine, because Mimi only go outside if there are no dangers\n" +
        "and Mimi never go too far of her chest.";
      }
    }
    else if(quelDialogue == 3)
    {
      if(langue == 2) 
      {
        return "C'est vraiment impoli de votre part !\n" +
        "Ce n'est pas parce que Mimi n'est pas comme les autres mimic que cela signifie que Mimi n'est pas un mimic !";
      }
      else if(langue == 3)
      {
        return "To nieuprzejme!\n" +
          "To, że Mimi nie jest jak inne mimiki nie znaczy, że Mimi nie jest mimikiem !";
      }
      else
      {
        return "How rude of you !\n" +
        "It's not because Mimi is not like the others Mimic that's mean Mimi isn't a mimic !";
      }
    }
    else if(quelDialogue == 4)
    {
      
      if(langue == 2) 
      {
        return "Non, Mimi à besoin de manger d'autres choses, mais Mimi aime beaucoup le chocolat.";
      }
      else if(langue == 3)
      {
        return "Nie, Mimi je też inne rzeczy, ale Mimi najbardziej lubi czekoladki.";
      }
      else
      {
        return "No, Mimi need to eat others things, but Mimi really like chocolate.";
      }
    }
    else if(quelDialogue == 5)
    {
      if(langue == 2) 
      {
        return "C'est un secret.";
      }
      else if(langue == 3)
      {
        return "To tajemnica.";
      }
      else
      {
        return "It's a secret.";
      }
    }
    else if(quelDialogue == 6)
    {
      if(langue == 2) return "Est-ce que Mimi sais se battre ?";
      else if(langue == 3) return "Czy Mimi wie jak walczyć ?";
      else return "Does Mimi know how to fight ?";
    }
    else if(quelDialogue == 7)
    {
      if(langue == 2) return "Mimi est en faîtes une petite fille qui vit dans un coffre ?";
      else if(langue == 3) return "Mimi to tak naprawdę mała dziewczynka, która żyje w skrzynce ?";
      else return "Mimi is in fact a little girl who live in a chest ?";
    }
    else if(quelDialogue == 8)
    {
      if(langue == 2) return "Mimi ne mange que du chocolat ?";
      else if(langue == 3) return "Czy Mimi je tylko czekoladę ?";
      else return "Mimi only eat chocolate ?";
    }
    else if(quelDialogue == 9)
    {
      if(langue == 2) return "Qu'est ce que Mimi pourra m'offrir en récompense ?";
      else if(langue == 3) return "Co Mimi może zaoferować jako nagrodę ?";
      else return "What does Mimi can offer me as reward ?";
    }
    else if(quelDialogue == 10)
    {
      if(langue == 2) return "Merci beaucoup ! Mimi compte sur vous.";
      else if(langue == 3) return "Dziękuję ci ! Mimi liczy na ciebie";
      else return "Thank you a lot ! Mimi is counting on you.";
    }
    else if(quelDialogue == 11)
    {
      if(langue == 2) return "Oh... Et bien je suppose que je peux encore vivre ici pendant un moment...";
      else if(langue == 3) return "Och... Cóż... Mimi nadal może tu poczekać.";
      else return "Oh... Well, I guess I can still live here for a while...";
    }
    else
    {
      return "ERROR";
    }
  }
  
  String choixRecrutement(byte choix)
  {
    if(choix == 1)
    {
      if(langue == 2) return "Recruter";
      else if(langue == 3) return "Dołącz do drużyny";
      else return "Recruit";
    }
    else if(choix == 2)
    {
      if(langue == 2) return "Puis-je avoir plus d'informations sur toi ?";
      else if(langue == 3) return "Czy możesz opowiedzieć o sobie więcej ?";
      else return "Can I have more information about you ?";
    }
    else if(choix == 4)
    {
      if(langue == 2) return "Pourquoi êtes vous venu dans ce donjon ?";
      else if (langue == 3) return "Dlaczego chcesz udać się do tych niebezpiecznych lochów ?";
      else return "Why did you come in this dungeon ?";
    }
    else
    {
      if(langue == 2) return "Partir";
      else if(langue == 3) return "Odejdź";
      else return "Leave";
    }
  }
  String presentationPersos(Personnage perso)
  {
    if(perso == kya)
    {
      if (langue == 2)
      {
        return
          "La seule chose que tu dois savoir est que je suis une voleuse.\n" +
          "Je ne tuerais pas des gens, je ne suis pas un assassin.";
      } 
      else if (langue == 3)
      {
        return
          "Jedyne co musisz o mnie wiedzieć to fakt, że jestem złodziejką.\n" +
          "Nie zabijam ludzi. Nie jestem mordercą.";
      }
      else
      {
        return
          "The only thing you need to know is I'm a thief.\n" +
          "I won't kill people, I'm not an assassin.";
      }
    }
    else if(perso == gandur)
    {
      if (langue == 2)
      {
        return
          "Je suis Gandur, un puissant magicien.\n" +
          "Je parcours le monde en quête de savoir et de connaissances.\n" +
          "Je connais des sorts puissants, mais je suis spécialisé dans le feu.\n" +
          "Donc pas de magie curative, de magie de l'air, ou d'autre trucs du genre.";
      }
      else if (langue == 3)
      {
        return
          "Jam Gandur, potężny czarnoksiężnik.\n" +
          "Podróżuję po świecie w poszukiwaniu wiedzy.\n" +
          "Znam wiele zaklęć, jednak moją specjalizacją jest magia ognia.\n" +
          "Nie bawię się w uzdrawianie, czary powietrza, ani inne tego typu sztuczki.";
      }
      else
      {
        return
          "I am Gandur, a powerful wizard.\n" +
          "I'm traveling the world on a quest for knowledge\n" +
          "I know a lot of powerful spells, but I'm specialized in the fire.\n" +
          "So no heal, air magic, or things like that.";
      }
    }
    else if(perso == thrug)
    {
      if (langue == 2)
      {
        return
          "Tu veux en connaitre plus sur moi ?\n" +
          "Eh bien, je suis un puissant guerrier, et je ne craint pas la mort.\n" +
          "Si je suis ici, c'est pour combattre des terribles ennemis et devenir célèbre.";
      }
      else if (langue == 3)
      {
        return
          "Chcesz wiedzieć o mnie więcej?\n" +
          "Cóż, jestem doświadczonym wojem i nie lękam się śmierci.\n" +
          "Jestem tu, ponieważ chcę zmierzyć się z przerażającymi bestiami i stać się sławny.";
      }
      else
      {
        return
          "You want to know more about me ?\n" +
          "So, I'm a really powerful warrior and I don't fear the death.\n" +
          "If I'm here, it's because I want to fight terrible enemis to be famous.";
      }
    }
    else if(perso == saria)
    {
      if (langue == 2)
      {
        return
          "E-Eh ? Que devrais-je dire...\n" +
          "M-mon nom est Saria, je pratique la magie de la vie, et je suis née dans un petit village, au sud d'ici.\n" +
          "Je recherche une équipe pour aller dans ce donjon, parce que c'est effrayant d'y aller toute seule\net j'ai perdu quelque chose de très important...";
      }
      else if (langue == 3)
      {
        return
          "U-um? Cóż mogę ci o sobie powiedzieć...\n" +
          "N-nazywam się Saria i jestem adeptką uzdrowicielstwa. Pochodzę z małego miasteczko na południu.\n" +
          "Szukam drużyny, do której mogę dołączyć, aby zapuścić się do lochów, ponieważ boję się iść tam sama.\nZgubiłam tam coś bardzo ważnego.";
      }
      else
      {
        return
          "E-Eh ? What should I tell you...\n" +
          "M-my name is Saria, I'm practicing life magic, and I come from in a little town, in the south.\n" +
          "I'm looking for a team to go in this dungeon, because it's a little scaraffichageStatsy to go alone\nand I lost something really important.";
      }
    }
    else if(perso == elenia)
    {
      if (langue == 2)
      {
        return
          "Mon nom est Elenia et je suis une elfe des fôrets du nord.\n" +
          "Je sais me servir d'un arc, mais je sais aussi utiliser une épée, si besoin.\n" +
          "Je sais également faire quelques potions basiques avec des herbes.\n" +
          "Partir seule dans ce donjon n'est pas une bonne idée, c'est pourquoi je recherche une équipe.";
      } 
      else if (langue == 3)
      {
        return
          "Zwą mnie Elenia. Jestem elfką z północnych lasów.\n" +
          "Jak inni przedstawiciele mej rasy specjalizuję się w łucznictwie.\n" +
          "Radzę sobie z mieczem w razie potrzeby. Wiem jak przygotowywać eliksiry. Znam się na zielarstwie.\n" +
          "Pójście samemu do tych lochów byłoby głupotą, więc poszukuję drużyny.";
      }
      else
      {
        return
          "My name is Elenia, and I'm an elf from the northern forests.\n" +
          "I'm a skilled archer, but I can also handle a sword, if needed.\n" +
          "I also know how to brew some basics potions with herbs.\n" +
          "Going alone in this dungeon seems dangerous, that's why I'm looking for a team.";
      }
    }
    
    return "ERROR";
  }
}