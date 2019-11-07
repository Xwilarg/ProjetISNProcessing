/*
 * Crée par Christian CHAUX le 20/05/2016
 * Dernières modifications le 22/05/2016
 */
 
class Potion extends Objet
{
  Potion(byte id, short nombreEmpile)
  {
    super(id, nombreEmpile);
  }
  
  void gestionImages()
  {
    if(id == 1)this.image = iPotionVie;
    else if(id == 2) this.image = iPotionMana;
    else if(id == 3) this.image = iPotionVigueur;
    else if(id == 4) this.image = iPotionMalus;
  }
  
  void action()
   {
     if(id == 1)
       joueur.diminuerVie((short)-50, null);
     if(id == 2)
     {
       if(joueur.returnValeurClasse() == 2 || joueur.returnValeurClasse() == 3)
         joueur.restaureMana((byte)50);
       else
         joueur.genererAffDgts(300001);
     }
     if(id == 3)
     {
       if(joueur.returnValeurClasse() == 0 || joueur.returnValeurClasse() == 1)
         joueur.restaureVigueur((byte)50);
       else
         joueur.genererAffDgts(300001);
     }
     if(id == 4)
     {
       byte chance = (byte)(random(2));
       if(chance == 1)
         joueur.diminuerVie((short)50, null);
       else
         joueur.diminuerVie((short)-50, null);
     }
   }
}