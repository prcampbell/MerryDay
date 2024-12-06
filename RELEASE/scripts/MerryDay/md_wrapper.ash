import md_library;
import md_login.ash;
import md_logout.ash;
import md_mpburn.ash;
import md_free.ash;
import md_dailies.ash;
import md_diet.ash;
import md_buffs.ash;
import md_meat.ash;




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

  //check for Tunnel duplication

  //mayfly bait

  if(smokepatches_can())
    smokepatches();
  if(saber_can())
      saber_run();
  if(thesis_can())
    thesis_run();


  /*To hell with Garbo's diet.*/
  fillSpleen();
  fillInitialStomach();
  fillInitialLiver();
  
  if(embezzlers_can())
    embezzlers_run();

  abort();

/*
Pure Meat

Apriling Band Helmet
Buddy Bjorn w Happy Medium
Jurassic Parka
Fourth of May Cosplay Saber
Fully charged Latte
Repaid Diaper
Yamtility Belt
Wormwood Wedding Ring
Ring of the Skeleton Lord


while($effect[shadow waters].have_effect() < my_turns())
{
  call rufus - Get Item Quest
  call rufus - Get Lodestone
  adv1 shadow rift


}

*/


  cli_execute('garbo quick');
  endDay();

}
