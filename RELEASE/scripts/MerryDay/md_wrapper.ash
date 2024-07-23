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

  //Disco Leer (60)
  //Singers Faithful Ocelot (60)
  //Spirit of Taking (60)
  //Leash of Linguine (60)
  //Empathy (60)
  //Blood Bond (60)
  //Pride (60)
  //Drescher's (30)
  //Curiosity (60)
  //Ruthless Efficiency (30)
  
  //?? Bind Lasagmbie

  //check for Tunnel duplication

  //mayfly bait

  if(smokepatches_can())
    smokepatches();
  if(saber_can())
      saber_run();
  //abort();
  cli_execute('garbo');
  endDay();

}
