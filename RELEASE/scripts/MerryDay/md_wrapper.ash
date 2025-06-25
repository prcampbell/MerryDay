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
  print('Day Started', 'green');
  dinsey();
  dailyItems();
  dailyEffects();


  if($effect[Jingle Jangle Jingle].have_effect() < 600)
  {
    cli_execute("csend to buffy || 600 Empathy 600 Jingle Bells 600 Polka 600 Fat Leon");
  }
  unlockLatte();
  pirates_init();
  Sailing();
  windy_crabs_run();

  if(
    !to_boolean(get_property("expressCardUsed"))
    && !get_property('_aug15Cast').to_boolean()
    && !get_property("_aprilShower").to_boolean()
    && get_property("sidequestNunsCompleted")=="fratboy" && get_property("nunsVisits").to_int() < 3
    && get_property("_sausagesEaten").to_int() < 23 && available_amount($item[magical sausage casing]) > 0
  )
  {
    mpBuff();
    Aug15(); 
    PYEC();
    ClanShower();
    FratNuns();
    Sausages();    
  }

  GingerLatte();

  if($effect[The Magical Mojomuscular Melody].have_effect() > 0)
    cli_execute('uneffect Mojomuscular Melody');

  dailyFamiliarBuffs();
  dailyMeatBuffs();
  dailyItemBuffs();
  if(familiars_should())
    familiars_run();
  
  if(moleman_can())
  {
      use_familiar($familiar[grey goose]);
      maximize('familiar exp', false);
      set_auto_attack('DroneStasis');
      moleman_run();
      set_auto_attack(0);    
  }

  if(smokepatches_can())
    smokepatches();
  if(saber_can())
      saber_run();

  if(thesis_can())
    thesis_run();
  if(profsausage_can())
  {
      profsausage_run();
  }

//Let's grab some costumes
  while(eaglebrick_can())
  {
    construct_free_outfit();
    eaglebrick_run();
  }
  while(available_amount($item[li'l pirate costume]) == 0)
  {
    pgb_free_run();
  }

  while(melf_can())
  {
      set_auto_attack('StasisFight');
      construct_free_outfit();
      //don't runthings we need to track
      if(equipped_item($slot[back]) == $item[buddy bjorn])
        bjornify_familiar($familiar[warbear drone]);
      if(equipped_item($slot[hat]) == $item[crown of thrones])
        enthrone_familiar($familiar[warbear drone]);
      
      melf_run();
      set_auto_attack(0);
  }
  if(!halloween_available())
  {
      halloween_map_use();
  }
  if(halloween_available())
  {
      trick_run();
  }

  // Regular free fights start here

  if(tentacle_skill_fight_can())
  {
    set_auto_attack('StasisFight');
    familiarDrops();
    construct_free_outfit();
    tentacle_skill_fight_run();
    set_auto_attack(0);
  }
  if(tentacle_fight_can())
  {
    set_auto_attack('StasisFight');
    familiarDrops();
    construct_free_outfit();
    tentacle_fight_run();
    set_auto_attack(0);
  }
  while(leaves_can())
  {
    set_auto_attack('StasisFight');
    familiarDrops();
    construct_free_outfit();
    equip($slot[pants], $item[tearaway pants]);
    leaves_run();
    set_auto_attack(0);
  }
  if(lobster_can())
  {
    set_auto_attack('StasisFight');
    construct_free_outfit();
    lobster_run();
    set_auto_attack(0);
  }
  while(nep_free_turn_can())
  {
    set_auto_attack('StasisFight');
    familiarDrops();
    construct_free_outfit();
    nep_free_turn_run();
    set_auto_attack(0);  
  }
  while(speakeasy_can())
  {
    set_auto_attack('StasisFight');
    familiarDrops();
    construct_free_outfit();
    speakeasy_run();
    set_auto_attack(0);  
  }
  while(pygmy_can())
  {
    use_familiar($familiar[mini-hipster]);
    set_auto_attack('StasisFight');
    construct_free_outfit();
    pygmy_run();
    set_auto_attack(0);
  }
  while(shadowrifts_can())
  {
      set_auto_attack('StasisFight');
      familiarDrops();
      construct_free_outfit();
      rifts_run(); 
      set_auto_attack(0);
  }
  if(shadowwaters_can())
      shadowwaters_run();

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
  cli_execute('combo');

/*We start running adventures here*/
  
  if(embezzlers_can())
    embezzlers_run();


  
  crabs_run();
  Sailing();
  if(roach_can())
  {
      roach_run();
  }
  crabs_run();
  Sailing();
  storm_run();

  if(get_property('_mimicEggsObtained').to_int() < 11 && get_property('_sourceTerminalDigitizeUses').to_int() < 3)
  {
    item[slot] required_equips;
    required_equips[$slot[off-hand]] = $item[roman candelabra];
    if(get_property('sourceTerminalEducate1') != 'digitize.edu'
        && get_property('sourceTerminalEducate2') != 'digitize.edu')
    {
        cli_execute('terminal educate digitize.edu');
    }
    construct_free_outfit(required_equips, $familiar[chest mimic]);
    set_auto_attack('MimicEggs');
    witchess_run();
    set_auto_attack(0);
  }


	set_property('afterAdventureScript', 'md_postadventure.ash');

  for x from 0 to 100 by 1 
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
  while(my_spleen_use() < spleen_limit())
  {
    cli_execute('synthesize greed');
  }
  cli_execute('CONSUME ALL');
  while(my_adventures() > 0)
  {
    barf_run();
  }

  endDay();

}
