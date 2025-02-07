
/*
//Swift Clipper
choiceAdventure1349 => 4
//GetOut
choiceAdventure1350 => 1

//Crab Island (I Hope this is consistent?)
choiceAdventure1352 => 1

Go to Port Beginning
Equip piraterealm party Hat
equip piraterealm eyepatch
equip red roger's red right foot

Head to Groggy's

Hire Second mate 
Acquire curious anemometer
Acquire Swift Clipper 

Head to Sea 



ash 
set_property('choiceAdventure1497',3);

while(have_effect($effect[shadow waters]) < 600)
{
    use(1, $item[closed-circuit pay phone]);

    if(item_amount(get_property('rufusQuestTarget').to_item()) >= 3)
    {
        use(1, $item[closed-circuit pay phone]);
        adv1($location[Shadow Rift (The Distant Woods)], -1, "");
    }
    else
    {
        break;
    }
}*/

boolean check_effect(effect e) {
    return have_effect(e) > 0;
}

boolean have(item i) {
    return item_amount(i) > 0;
}

void keepStatsLow() {
  // Loop through each stat
  foreach st in $stats[] {
      // While the buffed stat is greater than 100
      while (my_buffedstat(st) > 100) {
          if (!check_effect($effect[Mush-Mouth]) && mall_price($item[Fun-Guy spore]) < 5000) {
              retrieve_item(1, $item[Fun-Guy spore]);
              use(1, $item[Fun-Guy spore]);
          }

          // Special handling for Muscle stat
          if (st == $stat[Muscle]) {
              if (!have($item[decorative fountain]) && !check_effect($effect[Sleepy]) && mall_price($item[decorative fountain]) < 2000) {
                  retrieve_item(1, $item[decorative fountain]);
              }
              if (!check_effect($effect[Sleepy])) {
                  use(1, $item[decorative fountain]);
              }
          }

          // Special handling for Moxie stat
          if (st == $stat[Moxie]) {
              if (!have($item[patchouli incense stick]) && !check_effect($effect[Far Out]) && mall_price($item[patchouli incense stick]) < 2000) {
                  retrieve_item(1, $item[patchouli incense stick]);
              }
              use(1, $item[patchouli incense stick]);

              if (check_effect($effect[Endless Drool])) {
                  cli_execute("shrug " + $effect[Endless Drool]);
              }
          }

          // General item and effect management
          if (mall_price($item[Mr. Mediocrebar]) < 2000 && !check_effect($effect[Apathy])) {
              retrieve_item(1, $item[Mr. Mediocrebar]);
              use(1, $item[Mr. Mediocrebar]);
          }

          if (check_effect($effect[Feeling Excited])) {
                cli_execute("shrug " + $effect[Feeling Excited]);
          }

          // Remove effects that affect the stat negatively
          foreach ef in my_effects() {
              if (numeric_modifier(ef, st.to_string()) > 0 &&
                  numeric_modifier(ef, "meat drop") <= 0 &&
                  numeric_modifier(ef, "familiar weight") == 0 &&
                  numeric_modifier(ef, "smithsness") == 0 
                  // && numeric_modifier(ef, "item drop") == 0
                  ) {
                  cli_execute("shrug " + ef);
              }
          }
      }
  }
}

void pirates_init()
{
	if (
        get_property("_pirateRealmSailingTurns").to_int() == 0 
        && (get_property("_lastPirateRealmIsland") != "Trash Island") ) 
    {
        
		visit_url("/place.php?whichplace=realm_pirate&action=pr_port");
        equip($slot[hat], $item[piraterealm party hat]);
        equip($slot[acc1], $item[PirateRealm eyepatch]);
        equip($slot[acc2], $item[Red Roger's red right foot]);
        keepStatsLow();
        visit_url("place.php?whichplace=realm_pirate&action=pr_port");
		run_choice(1);
		run_choice(1);
		run_choice(4);
		run_choice(4);
		run_choice(1);
	}
}

void crabSail()
{

}

boolean crabs_run()
{
    return false;
}

boolean giantcrab_run()
{
    return false;
}

void trashSail()
{

}

void main()
{
    pirates_init();
    crabSail();
    crabs_run();
    giantcrab_run();
    trashSail();
}


