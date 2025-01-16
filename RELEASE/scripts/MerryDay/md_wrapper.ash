import md_library;
import md_login.ash;
import md_logout.ash;
import md_mpburn.ash;
import md_free.ash;
import md_dailies.ash;
import md_diet.ash;
import md_buffs.ash;
import md_embezzlers;
import md_familiars;
import ff_melf.ash;




void main() 
{
  cli_execute('refresh all');
  /* Day Plan

  Breakfast
  Day Prep
  Fork:
    - Garbo Day?
    - Shell Day? (Don't need +MEAT part of mood, don't run turns, do free fights, so something manual can be done)
  Loop
  Garbo prep
  Nightcap


  */

  startDay();
  dailyEffects();
  dailyItems();

  if($effect[Jingle Jangle Jingle].have_effect() < 600)
  {
    cli_execute("csend to buffy || 600 Empathy 600 Jingle Bells 600 Polka 600 Fat Leon");
  }
  unlockLatte();
  mpBuff();
  Aug15(); 
  PYEC();
  ClanShower();
  FratNuns();
  Sausages();
  GingerLatte();

  if($effect[The Magical Mojomuscular Melody].have_effect() > 0)
    cli_execute('uneffect Mojomuscular Melody');

  /*To hell with Garbo's diet.*/
  fillSpleen();
  fillInitialStomach();
  fillInitialLiver();

  if(smokepatches_can())
    smokepatches();
  if(saber_can())
      saber_run();
  if(thesis_can())
    thesis_run();
  if(profsausage_can())
  {
      profsausage_run();
  }

  if(melf_can())
  {
      set_auto_attack('StasisFight');
      equip($slot[hat], $item[daylight shavings helmet]);
      equip($slot[back], $item[buddy bjorn]);
      bjornify_familiar(get_best_bjorn());
      equip($slot[shirt], $item[jurassic parka]);
      equip($slot[weapon], $item[june cleaver]);
      equip($slot[off-hand], $item[KoL Con 13 snowglobe]);
      if(available_amount($item[stinky cheese diaper]) == 0)
      cli_execute('fold stinky cheese diaper');
      equip($slot[pants], $item[stinky cheese diaper ]);
      equip($slot[acc1], $item[Lil' Doctor&trade; bag]);
      equip($slot[acc2], $item[lucky gold ring]);
      equip($slot[acc3], $item[mr. cheeng's spectacles]);
      melf_run();
      set_auto_attack(0);
  }
        


  
  if(embezzlers_can())
    embezzlers_run();



/*

while($effect[shadow waters].have_effect() < my_turns())
{
  call rufus - Get Item Quest
  call rufus - Get Lodestone
  adv1 shadow rift


}




  cli_execute('garbo quick');
  endDay();
*/
}
