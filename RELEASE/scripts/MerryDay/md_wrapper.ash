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
    mpBuff();
    Aug15(); 
    PYEC();
    ClanShower();
    FratNuns();
    Sausages();
  }

  //mood up

  //familiar
  //720 MP - Leash of Linguine (60)
  //600 MP - Empathy (60)
  //18000 HP - Blood Bond (60)
  //600 MP - Curiosity (60)
  
  //600 MP - Disco Leer (60)
  
  //900 MP - Singers Faithful Ocelot (60)
  //3000 MP - Spirit of Taking (60)
  
  //300 MP - Ruthless Efficiency (30)
  
  //Songs (4)
  //600 MP - Polka of Plenty (60)
  //600 MP - Phat Leons (60)
  //Richie Thingfinder - Need Recordings
  //Chorale - Need Recordings


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
