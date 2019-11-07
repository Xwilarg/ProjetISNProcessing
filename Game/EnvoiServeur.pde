/*
 * Crée par Christian CHAUX le 11/06/2016
 * Dernières modifications le 22/06/2016
 */
 
class EnvoiServeur
{
  
  EnvoiServeur()
  {
    nbEssais = 0;
    jamaisConnecte = true;
  }
   
  String msgRecu;
  byte nbEssais;
  boolean jamaisConnecte;

  void envoiServ(String aEnvoyer) {
    if (msgRecu == null)
      c.write(aEnvoyer);
    
    if (c.available() > 0 && msgRecu == null) {
      msgRecu = c.readString();
    } else if (msgRecu != null) {
    } else if (jamaisConnecte){
      redefClient();
      jamaisConnecte = false;
    }
    
    nbEssais++;
  }
  
  String rMsgRecu()
  {
    return msgRecu;
  }
  byte rNbEssais(){return nbEssais;}
  
  void resetMsgRecu()
  {
    msgRecu = null;
    nbEssais = 0;
  }
}