import md_library;
import md_outfit;
import ff_tentacle;
import ff_leaves;
import ff_lobster;
import ff_nep;
import ff_speakeasy;
import ff_pygmy;
import ff_

void merry_auto_attack()
{
    //Stasis Fight
    if(get_auto_attack() != 99204675)
        set_auto_attack(99204675);
}

void main()
{
    if(tentacle_skill_fight_can())
  {
    merry_auto_attack()
    construct_free_outfit(chooseFamiliar());
    tentacle_skill_fight_run();
  }
  if(tentacle_fight_can())
  {
    merry_auto_attack()
    construct_free_outfit(chooseFamiliar());
    tentacle_fight_run();
  }
  while(leaves_can())
  {
    merry_auto_attack()
    construct_free_outfit(chooseFamiliar());
    equip($slot[pants], $item[tearaway pants]);
    leaves_run();
  }
  if(lobster_can())
  {
    merry_auto_attack()
    construct_free_outfit();
    lobster_run();
  }
  while(nep_free_turn_can())
  {
    merry_auto_attack()
    if(get_property('redSnapperPhylum').to_phylum() != $phylum[dude])
    {
      cli_execute('snapper dude');
    }
    construct_free_outfit($familiar[red-nosed snapper]);
    nep_free_turn_run();  
  }
  while(speakeasy_can())
  {
    merry_auto_attack()
    construct_free_outfit(chooseFamiliar());
    speakeasy_run();  
  }
  while(pygmy_can())
  {
    merry_auto_attack()
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
  while(shadowrifts_can())
  {
      merry_auto_attack()
      construct_free_outfit(chooseFamiliar());
      rifts_run();
  }
  if(shadowwaters_can())
  {
          shadowwaters_run();
  }

    
set_auto_attack(0);
/*
  while(gap_can())
      gap_run();
  while(gingerbread_bander_can())
      gingerbread_bander_run();
  while(doctor_bander_can())
      doctor_bander_run();
  if(fungi_bander_can())
  {
    maximize('familiar weight, equip tearaway pants', false);
    while(fungi_bander_can())
        fungi_bander_run();   
  }
  if(sandworm_can())
	{
		Sandworm();
	}    
*/
}