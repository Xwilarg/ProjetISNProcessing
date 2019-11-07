/*
 * Crée par Christian CHAUX le 08/04/2016
 * Dernières modifications le 23/07/2016
 */
 
class Succes
{
  byte id;
  String nom, description;
  boolean estObtenu;
  short hauteur;
  Compteur compSucces = new Compteur();
  Succes(byte id)
  {
    this.id = id;
    estObtenu = false;
    defAttributs();
  }
  
  void defAttributs()
  {
    if(id == 0)
    {
      nom = "Game launched !";
      description = "You launched the game, congratulation !\nThis in only an achievement for testing the achievement class.\nIn fact, you achieved nothing special yet, sorry...\nBut don't give up !";
    }
    else if(id == 1)
    {
      nom = "More than 1500 points !";
      description = "Unbelievable !\nYou finished the game with more than 1500 points ?\nGreat job !";
    }
    else if(id == 2)
    {
      nom = "Untouchable";
      description = "Even with a lot of teammates, you managed to not being hit for a whole level.\nNice job, but don't rush the levels too much if you don't want to miss things.";
    }
    else if(id == 3)
    {
      nom = "Lone wolf";
      description = "Going alone is indeed a good way to protect your alliees.\nWasn't it hard to go that far ? You deserve an achievement for that !";
    }
    else if(id == 4)
    {
      nom = "Tea time";
      description = "Hi, welcome in this game :)\nI hope you'll like it.";
    }
    else if(id == 5)
    {
      nom = "Baguette";
      description = "Bienvenue sur ce jeu, toujours heureux de croiser des français.\nAmusez vous bien.";
    }
    else if(id == 6)
    {
      nom = "Bigos";
      description = "Witaj. Życzę Ci przyjemnej rozgrywki. Baw się dobrze !";
    }
    else if(id == 11)
    {
      nom = "Saria's exorcism";
      description = "You cured Saria of her curse, and achieved her quest.\nShe can know live without the fear of it.";
    }
    // Les quètes suivantes ne sont pas encore implémenté dans le jeu.
    /*else if(id == 7)
    {
      nom = "The love for a little sister";
      description = "Congratulation, you complete the main quest and saved your little sister :).";
    }
    else if(id == 8)
    {
      nom = "A new chest for Mimi";
      description = "You complete the Mimic's quest, I'm sure she is really thanksful for that.";
    }
    else if(id == 9)
    {
      nom = "Mimi deserve the best";
      description = "You gave the best chest you can to Mimi, that's really nice of you !";
    }
    else if(id == 10)
    {
      nom = "So it have a end...";
      description = "You reached the last floor of the dungeon and achieved Thrug's quest.\nWho thought it had an end ?";
    }
    else if(id == 11)
    {
      nom = "Saria's exorcism";
      description = "You cured Saria of her curse, and achieved her quest.\nShe can know live without the fear of it.";
    }
    else if(id == 12)
    {
      nom = "This is how fire magic was made";
      description = "You discovered the secret of the fondations of the fire magic and achieved Gandur's quest.\nWell, I least Gandur discovered them, you don't have enought knowledge to understand any of that.";
    }
    else if(id == 13)
    {
      nom = "Everyone have their secrets...";
      description = "You achieved Kya's quest and... you finally don't know really more about her...";
    }
    else if(id == 14)
    {
      nom = "Elfs savior";
      description = "You helped Elenia to find what she need to save her natal village and you complete her quest. Now, everything are place on her shoulders.";
    }
    else if(id == 15)
    {
      nom = "Everything have a price";
      description = "You accomplished Thrug's quest, but you paid the price of it.\nWas it really worth the cost ?";
    }
    else if(id == 16)
    {
      nom = "So, this is REALLY the end";
      description = "Who though there was another level ?\nThis time you REALLY found the bottom of this dungeon, nice job !";
    }
    else if(id == 17)
    {
      nom = "A bless for her";
      description = "You managed to cure Saria, even without the amulette. That's another step you made to improve her life.";
    }
    else if(id == 18)
    {
      nom = "Ate by her curse";
      description = "You made your choice, and condemn Saria...";
    }
    else if(id == 19)
    {
      nom = "The most important page";
      description = "You found the missing page and give it to Gandur, the book is now complete.";
    }
    else if(id == 20)
    {
      nom = "Only ashes remain";
      description = "You burn Gandur's book, maybe some secret need to stay hidden.";
    }
    else if(id == 21)
    {
      nom = "Her only true friend";
      description = "Kya finally trusted you enought to reveal you her secret.";
    }
    else if(id == 22)
    {
      nom = "Curiosity is a bad flaw";
      description = "You attempted to discover Kya's secret, maybe it wasn't your best idea.";
    }
    else if(id == 23)
    {
      nom = "Big tasks need to be share";
      description = "You went with Elenia to her natal village to save it.";
    }
    else if(id == 24)
    {
      nom = "Butterfly effect";
      description = "The modified an ingredient before giving the potion of Elenia. Potions need precise ingredients to be made.";
    }*/
  }
  
  void afficher()
  {
    stroke(10);
    fill(124, 252, 0, 100);
    rect(menuP.tailleFenX()/2-300, 100, 600, 140);
    textSize(20);
    fill(0, 220);
    text(nom, menuP.tailleFenX()/2-120, 130);
    textSize(12);
    text(description, menuP.tailleFenX()/2-280, 150);
    noStroke();
  }
  
  void obtenirSucces()
  {
    if(!estObtenu && !debugFonctionsAutorise)
    {
      if(id == 1 && score > 1500
      || id == 3 && niveauDonjonAlea == 5 && seul
      || id == 4 && langue == 1
      || id == 5 && langue == 2
      || id == 6 && langue == 3)
      {
        estObtenu = true;
        compSucces.initialiser((byte)5);
      }
    }
    else if(estObtenu && debugFonctionsAutorise) estObtenu = false;
    else if(estObtenu && !compSucces.estFini()) afficher();
  }
  
  void activerSucces()
  {
    estObtenu = true;
    compSucces.initialiser((byte)5);
  }
}