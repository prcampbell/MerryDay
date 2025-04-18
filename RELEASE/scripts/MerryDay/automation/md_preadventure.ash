import md_iotm2022.ash;
import md_outfit.ash;

void RemoveCurrencies() 
{
    if ( can_interact() ) 
	{
        foreach it in $items[hobo nickel,sand dollar] 
		{
            if ( it == $item[hobo nickel] && get_property("choiceAdventure272").to_int() != 2 && my_location() == $location[Hobopolis Town Square] )
                retrieve_item(20,it);
            else if ( it == $item[hobo nickel] && $locations[Burnbarrel Blvd., Exposure Esplanade, The Heap, The Ancient Hobo Burial Ground, The Purple Light District] contains my_location()
                && get_counters("Semirare window end",0,60) == "Semirare window end" && get_counters("Semirare window begin",1,60) != "Semirare window begin" )
                retrieve_item(5,it);
            else if ( available_amount(it) <= 11 )
                retrieve_item(1,it);
            else if ( item_amount(it) > 0 )
                put_closet(item_amount(it),it);
        }
    }
    foreach it in $items[mer-kin hallpass,pulled green taffy]
        if (item_amount(it) > 0 )
            put_closet(item_amount(it),it);

}


void main()
{
    if(get_property("_universeCalculated").to_int() < min(3, get_property("skillLevel144").to_int()))
    {
        int numberwang = 69;
        int[int] numberology = reverse_numberology();
        print(numberology[numberwang], 'green');
        if (numberology contains numberwang) 
        {
            cli_execute('numberology ' + numberwang.to_string());
        }        
    }
 
    if(item_amount($item[autumn-aton]) > 0 && autobotTurnsForQuest() < my_adventures())
    {
        cli_execute('fallguy send Shadow Rift');
    }
    if(have_effect($effect[beaten up]) > 0)
    {
        use_skill(1, $skill[tongue of the walrus]);
    }
    if(my_hp() < my_maxhp())
    {
        restore_hp(my_maxhp());
    }
    if(my_mp() < 200)
    {
        restore_mp(200);
    }

    if(my_location() == $location[the hidden bowling alley] 
        && item_amount($item[bowling ball]) > 0)
    {
        put_closet(item_amount($item[bowling ball]), $item[bowling ball]);
    }

    if(my_location() == $location[Barf Mountain])
    {
        use_familiar(MeatFamiliar());
        

        if(get_property('_batWingsFreeFights').to_int() < 5)
            equip($slot[back], $item[bat wings]);
        else
        {
            equip($slot[back], $item[buddy bjorn]);
            bjornify_familiar(get_best_bjorn());
        }
            
        if(!have_equipped($item[buddy bjorn]))
        {
            equip($slot[hat], $item[crown of thrones]);
            enthrone_familiar(get_best_bjorn());
        }   
        else
            equip($slot[hat], $item[Apriling Band Helmet]);

        equip($slot[shirt], $item[jurassic parka]);
        if(get_property('parkaMode') != 'kachungasaur')
        {
            cli_execute('parka meat');
        }    

        if(get_property('_pantsgivingCount').to_int() < 76)
            equip($slot[pants], $item[Pantsgiving]);
        //else if(get_property('_stinkyCheeseCount').to_int() < 100)
            //equip($slot[pants], $item[stinky cheese diaper]);
        //else if(get_property('sweat').to_int() < 75)
            //equip($slot[pants], $item[designer sweatpants]);
        else
            if(my_familiar() == $familiar[jill-of-all-trades]
                || my_familiar() == $familiar[hobo monkey]
                || (my_familiar() == $familiar[comma chameleon] && get_property('commaFamiliar') == 'Robortender')
                )
                equip($slot[pants], $item[repaid diaper]);
            else
                equip($slot[pants], $item[Pantsgiving]);

        equip($slot[acc1], $item[mafia pointer finger ring]);
        if(get_property('_mayflySummons').to_int() < 30)
            equip($slot[acc2], $item[mayfly bait necklace]);
        else
            equip($slot[acc2], $item[mr. screege's spectacles]);
        equip($slot[acc3], $item[lucky gold ring]); 
    }
    /*
    use_familiar(ChooseFamiliar());
    equip($slot[weapon], $item[june cleaver]);
    equip($slot[off-hand], $item[deft pirate hook]);
    equip($slot[hat], $item[hardened slime hat]);
    if(get_property('_batWingsFreeFights').to_int() < 5)
        equip($slot[back], $item[bat wings]);
    else
        equip($slot[back], $item[buddy bjorn]);

    if(have_effect($effect[everything looks yellow]) == 0)
        {
            equip($slot[shirt], $item[jurassic parka]);
            cli_execute('parka acid');
        }
    else
        equip($slot[shirt], $item[hodgman's disgusting technicolor overcoat]);
    
    if(get_property('_pantsgivingCount').to_int() < 50)
        equip($slot[pants], $item[Pantsgiving]);
    else if(get_property('_stinkyCheeseCount').to_int() < 100)
        equip($slot[pants], $item[stinky cheese diaper]);
    else if(get_property('sweat').to_int() < 75)
        equip($slot[pants], $item[designer sweatpants]);
    else
        equip($slot[pants], $item[hardened slime pants]);    

    if(have_effect($effect[everything looks red]) == 0)
        equip($slot[acc1], $item[everfull dart holster]);
    else 
        equip($slot[acc1], $item[mafia thumb ring]);
    equip($slot[acc2], $item[retrospecs]);
    equip($slot[acc3], $item[lucky gold ring]);   

    cli_execute('autoattack BasicAscend');
    */
}



















