script md_space;

boolean grimace_can()
{
    return has_effect($effect[Everything Looks Yellow]) == 0 
        && get_property('_sourceTerminalDuplicateUses').to_int() == 0
        && !get_property('_photocopyUsed')
}

boolean grimace_do()
{
    equip($slot[shirt], item[jurassic parka]);
    cli_execute('parka acid; terminal educate duplicate.edu');

    //fax in a survivor and zap them
}

boolean space_can()
{
    if(have_effect($effect[Transpondent]) > 0)
    {
        print("Already have Transpondent", "green");
        return true;
    }
    if(item_amount($item[transporter transponder]) > 0)
    {
        use(1, $item[transporter transponder]);
        return true;
    }
    else 
    {
        return false;
    }
}

boolean pills_can()
{
    return item_amount($item[map to safety shelter Grimace prime]) >= 30
        && my_adventures() >= 30;
}

void pills_run()
{
    if(space_can())
    {
        print("Running Grimace Prime pills", "blue");
        while(item_amount($item[map to safety shelter Grimace prime]) > 0 && have_effect($effect[Transpondent]) > 0)
        {
            
            if (item_amount($item[distention pill]) <= item_amount($item[synthetic dog hair pill]))
                set_property("choiceAdventure536", 1);		
            else
                set_property("choiceAdventure536", 2);
            use(1, $item[Map to Safety Shelter Grimace Prime]);
        }
    }
}

import md_outfit;

boolean grimacemap_can()
{
    return !get_property('_aprilShowerNorthernExplosion').to_boolean() 
        && get_property('_sourceTerminalDuplicateUses').to_int() == 0
        && !get_property('_photocopyUsed').to_boolean();
}

void grimacemap_run()
{
    item[slot] required_equips;
    required_equips[$slot[off-hand]] = $item[april shower thoughts shield];
    construct_free_outfit(required_equips);
    cli_execute('chat');
    faxbot($monster[grizzled survivor]);
    if(get_property('sourceTerminalEducate1') != 'duplicate.edu'
        && get_property('sourceTerminalEducate2') != 'duplicate.edu')
    {
        cli_execute('terminal educate duplicate.edu');
    }
    set_auto_attack('DramaticShower');
    use(1, $item[photocopied monster]);
    cli_execute('terminal educate extract.edu');
	cli_execute('terminal educate turbo.edu');
} 