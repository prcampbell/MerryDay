boolean mushroom_can()
{
    return !get_property('_mushroomGardenVisited').to_boolean();
}

void mushroom_run()
{
    string temp = my_garden_type();
    if(temp != "mushroom")
    {
        print("Your garden is not a mushroom garden, it is a " + temp + " garden.", "red");
        use(1, $item[packet of mushroom spores]);
    }
    set_auto_attack('StasisFight');
    adv1($location[Your Mushroom Garden], -1, '');
    if(temp != my_garden_type())
    {
        switch(temp)
        {
            case "thanksgarden":
                use(1, $item[packet of thanksgarden seeds]);
                break;
            case "grass":
                use(1, $item[packet of tall grass seeds]);
                break;
            case "pumpkin":
                use(1, $item[packet of pumpkin seeds]);
                break;
            case "peppermint":
                use(1, $item[packet of peppermint pips]);
                break;
            case "rock":
                use(1, $item[packet of rock seeds]);
                break;
            default:
                print("How on earth did you get here?", "red");
                abort();
        }
        
    }
}

/*

[1765] Your Mushroom Garden
Preference lastEncounter changed from Is There A Doctor In The House? to The Mushy Center
Encounter: The Mushy Center
Unsupported choice adventure #1410
choice 1: Fertilize the mushroom
choice 2: Pick the mushroom
Click here to continue in the relay browser.


construct_free_outfit($phylum[plant]);

*/