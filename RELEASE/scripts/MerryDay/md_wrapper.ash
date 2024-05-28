import md_library;
import md_login.ash;
import md_logout.ash;
import md_mpburn.ash;
import md_free.ash;





void main() 
{

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
  //Bind Lasagmbie
  //Polka
  //Singers Faithful Ocelot (60)
  //Spirit of Taking (60)
  //Leash of Linguine (60)
  //Empathy
  //Blood Bond (60)
  //Pride
  //Drescher's
  //Curiosity (60)
  //Ruthless Efficiency (30)

  //check for Tunnel duplication

  //mayfly bait

  if(smokepatches_can())
    smokepatches();  
  //abort();
  cli_execute('garbo');
  endDay();

}
