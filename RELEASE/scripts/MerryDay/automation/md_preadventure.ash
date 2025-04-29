import md_iotm2022.ash;
import md_outfit.ash;
import md_diet.ash;

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
    
    if(my_fullness() == fullness_limit() - 1)
    {
        if(have_effect($effect[Kicked in the Sinuses]) < my_adventures())
        {
            eatWithHelper($item[jumping horseradish]);
        }
        else if(item_amount($item[glass of raw eggs]) > 0)
        {
            eatWithHelper($item[glass of raw eggs]);
        }
        else if(item_amount($item[meteoreo]) > 0)
        {
            eatWithHelper($item[meteoreo]);
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



















