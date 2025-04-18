import md_outfit;

boolean spacegate_can()
{
    return get_property('_spacegateTurnsLeft').to_int() > 0 || get_property('_spacegateCoordinates') == '';
}

string spacegate_dial()
{
    if(get_property('_spacegateCoordinates') == '')
    {
        cli_execute('spacegate destination GRIMACE');
    }
    return get_property('_spacegateCoordinates');
}

boolean spacegate_gear(string chevrons)
{
    cli_execute('acquire geological sample kit; acquire exo-servo leg braces');
    return true;
}

boolean spacegate_init()
{
    return spacegate_gear(spacegate_dial());
}

boolean spacegate_run()
{
    set_auto_attack('StasisFight');
    while(get_property('_spacegateTurnsLeft').to_int() > 0)
    {
        item[slot] required_equips;
        required_equips[$slot[pants]] = $item[exo-servo leg braces];
        required_equips[$slot[off-hand]] = $item[geological sample kit];
        construct_free_outfit(required_equips, ChooseFamiliar());
        adv1($location[Through the Spacegate], -1, '');
        visit_url('place.php?whichplace=spacegate&action=sg_Terminal');
    }
    set_auto_attack(0); 
    return true;   
}

void main()
{
    if(spacegate_can())
    {
        spacegate_init();
        spacegate_run(); 
    }
}

