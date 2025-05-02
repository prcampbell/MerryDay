


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

void orb_run(monster goal)
{
    print('orb-dancing in the dire warren','purple');
    use_familiar($familiar[hobo monkey]);
    maximize('meat drop, equip latte lover, equip miniature crystal ball',false);
    set_auto_attack('BasicBarf');
    adv1($location[the dire warren], -1, '');


    string crystalBall = (get_property("crystalBallPredictions"));
    string[] predictions = crystalBall.split_string("[|]");
    foreach i in (predictions) 
    {
        string[] predictions_split = predictions[i].split_string(":");
        print(predictions_split[1] + " - " + predictions_split[2]);
        if(predictions_split[1].to_location() == $location[The Dire Warren] && predictions_split[2].to_monster() == goal)
        {
            set_auto_attack('BackupMeat');
            adv1($location[the dire warren], -1, '');
        }
    }



}

boolean spinner_can()
{
    return get_property('_timeSpinnerMinutesUsed').to_int() < 8;
}

boolean spinner_can(monster goal)
{
    return get_property('_timeSpinnerMinutesUsed').to_int() < 8;
}

boolean spinner_run(monster goal)
{
    print('Timespinning!', 'purple');
//Actually do the thing:
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

boolean get_spooky_putty_sheet()
{
    if(item_amount($item[spooky putty sheet]) > 0)
    {
        return true;
    }
    else if(closet_amount($item[spooky putty sheet]) > 0)
    {
        return take_closet(1, $item[spooky putty sheet]);
    }
    return false;
}

boolean angel_can()
{
    return get_property('_badlyRomanticArrows').to_int() == 0 &&
            !get_property('_chateauMonsterFought').to_boolean();
}

boolean angel_run()
{
    print('Romantic Arrow in the Chateau','purple');
    
    get_spooky_putty_sheet();
    
    use_familiar($familiar[obtuse angel]);
    maximize('meat drop, equip quake of arrows',false);
    set_auto_attack('BackupMeat');
    visit_url('place.php?whichplace=chateau&action=chateau_painting');
    use_familiar($familiar[jill-of-all-trades]);
    maximize('meat drop, equip backup camera, equip Roman Candelabra',false);
    print('Set the Romantic Counter','purple');
    adv1($location[noob cave], -1, '');

    return true;
}

boolean putty_can()
{
    return get_property('_raindohCopiesMade').to_int() + get_property('spookyPuttyCopiesMade').to_int() <= 6
        && get_property('spookyPuttyMonster').to_monster() == $monster[cockroach]
        && get_property('rainDohMonster').to_monster() == $monster[cockroach];
}

boolean putty_run()
{
    print('Spooky Puty and Rain-doh #' + get_property('spookyPuttyCopiesMade'),'purple');
    use(1, $item[spooky putty monster]);
    if(get_property('spookyPuttyCopiesMade').to_int() == 3)
    {
        put_closet(1, $item[spooky putty sheet]);
    }
    use(1, $item[rain-doh box full of monster]);
    return true;
}

boolean roach_can()
{
    return get_property("_questPirateRealm") == "step9"
            || get_property("_questPirateRealm") == "step10";
}

void roach_run()
{

    if(angel_can())
        angel_run();

/*adv.php to set Romantic Counter*/

    maximize('meat drop, equip backup camera, equip latte lover',false);
/*burn Romantic Delay */
    while(putty_can())
    {
        putty_run();
    }

    /*Timespinner goes here*/
    while(spinner_can($monster[cockroach]))
    {
        spinner_run($monster[cockroach]);
    }

    while(get_property('_monsterHabitatsFightsLeft').to_int() > 1 && get_property('_powerfulGloveBatteryPowerUsed').to_int() < 100)
    {
        use_familiar($familiar[jill-of-all-trades]);
        maximize('meat drop, equip powerful glove, equip latte lover',false);
        if(have_effect($effect[everything looks purple]) == 0)
        {
            equip($slot[off-hand],$item[Roman Candelabra]);
        }
        adv1($location[noob cave], -1, '');
        if(get_property('_monsterHabitatsFightsLeft').to_int() == 1)
        {
            orb_run($monster[cockroach]);
        }
    }
    
    if(get_property('_monsterHabitatsFightsLeft').to_int() == 1)
    {
        orb_run($monster[cockroach]);
    }
    
    //We save 2 for orb dancing later
    while(get_property('_monsterHabitatsFightsLeft').to_int() > 1 && get_property('_macrometeoriteUses').to_int() < 8)
    {
        maximize('meat drop, equip latte lover',false);
        if(have_effect($effect[everything looks purple]) == 0)
        {
            equip($slot[off-hand],$item[Roman Candelabra]);
        }
        adv1($location[noob cave], -1, '');
        if(get_property('_monsterHabitatsFightsLeft').to_int() == 1)
        {
            orb_run($monster[cockroach]);
        }
    }

    if(get_property('_monsterHabitatsFightsLeft').to_int() == 1)
    {
        orb_run($monster[cockroach]);
    }    

    while(get_property('_monsterHabitatsFightsLeft').to_int() > 1)
    {
        use_familiar($familiar[jill-of-all-trades]);
        maximize('meat drop, equip latte lover, equip backup camera',false);
        if(have_effect($effect[everything looks purple]) == 0)
        {
            equip($slot[off-hand],$item[Roman Candelabra]);
        }
        adv1($location[the dire warren], -1, '');
        if(get_property('_monsterHabitatsFightsLeft').to_int() == 1)
        {
            orb_run($monster[cockroach]);
        }        
    }

    if(get_property('_monsterHabitatsFightsLeft').to_int() == 1)
    {
        orb_run($monster[cockroach]);
    }     

    while(get_property('lastCopyableMonster') == 'cockroach' && get_property('_backUpUses').to_int() < 11)
    {
        use_familiar($familiar[jill-of-all-trades]);
        maximize('meat drop, equip latte lover, equip backup camera',false);
        if(have_effect($effect[everything looks purple]) == 0)
        {
            equip($slot[off-hand],$item[Roman Candelabra]);
        }
        adv1($location[noob cave], -1, '');
    }

    set_auto_attack(0);

}

void main()
{
    if(roach_can())
    {
        roach_run();
    }
    else 
    {
        abort('Trash Island is not open!');
    }
    
}





