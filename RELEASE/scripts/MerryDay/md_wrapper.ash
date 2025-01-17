import md_library;
import md_outfit;
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

  if(familiars_should())
    familiars_run();
  
  if(moleman_can())
  {
      use_familiar($familiar[grey goose]);
      maximize('familiar exp', false);
      set_auto_attack('DroneStasis');
      moleman_run();
      set_auto_attack(0);    
  }

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

  while(melf_can())
  {
      set_auto_attack('StasisFight');
      construct_free_outfit();
      melf_run();
      set_auto_attack(0);
  }

  // Regular free fights start here

    if(tentacle_skill_fight_can())
    {
      set_auto_attack('StasisFight');
      construct_free_outfit();
      tentacle_skill_fight_run();
    }
    if(tentacle_fight_can())
    {
      set_auto_attack('StasisFight');
      construct_free_outfit();
      tentacle_fight_run();
    }
    if(leaves_can())
    {
      set_auto_attack('StasisFight');
      construct_free_outfit();
      equip($slot[pants], $item[tearaway pants]);
      leaves_run();
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
