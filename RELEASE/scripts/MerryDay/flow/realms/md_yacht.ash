script md_yacht;

import mpBurn;

boolean fishy_get()
{
    if(!get_property('_fishyPipeUsed').to_boolean())
        return use(1, $item[fishy pipe]);
    return have_effect($effect[fishy]) > 0;
}

boolean yacht_can()
{
    return !get_property('_fishyPipeUsed').to_boolean();
}

boolean force_nc()
{
    if(!get_property('_claraBellUsed').to_boolean())
    {
        print('forcing NC with clara bell','purple');
        return use(1, $item[clara's bell]);
    }
    if(get_property('_aprilBandTubaUses').to_int() < 3 && item_amount($item[apriling band tuba]) > 0)
    {
        print('forcing NC with tuba','purple');
        return cli_execute('aprilband play tuba');
    }
    if(get_property('_cinchUsed') < 40)
    {
        equip($slot[acc3], $item[cincho de mayo]);
        use_skill(1, $skill[cincho: fiesta exit]);
        while(total_free_rests() > get_property('timesRested').to_int() && get_property('_cinchUsed').to_int() > 40)
        {
            LibramBurn();
            cli_execute('rest free');
        }
    }
    return false;
}

boolean yacht_run()
{   
    fishy_get();
    if(have_effect($effect[fishy]) == 0)
    {
        return false;
    }

    if(force_nc())
    {
        use_familiar($familiar[urchin urchin]);
        maximize('meat drop, equip elf guard scuba tank', false);
        return adv1($location[the sunken party yacht], -1, '');
    }

    return false;

}

void main()
{
    yacht_run();
}

