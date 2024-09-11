import md_library;
import md_login.ash;
import md_logout.ash;
import md_mpburn.ash;
import md_free.ash;





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
  if(!get_property('breakfastCompleted').to_boolean())
  {
    startDay();
    cli_execute("csend to buffy || 600 Empathy 600 Jingle Bells 600 Polka 600 Fat Leon");
    mpBuff();
    Aug15(); 
    PYEC();
    ClanShower();
    FratNuns();
    Sausages();

    cli_execute('uneffect Mojomuscular Melody');
  }

  //mood up

  //buffbot request:

  /*



  
  
  */

  //900 MP - Singers Faithful Ocelot (60) [420 MP]
  //3000 MP - Spirit of Taking (60) [2520 MP]
  
  //Songs (4)
  //Richie Thingfinder - Need Recordings
  //Chorale - Need Recordings

//18000 HP - Blood Bond (60)

  //check for Tunnel duplication

  //mayfly bait

  if(smokepatches_can())
    smokepatches();
  if(saber_can())
      saber_run();
  abort();
  cli_execute('garbo');
  endDay();

}
