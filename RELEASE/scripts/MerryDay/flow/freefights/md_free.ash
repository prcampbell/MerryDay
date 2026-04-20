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
import ff_smokepatches;
import ff_sandworm;
import ff_lov;
import ff_sheriff;
import ff_lsc;
import ff_bcz;
import ff_mushroom;
import ff_cyberfight;

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
  

  while(leaves_can())
  {
    merry_auto_attack();
    construct_free_outfit($phylum[plant]);
    leaves_run();
  }
  if(mushroom_can())
  {
      merry_auto_attack();
      construct_free_outfit($phylum[plant]);
      mushroom_run();
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
      use_familiar($familiar[red-nosed snapper]);
      cli_execute('snapper dude');
    }
    construct_free_outfit($phylum[dude]);
    nep_free_turn_run();  
  }
  while(speakeasy_can())
  {
    merry_auto_attack();
    construct_free_outfit();
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
    construct_free_outfit();
    glitch_reward_fight_run();
  }
  while(sheriff_can())
  {
      sheriff_run();
  }
  while(lcs_can())
  {
      lcs_run();
  }
  while(bcz_can())
  {
    bcz_run(); 
  }
  set_auto_attack(0);
}

void endofday_run()
{
  if(get_property('redSnapperPhylum').to_phylum() != $phylum[horror])
  {
    use_familiar($familiar[red-nosed snapper]);
    cli_execute('snapper horror');
  }
  if(tentacle_skill_fight_can())
  {
    merry_auto_attack();
    construct_free_outfit($phylum[horror]);
    tentacle_skill_fight_run();
  }
  if(tentacle_fight_can())
  {
    merry_auto_attack();
    construct_free_outfit($phylum[horror]);
    tentacle_fight_run();
  }
  flood_cyber();
  while(cyberfight_can())
  {
    construct_free_outfit();
    cyberfight_run();
  }
  set_auto_attack(0);
  
  
}

void main()
{
  freeruns_run();
  fights_run();
}
