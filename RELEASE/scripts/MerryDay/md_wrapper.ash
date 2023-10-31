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
    cli_execute("breakfast");
  }



  maximize('mp, outfit vile vagrant, equip brimstone bracelet, switch left-hand man', false);
  //use PYEC
  //manaburn
  //cast Aug. 15
  //manaburn
  //eat upto 23 magic sausages
  //mood up

  //Disco Leer
  //Bind Lasagmbie
  //Polka
  //Singers Faithful Ocelot
  //Spirit of Taking
  //Leash of Linguine
  //Empathy
  //Blood Bond
  //Pride
  //Drescher's
  //Curiosity
  //Ruthless Efficiency

  //check for Tunnel duplication

  //mayfly bait

  //smoke monster (polar vortex, mild evil, XO Skeleton, FLUDA)


    cli_execute("garbo");
    cli_execute("familiar stooper");
    cli_execute("drink stillsuit distillate");
    cli_execute("CONSUME NIGHTCAP");

  if(have_skill($skill[Aug. 13th: Left/Off Hander's Day!]))
  {
    use_skill($skill[Aug. 13th: Left/Off Hander's Day!]);
  }
  cli_execute("familiar left-hand man");
  cli_execute("maximize adv");
}

Aria +30
Pride +10
Dreschers +10
MCD +10
Astral Belt +20
Red Lettered +15

parka +33
backup camera +33
Toiletbrush Mustache +25
Yapping Pal +20
Fedora Mounted Fountain +20

Frosty +25
