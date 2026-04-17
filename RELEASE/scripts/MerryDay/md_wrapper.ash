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
import ff_melf;
import ff_moleman;
import ff_bander;
import ff_lobster;
import ff_nep;
import ff_drunks;
import ff_rifts;
import ff_shadowbricks;
import ff_speakeasy;
import ff_sandworm.ash;
import ff_witchess.ash;
import ff_halloween.ash;
import md_pirates.ash;
import md_copies.ash;
import md_yacht.ash;
import md_dinsey.ash;
import md_spacegate.ash;
import md_pocketprofessor.ash;
import md_mimic.ash;
import md_space.ash;

boolean day_over()
{
  return 
    my_fullness() >= fullness_limit()
    && my_inebriety() >= inebriety_limit()
    && my_spleen_use() >= spleen_limit()
    && my_adventures() == 0;
}

int reserve_advs()
{
  int advs = 2;
  if(grimacemap_can())
  {
    advs += 1;
  }
  if(get_property('_lastPirateRealmIsland') == "Trash Island")
  {
    advs += 17;
  }

  return advs;
}


void main(string command) 
{
  boolean free = false;
  string [int] commands = command.to_lower_case().split_string("\\s+");
  for(int i = 0; i < commands.count(); ++i)
	{
		switch(commands[i])
		{
      case "free":
        free = true;
        break;
      case "garbage":
        free = false;
        break;
			case "help":
				print("md_wrapper.ash Commands:", "blue");
				print("free - use no adventures, don't open dinsey.");
				
				return;
			default:
				print('Unknown command "' + commands[i] + '"', "red");
				print('Try "md_wrapper help" to get a list of valid commands.', "red");
				return;
		}
	}


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
  print('Day Started', 'green');

  if(!free)
  {
    sail_to_crab();
  }

  if(
    !to_boolean(get_property("expressCardUsed"))
    && !get_property('_aug15Cast').to_boolean()
    && !get_property("_aprilShower").to_boolean()
    && get_property("sidequestNunsCompleted")=="fratboy" && get_property("nunsVisits").to_int() < 3
  )
  {
    mpBuff();
    Aug15(); 
    PYEC();
    ClanShower();
    FratNuns();




    if(my_mp() > 200)
    {
      moodUp(650, $skill[Only Dogs Love a Drunken Sailor], $effect[Only Dogs Love a Drunken Sailor]);
      moodUp(650, $skill[Ruthless Efficiency], $effect[Ruthlessly Efficient]);
      moodUp(650, $skill[Disco Leer], $effect[Disco Leer]);
      moodUp(650, $skill[empathy of the newt], $effect[Empathy]);
      moodUp(650, $skill[Curiosity of Br'er Tarrypin], $effect[Curiosity of Br'er Tarrypin]);
      moodUp(650, $skill[leash of linguini], $effect[leash of linguini]);
      moodUp(650, $skill[empathy of the newt], $effect[Thoughtful Empathy]);
    }


    if($effect[The Magical Mojomuscular Melody].have_effect() > 0)
      cli_execute('uneffect Mojomuscular Melody');  
  }

  dailyItems();
  dailyEffects();
 
  dailyItemBuffs();
  unlockLatte();
  dailyFamiliarExpBuffs();
  freeruns_run();
  fights_run();
  if(!free)
  {
    dinsey(); 
    while(available_amount($item[li'l pirate costume]) == 0)
    {
      pgb_free_run();
    }
    while(my_spleen_use() < spleen_limit() && have_effect($effect[Synthesis: Greed]) < 500)
    {
      cli_execute('synthesize greed');
    }
    dailyMeatBuffs();
    if(embezzlers_can())
    {
      embezzlers_run();
    }
    crabs_run();
    Sailing();

    if(roach_can())
    {
        roach_run();
    }
    if(prof_can($monster[cockroach]))
    {
        prof_run($monster[cockroach]);
    }
    if(mimic_can($monster[cockroach]))
    {
        mimic_run($monster[cockroach]);
    }
    cli_execute('CONSUME ALL');
    set_property('afterAdventureScript', 'md_postadventure.ash');
    while(my_adventures() > reserve_advs())
    {
      diet_run();
      barf_run();
    }
    pirate_cleanup();
    if(grimacemap_can()) 
      grimacemap_run();
  }
    
  abort();



/*We start running adventures here*/

  
  Sailing();
  storm_run();


  for x from 0 to 20 by 1 
  {
    barf_run();
  }

  if(spacegate_can())
  {
      spacegate_init();
      while(get_property('_spacegateTurnsLeft').to_int() > 0)
      {
          spacegate_run();
      }
  }
  yachting();
  



  if(day_over())
  {
    endDay();
  }
  

}
