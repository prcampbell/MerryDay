


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
    return true;
}



void main()
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

    while(get_property('_monsterHabitatsFightsLeft').to_int() > 1)
    {
        use_familiar($familiar[jill-of-all-trades]);
        maximize('meat drop, equip latte lover, equip backup camera',false);
        adv1($location[the dire warren], -1, '');
        if(get_property('_monsterHabitatsFightsLeft').to_int() == 1)
        {
            orb_run();
        }        
    }
        


}





