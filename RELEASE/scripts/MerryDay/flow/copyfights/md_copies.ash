


/*
1. Obtuse Angel, Initial Digitize + copiers
2. Backup into Noob Cave, where we can also olfact crates + habitat
3. Habitats

$monster target = $monster[witchess knight];

*/

int copyCount()
{
    int count = 0;
    //11 backups
    //18 habitats with orb
    //10 cheats
    //10 macros
    //6 putty
    //11 mimics
    //3 romantic
    //1 chateau painting
    //1 fax
    //1 4-d camera
    //
    return 65;
}

void orb_run()
{
    use_familiar($familiar[hobo monkey]);
    maximize('meat drop, equip latte lover, equip miniature crystal ball',false);
    set_auto_attack('BasicBarf');
    adv1($location[the dire warren], -1, '');
    set_auto_attack('BackupMeat');
    adv1($location[the dire warren], -1, '');
}

boolean spinner_run()
{

//Actually do the thing:
    monster goal = $monster[cockroach];
    string[int] pages;
    pages[0] = "inv_use.php?pwd=&which=3&whichitem=9104";
	pages[1] = "choice.php?pwd=&whichchoice=1195&option=1";
	pages[2] = "choice.php?pwd=&whichchoice=1196&option=1&monid=" + goal.id;

    visit_url(pages[0]);
    visit_url(pages[1]);
    visit_url(pages[2]);

    return true;


//this stuff is to get us out of the spinner
/*    if(get_property("lastEncounter") == "Travel to a Recent Fight")
	{
		visit_url("choice.php?pwd&whichchoice=1196&option=2");
	}
	else
	{
		abort("Time-Spinner combat failed and we were unable to leave the Time-Spinner");
	}*/

    
}

boolean angel_run()
{
    cli_execute('closet take 1 spooky putty sheet');
    use_familiar($familiar[obtuse angel]);
    maximize('meat drop, equip quake of arrows',false);
    set_auto_attack('BackupMeat');
    visit_url('place.php?whichplace=chateau&action=chateau_painting');

/*adv.php to set Romantic Counter*/

    use_familiar($familiar[jill-of-all-trades]);
    maximize('meat drop, equip backup camera, equip Roman Candelabra',false);
    adv1($location[noob cave], -1, '');
    maximize('meat drop, equip backup camera, equip latte lover',false);
/*burn Romantic Delay */
    use(1, $item[spooky putty monster]);
    use(1, $item[rain-doh box full of monster]);
    
    use(1, $item[spooky putty monster]);
    use(1, $item[rain-doh box full of monster]);
    
    use(1, $item[spooky putty monster]);
    cli_execute('closet put 1 spooky putty sheet');
    use(1, $item[rain-doh box full of monster]);

    /*Timespinner goes here*/
    spinner_run();
    spinner_run();
/*Noob Cave until orb dance*/


    while(get_property('_monsterHabitatsFightsLeft').to_int() > 1 && get_property('_powerfulGloveBatteryPowerUsed').to_int() < 100)
    {
        use_familiar($familiar[jill-of-all-trades]);
        maximize('meat drop, equip powerful glove, equip latte lover',false);
        adv1($location[noob cave], -1, '');
        if(get_property('_monsterHabitatsFightsLeft').to_int() > 1)
        {
            orb_run();
        }
    }

    if(get_property('_monsterHabitatsFightsLeft').to_int() > 1)
    {
        orb_run();
    }
    
    while(get_property('_monsterHabitatsFightsLeft').to_int() > 1 && get_property('_macrometeoriteUses').to_int() < 10)
    {
        maximize('meat drop, equip latte lover',false);
        adv1($location[noob cave], -1, '');
        if(get_property('_monsterHabitatsFightsLeft').to_int() > 1)
        {
            orb_run();
        }
    }

    if(get_property('_monsterHabitatsFightsLeft').to_int() > 1)
    {
        orb_run();
    }    
    
    while(get_property('_monsterHabitatsFightsLeft').to_int() > 1 && get_property('_backUpUses').to_int() < 11)
    {
        use_familiar($familiar[jill-of-all-trades]);
        maximize('meat drop, equip latte lover, equip backup camera',false);
        adv1($location[noob cave], -1, '');
        if(get_property('_monsterHabitatsFightsLeft').to_int() > 1)
        {
            orb_run();
        }    
    }

    use_familiar($familiar[jill-of-all-trades]);
    maximize('meat drop, equip latte lover, equip backup camera',false);

    while(get_property('_monsterHabitatsFightsLeft').to_int() > 1)
        adv1($location[the dire warren], -1, '');

    if(get_property('_monsterHabitatsFightsLeft').to_int() > 1)
    {
        orb_run();
    }

    return true;
}



void main()
{
    while(get_property('_monsterHabitatsFightsLeft').to_int() > 1 && get_property('_powerfulGloveBatteryPowerUsed').to_int() < 100)
    {
        use_familiar($familiar[jill-of-all-trades]);
        maximize('meat drop, equip powerful glove, equip latte lover',false);
        adv1($location[noob cave], -1, '');
        if(get_property('_monsterHabitatsFightsLeft').to_int() == 1)
        {
            orb_run();
        }
    }
    
    if(get_property('_monsterHabitatsFightsLeft').to_int() == 1)
    {
        orb_run();
    }
    
    while(get_property('_monsterHabitatsFightsLeft').to_int() > 1 && get_property('_macrometeoriteUses').to_int() < 10)
    {
        maximize('meat drop, equip latte lover',false);
        adv1($location[noob cave], -1, '');
        if(get_property('_monsterHabitatsFightsLeft').to_int() == 1)
        {
            orb_run();
        }
    }

    if(get_property('_monsterHabitatsFightsLeft').to_int() == 1)
    {
        orb_run();
    }    
    
    while(get_property('_monsterHabitatsFightsLeft').to_int() > 1 && get_property('_backUpUses').to_int() < 11)
    {
        use_familiar($familiar[jill-of-all-trades]);
        maximize('meat drop, equip latte lover, equip backup camera',false);
        adv1($location[noob cave], -1, '');
        if(get_property('_monsterHabitatsFightsLeft').to_int() == 1)
        {
            orb_run();
        }    
    }

    use_familiar($familiar[jill-of-all-trades]);
    maximize('meat drop, equip latte lover, equip backup camera',false);

    while(get_property('_monsterHabitatsFightsLeft').to_int() > 1)
        adv1($location[the dire warren], -1, '');

    if(get_property('_monsterHabitatsFightsLeft').to_int() == 1)
    {
        orb_run();
    }
}

/*
if hasskill 7108 #fire a badly romantic arrow
    skill 7108
endif


if monstername crate
if hasskill transcendent olfaction
skill transcendent olfaction
endif
 if hasskill 7326 # Switch Enemy
  skill 7326
 endif
endif

if monstername crate

 if hasskill macrometeor
  skill macrometeor
 endif
endif



if monstername crate
 if hasskill 7381 # Back-up To your Last Enemy
  skill 7381
 endif
endif

if !monstername tumbleweed
if monstername cockroach

    if hasskill 7526 #Purple Candle
    skill 7526
    endif
if hascombatitem spooky putty sheet && hascombatitem rain-doh black box
        use spooky putty sheet, rain-doh black box
    endif

    if hascombatitem 4-d camera || hascombatitem unfinished ice sculpture
        if hascombatitem print screen button
            use print screen button
        endif
        if hascombatitem 4-d camera && !hascombatitem unfinished ice sculpture
            use 4-d camera
        endif
        if !hascombatitem 4-d camera && hascombatitem unfinished ice sculpture
            use unfinished ice sculpture
        endif
        if hascombatitem 4-d camera && hascombatitem unfinished ice sculpture
            use 4-d camera, unfinished ice sculpture
        endif
        if hascombatitem alpine watercolor set
            use alpine watercolor set
        endif
    endif
if hasskill 7526 #Purple Candle
skill 7526
endif
if match CTRL+V && hasskill digitize
skill digitize
endif
    if hasskill 7485 #habitat
        skill 7485
    endif
endif
if hasskill Micrometeorite
    skill Micrometeorite
endif
if hasskill sing along
    skill sing along
endif
if hasskill summon hobo underling
    skill summon hobo underling
endif
if hasskill Ask the hobo to tell you a joke
    skill Ask the hobo to tell you a joke
endif

if hasskill become a wolf
    skill become a wolf
endif
if hasskill Bowl Straight Up
    skill Bowl Straight Up
endif

if hascombatitem time-spinner
    use time-spinner
endif
if hascombatitem rain-doh indigo cup
    use rain-doh indigo cup
endif
if hasskill pocket crumbs
    skill pocket crumbs
endif
if hasskill furious wallop
    skill furious wallop
endif
while !hppercentbelow 25 && !pastround 27
    attack
endwhile
endif*/



