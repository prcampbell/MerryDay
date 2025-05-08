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

    if(my_inebriety() < inebriety_limit())
    {
        if(get_property('familiarSweat').to_int() > 155)
        {
           cli_execute('drink stillsuit distillate');
        }
    }
 
    if(item_amount($item[autumn-aton]) > 0 && autobotTurnsForQuest() < my_adventures())
    {

        if(item_amount(get_property('rufusDesiredItems').to_item()) < 3)
        {
            if($items[shadow ice, shadow fluid, shadow glass] contains get_property('rufusDesiredItems').to_item())
            {
                adv1($location[Shadow Rift (The 8-Bit Realm)], -1, 'use divine champagne popper;');
            }
            else if($items[shadow sausage, shadow brick, shadow sinew] contains get_property('rufusDesiredItems').to_item())
            {
                adv1($location[Shadow Rift (The Ancient Buried Pyramid)], -1, 'use divine champagne popper;');
            }
            else if($items[shadow brick, shadow sinew, shadow nectar] contains get_property('rufusDesiredItems').to_item())
            {
                adv1($location[Shadow Rift (The Hidden City)], -1, 'use divine champagne popper;');
            }
            else if($items[shadow bread, shadow brick, shadow stick] contains get_property('rufusDesiredItems').to_item())
            {
                adv1($location[Shadow Rift (The Misspelled Cemetary)], -1, 'use divine champagne popper;');
            }
            else if($items[shadow fluid, shadow glass, shadow nectar] contains get_property('rufusDesiredItems').to_item())
            {
                adv1($location[Shadow Rift (The Beanstalk)], -1, 'use divine champagne popper;');
            }
            else if($items[shadow sausage, shadow bread, shadow fluid] contains get_property('rufusDesiredItems').to_item())
            {
                adv1($location[Shadow Rift (The Castle in the Clouds in the Sky)], -1, 'use divine champagne popper;');
            }
            else if($items[shadow flame, shadow fluid, shadow sinew] contains get_property('rufusDesiredItems').to_item())
            {
                adv1($location[Shadow Rift (Desert Beach)], -1, 'use divine champagne popper;');
            }
            else if($items[shadow flame, shadow nectar, shadow stick] contains get_property('rufusDesiredItems').to_item())
            {
                adv1($location[Shadow Rift (The Distant Woods)], -1, 'use divine champagne popper;');
            }
            else if($items[shadow bread, shadow ice, shadow venom] contains get_property('rufusDesiredItems').to_item())
            {
                adv1($location[Shadow Rift (Forest Village)], -1, 'use divine champagne popper;');
            }
            else if($items[shadow skin, shadow ice, shadow stick] contains get_property('rufusDesiredItems').to_item())
            {
                adv1($location[Shadow Rift (Mt. McLargeHuge)], -1, 'use divine champagne popper;');
            }
            else if($items[shadow sausage, shadow skin, shadow venom] contains get_property('rufusDesiredItems').to_item())
            {
                adv1($location[Shadow Rift (The Nearby Plains)], -1, 'use divine champagne popper;');
            }
            else if($items[shadow skin, shadow bread, shadow glass] contains get_property('rufusDesiredItems').to_item())
            {
                adv1($location[Shadow Rift (The Right Side of the Tracks)], -1, 'use divine champagne popper;');
            }
            else if($items[shadow sausage, shadow flame, shadow venom] contains get_property('rufusDesiredItems').to_item())
            {
                adv1($location[Shadow Rift (Spookyraven Manor Third Floor)], -1, 'use divine champagne popper;');
            }
        }

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

    if(item_amount($item[bowling ball]) > 0)
    {
        put_closet(item_amount($item[bowling ball]), $item[bowling ball]);
    }

}



















