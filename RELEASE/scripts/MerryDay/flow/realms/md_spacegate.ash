import md_outfit;

boolean spacegate_can()
{
    return get_property('_spacegateTurnsLeft').to_int() > 0 || get_property('_spacegateCoordinates') == '';
}

string spacegate_dial()
{
    /**/
    if(get_property('_spacegateCoordinates') == '')
    {
        if(item_amount($item[primitive alien totem]) == 0)
            cli_execute('spacegate destination GRIMACE');
        if(item_amount($item[primitive alien spear]) == 0)
            cli_execute('spacegate destination COMRADE');
        if(item_amount($item[primitive alien blowgun]) == 0)
            cli_execute('spacegate destination DECEIVE');
        if(item_amount($item[primitive alien loincloth]) == 0)
            cli_execute('spacegate destination MANATEE');
        if(item_amount($item[primitive alien necklace]) == 0)
            cli_execute('spacegate destination CTHULHU');
    }
    return get_property('_spacegateCoordinates');
}

boolean spacegate_gear(string chevrons)
{
    switch(chevrons)
    {
        case 'GRIMACE':
        cli_execute('acquire geological sample kit; acquire exo-servo leg braces');
        break;
        case 'COMRADE':
        cli_execute('acquire geological sample kit; acquire exo-servo leg braces');
        break;
        case 'DECEIVE':
        cli_execute('');
        break;
        case 'MANATEE':
        cli_execute('');
        break;
        case 'CTHULHU':
        cli_execute('');
        break;
    }
    
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

