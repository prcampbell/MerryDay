script ff_grimace;

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