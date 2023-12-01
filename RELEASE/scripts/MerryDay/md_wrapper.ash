import md_library;
import Librams;
import md_login.ash;

void mpBuff()
{
  //Slotless All Stats
  //Telescope
  if (get_campground() contains $item[discount telescope warehouse gift certificate] && get_property("telescopeUpgrades").to_int() > 0 && 
    get_property("telescopeLookedHigh") == "false") 
    cli_execute("telescope high");
  if(!get_property("_streamsCrossed").to_boolean())
    cli_execute("crossstreams");
  if(!get_property(" _ballpit").to_boolean())
    cli_execute("ballpit");
  ensure_effect($effect[Broad-Spectrum Vaccine]);
  ensure_effect($effect[Feeling Excited]);

  //monorail buff
  if (!get_property('_lyleFavored').to_boolean()) 
  {
    ensure_effect($effect[Favored by Lyle]);
  }

  //Myst Buffs
  if(have_effect($effect[[1457]blood sugar sauce magic]) == 0)
    use_skill($skill[Blood Sugar Sauce Magic]);
  ensure_effect($effect[We're All Made of Starfish]); //'
  ensure_effect($effect[Quiet Judgement]);
  ensure_effect($effect[Song of Bravado]);
  ensure_effect($effect[Big]);
  ensure_song($effect[The Magical Mojomuscular Melody]);
  ensure_song($effect[Stevedave's Shanty of Superiority]); //'
  ensure_effect($effect[Uncucumbered]);
  maximize('mp, outfit vile vagrant, equip brimstone bracelet, switch left-hand man', false);
}

void Aug15() 
{
   
    if(have_skill($skill[Aug. 15th: Relaxation Day!]))
    { 
      LibramBurn(true);
      use_skill($skill[Aug. 15th: Relaxation Day!]);
      LibramBurn();
    }
    
}

void PYEC() 
{
	if ( !(to_boolean(get_property("expressCardUsed"))) && (take_stash(1 , $item[Platinum Yendorian Express Card])||item_amount($item[Platinum Yendorian Express Card]) > 0) ) 
  {
		LibramBurn(true);
		use(1,$item[Platinum Yendorian Express Card]);
		LibramBurn(false);
	}
}

void ClanShower() 
{
	if ( !get_property("_aprilShower").to_boolean() && switchClan(84165) ) {  //AfHeck
		mpRestored = 1000;
		if ( mpRestored < my_maxmp()-my_mp() ) 
    {
			cli_execute("shower hot");
			LibramBurn();
		}
	}
}

void FratNuns() 
{
	while ( get_property("sidequestNunsCompleted")=="fratboy" && get_property("nunsVisits").to_int() < 3) {
		if ( mpRestored < my_maxmp()-my_mp() ) 
    {
			cli_execute("nuns");
			LibramBurn();
		}
		else
			break;
	}
}



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
  }

  //eat upto 23 magic sausages
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

  //smoke monster (polar vortex, mild evil, XO Skeleton, FLUDA)
//abort();

    cli_execute("garbo;familiar stooper;drink stillsuit distillate;CONSUME NIGHTCAP;familiar left-hand man;maximize adv");


  if(have_skill($skill[Aug. 13th: Left/Off Hander's Day!]))
  {
    use_skill($skill[Aug. 13th: Left/Off Hander's Day!]);
  }

}
