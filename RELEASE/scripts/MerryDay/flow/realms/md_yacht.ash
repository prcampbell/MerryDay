script md_yacht;

boolean fishy_get()
{
    if(!get_property('_fishyPipeUsed').to_boolean())
        return use(1, $item[fishy pipe]);
    return have_effect($effect[fishy]) > 0;
}

boolean yacht_can()
{
    return !get_property('_fishyPipeUsed').to_boolean()
}

boolean force_nc()
{
    if(!get_property('_claraBellUsed').to_boolean())
    {
        return use(1, $item[clara's bell]);
    }
    if(get_property('_aprilBandTubaUses').to_int() < 3)
    {
        return cli_execute('aprilband play tuba');
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
    use_familiar($familiar[urchin urchin]);
    maximize('meat drop, equip elf guard scuba tank', false);
    
    
    if(force_nc())
    {
        return adv1($location[the sunken party yacht], -1, '');
    }

    return false;

}

void main()
{
    yacht_run();
}

