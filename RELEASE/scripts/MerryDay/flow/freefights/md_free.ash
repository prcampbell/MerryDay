import md_library;
import md_outfit;
import md_Librams.ash;
import ff_tentacle;
import ff_leaves;
import ff_lobster;
import ff_nep;
import ff_speakeasy;
import ff_drunks;
import ff_rifts;
import ff_melf;
import ff_halloween;
import ff_shadowbricks;
import md_yacht;
import ff_bander;
import md_mpburn;
import md_dailies;
import ff_free;
import ff_sandworm;
import ff_lov;

location defaultTargetLocation()
{
	if(my_location() != $location[none]
				&& my_location().environment != 'underwater'
				&& my_location().wanderers
			)
			{
				return my_location();				
			}
			else
			{
				return $location[The Haunted Kitchen];
			}
}

location wandererLocation()
{
	location guzzlrLocation = to_location(get_property("guzzlrQuestLocation"));
	location doctorLocation = to_location(get_property("doctorBagQuestLocation"));
	
	if(get_property('_merryDinseyQuest') != '')
	{
		print('Wandering in Dinsey', 'blue');
		if(get_property('_merryDinseyQuest') == 'Social Justice Adventurer I')
		{
			return $location[Pirates of the Garbage Barges];
		}
			
		else if(get_property('_merryDinseyQuest') == 'Social Justice Adventurer II')
		{
			return $location[Uncle Gator's Country Fun-Time Liquid Waste Sluice];
		}
			
		else if(get_property('_merryDinseyQuest') == 'Whistling Zippity-Doo-Dah')
		{
			return $location[The Toxic Teacups];
		}
		else if(get_property('_merryDinseyQuest') == 'Teach a Man to Fish Trash')
		{
			return $location[Pirates of the Garbage Barges];
		}
	}
	else if(doctorLocation != $location[none] && can_adventure(doctorLocation) && doctorLocation.wanderers)
	{
		print('Wandering in doctor location', 'blue');
		return doctorLocation;
	}
	else if(guzzlrLocation != $location[none]  && can_adventure(guzzlrLocation) && guzzlrLocation.wanderers)
	{
		print('Wandering in guzzlr location', 'blue');
		return guzzlrLocation;
	}
	else 
	{
		return defaultTargetLocation();
	}
	return defaultTargetLocation();
}

item[slot] locationNeeds(location loc)
{
	item[slot] needs;
	switch(loc)
	{
		case $location[Pirates of the Garbage Barges]:
			needs[$slot[weapon]] = $item[trash net];
			break;
		case $location[The Toxic Teacups]:
			needs[$slot[hat]] = $item[Dinsey mascot mask];
			break;
		default:
			break;
	}
	return needs;
}

void merry_auto_attack()
{
    //Stasis Fight
    if(get_auto_attack() != 99204675)
        set_auto_attack('StasisFight');
}

void freeruns_run()
{

    GingerLatte();
    while(gap_can())
        gap_run();
    while(gingerbread_bander_can())
        gingerbread_bander_run();
    while(doctor_bander_can())
        doctor_bander_run();
    maximize('familiar weight -tie, equip tearaway pants', false);
    while(fungi_bander_can())
        fungi_bander_run();
}

void fights_run()
{

  while(eaglebrick_can())
  {
    construct_free_outfit($familiar[patriotic eagle]);
    eaglebrick_run();
  }
  if(saber_can())
  {
      saber_run();
  }
  if(moleman_can())
  {
      construct_free_outfit($familiar[grey goose]);
      set_auto_attack('DroneStasis');
      moleman_run();
      set_auto_attack(0);    
  }
  if(smokepatches_can())
    smokepatches();
  if(sandworm_can())
  {
    Sandworm();
  }
  if(LOV_can())
  {
    merry_auto_attack();
    construct_free_outfit();
    LOV_run();
    LibramBurn(false);
  }
  while(shadowrifts_can())
  {
      merry_auto_attack();
      construct_free_outfit(chooseFamiliar());
      rifts_run();
  }
  if(shadowwaters_can())
  {
    shadowwaters_run();
  }
  while(melf_can())
  {
      merry_auto_attack();
      construct_free_outfit($familiar[Machine Elf]);
      if(equipped_item($slot[back]) == $item[buddy bjorn])
        bjornify_familiar($familiar[warbear drone]);
      if(equipped_item($slot[hat]) == $item[crown of thrones])
        enthrone_familiar($familiar[adorable seal larva]);
      melf_run();
  }
  
  if(tentacle_skill_fight_can())
  {
    merry_auto_attack();
    construct_free_outfit();
    tentacle_skill_fight_run();
  }
  if(tentacle_fight_can())
  {
    merry_auto_attack();
    construct_free_outfit();
    tentacle_fight_run();
  }
  while(leaves_can())
  {
    merry_auto_attack();
    construct_free_outfit($phylum[plant]);
    leaves_run();
  }
  while(lobster_can())
  {
    merry_auto_attack();
    construct_free_outfit();
    lobster_run();
  }
  while(nep_free_turn_can())
  {
    merry_auto_attack();
    if(get_property('redSnapperPhylum').to_phylum() != $phylum[dude])
    {
      cli_execute('snapper dude');
    }
    construct_free_outfit($familiar[red-nosed snapper]);
    nep_free_turn_run();  
  }
  while(speakeasy_can())
  {
    merry_auto_attack();
    construct_free_outfit(chooseFamiliar());
    speakeasy_run();  
  }
  while(pygmy_can())
  {
    merry_auto_attack();
    if(get_property('redSnapperPhylum').to_phylum() == $phylum[dude]
      && item_amount($item[human musk]) == 0)
    {
      construct_free_outfit($familiar[red-nosed snapper]);
    }
    else 
    {
      construct_free_outfit($familiar[mini-hipster]);
    }
    pygmy_run();
  }
  halloween_run();
  if(glitch_reward_fight_can())
  {
    merry_auto_attack();
    construct_free_outfit(chooseFamiliar());
    glitch_reward_fight_run();
  }

  

  set_auto_attack(0);
}

void main()
{
  freeruns_run();
  fights_run();
}
