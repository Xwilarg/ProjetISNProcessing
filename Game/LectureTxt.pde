/*
 * Crée par Christian CHAUX en début 2016
 * Dernières modifications le 19/06/2016
 */

import java.io.FileReader;
import java.io.FileNotFoundException;

class LectureTxt{
  
  char[][] dialoguePancarte = new char[50][10];
  char[][] dialoguePNJ = new char[50][10];
  String nomFile;
  
  LectureTxt(String nomFile)
  {
    this.nomFile = nomFile;
  }
  
  void changerNomFile(String nouvNom)
  {
    nomFile = nouvNom;
  }
  
  void creationCarte()
  {
    if(nomFile.equals("Eve"))
      file = new File("Cartes/Boss/" + nomFile + ".mlnoe");
    else if(carteActuelle == tuto)
      file = new File("Cartes/Tuto/" + nomFile + ".mlnoe");
    else if(carteActuelle == intro)
      file = new File("Cartes/Intro/" + nomFile + ".mlnoe");
    else
      file = new File("Cartes/" + nomFile + ".mlnoe");
    println("Nom du fichier: " + nomFile + ".mlnoe");
    short i = 0, y = 0;
    byte nbPancarte = 0, nbPNJ = 0;
    try{
      FileReader fr = new FileReader(file); 
      char [] fileR = new char[1500];
      fr.read(fileR); // reads the content to the array
      for(char c : fileR)
      {
        if(c == ' ')
        {
           i++;
        }
        else if(c == '\n')
        {
          i = 0;
          y++;
        }
        else
        {
          try{
            carteActuelle.changerValeurCase((byte)i, (byte)y, c);
          } catch(Exception ex) {print(" [ERREUR] " + ex.getMessage());}
        }
        if(c == 'P')
        {
           nbPancarte++;
        }
        else if(c == 'J')
        {
           nbPNJ++;
        }
      }
      fr.close();
      println("\n" + i + "\n" + y);
    }catch(FileNotFoundException fe){
      dial.afficheBoiteErreur("Error, file " + nomFile + ".mlnoe not found. \nPlease check if the file is on the right folder.");
    }catch(IOException fe){
      dial.afficheBoiteErreur("Error, the file can't be read. \nMaybe the file is write-protected ?");
    }
    
    
    for(int z = 0 ; z < dialoguesPNJ.length ; z++) // Pour éviter que tous les String soit égal à null.
      dialoguesPNJ[0][z] = "";
      
    file = new File("Cartes/" + nomFile + "_d.mlnoe");
    
    try{
      FileReader fr = new FileReader(file);
      char [] fileR = new char[1500];
      fr.read(fileR); // reads the content to the array
      byte avanceeDialogue = 0;
      byte quelPNJ = 0;
      for(char c : fileR)
      {
        if(c == '#' || c == '\n') avanceeDialogue++;
        else if(c == ' ' || c == '"') continue;
        else if(c == '_') dialoguesPNJ[quelPNJ][avanceeDialogue] += " ";
        else if(c == '/'){ quelPNJ = 0; avanceeDialogue = 0; }
        else dialoguesPNJ[quelPNJ][avanceeDialogue] += c;
      }
      fr.close();
      for(int r = 0 ; r < dialoguesPNJ.length ; r++)
        println(dialoguesPNJ[quelPNJ][r]);
    }catch(FileNotFoundException fe){
    }catch(IOException fe){
      dial.afficheBoiteErreur("Error, the file can't be read. \nMaybe the file is write-protected ?");
    }
  }
}