script md_yacht;

import md_mpburn;

void yacht_outfit()
{
    equip($slot[hat], $item[Apriling band helmet]);

    equip($slot[weapon], $item[garbage sticker]);
    equip($slot[off-hand], $item[latte lovers member's mug]);

    equip($slot[back], $item[elf guard scuba tank]);
    equip($slot[shirt], $item[jurassic parka]);
    if(get_property('parkaMode') != 'kachungasaur')
    {
        cli_execute('parka meat');
    }
    equip($slot[pants], $item[repaid diaper]);

    equip($slot[acc1], $item[yamtility belt]);
    equip($slot[acc2], $item[wormwood wedding ring]);
    equip($slot[acc3], $item[anemoney clip]);

    equip($slot[familiar], $item[amulet coin]);
    
}

boolean fishy_can()
{
    return !get_property('_fishyPipeUsed').to_boolean();
}

boolean clara_nc_can()
{
    return !get_property('_claraBellUsed').to_boolean();
}

boolean tuba_nc_can()
{
    return get_property('_aprilBandTubaUses').to_int() < 3 
            && item_amount($item[apriling band tuba]) > 0;
}

boolean cinch_nc_can()
{
    return get_property('_cinchUsed') <= 40;
}

boolean nc_can()
{
    return get_property('noncombatForcerActive').to_boolean()
            || clara_nc_can()
            || tuba_nc_can()
            || cinch_nc_can();
}

boolean fishy_get()
{
    if(!get_property('_fishyPipeUsed').to_boolean())
        return use(1, $item[fishy pipe]);
    return have_effect($effect[fishy]) > 0;
}

boolean yacht_can()
{
    return nc_can() && (have_effect($effect[fishy]) > 0 || fishy_can());
}

boolean yacht_double_can()
{
    return nc_can();
}

boolean force_nc()
{
    if(get_property('noncombatForcerActive').to_boolean())
    {
        return true;
    }
    if(cinch_nc_can())
    {
        equip($slot[acc3], $item[cincho de mayo]);
        use_skill(1, $skill[cincho: fiesta exit]);
        while(total_free_rests() > get_property('timesRested').to_int() && get_property('_cinchUsed').to_int() > 40)
        {
            LibramBurn();
            cli_execute('rest free');
        }
        return true;
    }
    if(clara_nc_can())
    {
        print('forcing NC with clara bell','purple');
        return use(1, $item[clara's bell]);
    }
    if(tuba_nc_can())
    {
        print('forcing NC with tuba','purple');
        return cli_execute('aprilband play tuba');
    }

    return false;
}

boolean yacht_double_run()
{
    if(force_nc())
    {
        use_familiar($familiar[urchin urchin]);
        yacht_outfit();
        return adv1($location[the sunken party yacht], -1, '');
    }
    return false;     
}

boolean yacht_run()
{   
    if(yacht_can())
    {
        fishy_get();
        if(have_effect($effect[fishy]) == 0)
        {
            return false;
        }

        if(force_nc())
        {
            use_familiar($familiar[urchin urchin]);
            yacht_outfit();
            return adv1($location[the sunken party yacht], -1, '');
        }        
    }

    return false;

}

void main()
{
    while(yacht_can())
        yacht_run();

    while(yacht_double_can())
        yacht_double_run();

    print('You cannot do yacht anymore','red');
}

