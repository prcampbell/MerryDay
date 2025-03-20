
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

void keepStatsLow() 
{
  // Loop through each stat
    foreach st in $stats[] 
    {
        // While the buffed stat is greater than 100
        while (my_buffedstat(st) > 100) 
        {
            if (!check_effect($effect[Mush-Mouth]) && mall_price($item[Fun-Guy spore]) < 5000) 
            {
                retrieve_item(1, $item[Fun-Guy spore]);
                use(1, $item[Fun-Guy spore]);
                if(my_buffedstat(st) <= 100)
                    break;
            }

            // Special handling for Muscle stat
            if (st == $stat[Muscle]) 
            {
                if (!have($item[decorative fountain]) 
                    && !check_effect($effect[Sleepy]) 
                    && mall_price($item[decorative fountain]) < 2000) 
                {
                    retrieve_item(1, $item[decorative fountain]);
                }
                if (!check_effect($effect[Sleepy])) {
                    use(1, $item[decorative fountain]);
                }
                if(my_buffedstat(st) <= 100)
                    break;
            }

            // Special handling for Moxie stat
            if (st == $stat[Moxie]) 
            {
                if (!have($item[patchouli incense stick]) 
                    && !check_effect($effect[Far Out]) 
                    && mall_price($item[patchouli incense stick]) < 2000) {
                    retrieve_item(1, $item[patchouli incense stick]);
                }
                use(1, $item[patchouli incense stick]);

                if (check_effect($effect[Endless Drool])) {
                    cli_execute("shrug " + $effect[Endless Drool]);
                }
                if(my_buffedstat(st) <= 100)
                    break;
            }

            // General item and effect management
            if (mall_price($item[Mr. Mediocrebar]) < 2000 
                && !check_effect($effect[Apathy])) 
            {
                retrieve_item(1, $item[Mr. Mediocrebar]);
                use(1, $item[Mr. Mediocrebar]);
                if(my_buffedstat(st) <= 100)
                    break;
            }

            if (check_effect($effect[Feeling Excited])) 
            {
                cli_execute("shrug " + $effect[Feeling Excited]);
                if(my_buffedstat(st) <= 100)
                    break;
            }

            // Remove effects that affect the stat negatively
            foreach ef in my_effects() 
            {
                if (numeric_modifier(ef, st.to_string()) > 0 &&
                    numeric_modifier(ef, "meat drop") <= 0 &&
                    numeric_modifier(ef, "familiar weight") == 0 &&
                    numeric_modifier(ef, "smithsness") == 0 
                    // && numeric_modifier(ef, "item drop") == 0
                    ) 
                {
                    cli_execute("shrug " + ef);
                    if(my_buffedstat(st) <= 100)
                        break;
                }
            }
        }
    }
}

void pirates_init()
{
	if (get_property('_questPirateRealm') == 'unstarted')
        visit_url("/place.php?whichplace=realm_pirate&action=pr_port");

    if(get_property("_pirateRealmSailingTurns").to_int() == 0 
        && (get_property("_lastPirateRealmIsland") != "Trash Island") ) 
    {
        
		
        equip($slot[hat], $item[piraterealm party hat]);
        equip($slot[shirt], $item[none]);
        equip($slot[back], $item[none]);
        equip($slot[off-hand], $item[none]);
        equip($slot[weapon], $item[none]);
        equip($slot[pants], $item[none]);
        equip($slot[acc1], $item[PirateRealm eyepatch]);
        equip($slot[acc2], $item[Red Roger's red right foot]);
        equip($slot[acc3], $item[none]);
        keepStatsLow();
        visit_url("place.php?whichplace=realm_pirate&action=pr_port");
		run_choice(1);
		run_choice(1);
		run_choice(4);
		run_choice(4);
		run_choice(1);
	}
}

boolean windy_crabs_run()
{
    set_auto_attack(0);
    if(item_amount($item[windicle]) > 0
        && get_property('_pirateRealmIslandMonstersDefeated').to_int() == 0
        && get_property('_lastPirateRealmIsland') == 'Crab Island'
        )
        return adv1($location[PirateRealm Island], -1, "use windicle;");
    return false;
}

boolean crabs_run()
{
    set_auto_attack('BackupMeat');
    use_familiar($familiar[Trick-or-Treating Tot]);
    maximize('meat drop, equip piraterealm eyepatch, equip latte lovers member''s mug, -equip backup camera', false);
    while(get_property("_questPirateRealm") == "step4"
            || get_property("_questPirateRealm") == "step5"
            || get_property("_questPirateRealm") == "step9"
            || get_property("_questPirateRealm") == "step10")
    {
        keepStatsLow();
        adv1($location[PirateRealm Island], -1, "");
    }
        
    return false;
}

boolean storm_run()
{
    set_auto_attack(0);
    use_familiar($familiar[Trick-or-Treating Tot]);
    maximize('item drop, equip piraterealm eyepatch, -equip broken champagne', false);
    while(get_property('_questPirateRealm') == 'step14')
    {
        keepStatsLow();
        adv1($location[PirateRealm Island], -1, "use shadow brick;");
    }
    keepStatsLow();
    return adv1($location[PirateRealm Island], -1, "");
}

void Sailing()
{
    equip($slot[hat], $item[piraterealm party hat]);
    equip($slot[shirt], $item[none]);
    equip($slot[back], $item[none]);
    equip($slot[off-hand], $item[none]);
    equip($slot[weapon], $item[none]);
    equip($slot[pants], $item[none]);
    equip($slot[acc1], $item[PirateRealm eyepatch]);
    equip($slot[acc2], $item[Red Roger's red right foot]);
    equip($slot[acc3], $item[none]);
    while(get_property("lastEncounter") != "Land Ho!" 
        && (get_property("_questPirateRealm") == "step1"
            || get_property("_questPirateRealm") == "step2"
            || get_property("_questPirateRealm") == "step3" 
            || get_property("_questPirateRealm") == "step6"
            || get_property("_questPirateRealm") == "step7"
            || get_property("_questPirateRealm") == "step8"
            || get_property("_questPirateRealm") == "step11"
            || get_property("_questPirateRealm") == "step12"
            || get_property("_questPirateRealm") == "step13"))
    {
        keepStatsLow();
        adv1($location[Sailing the PirateRealm Seas], -1, "");
    }
            
}

void main()
{
    pirates_init();
    Sailing();
    windy_crabs_run();
}
