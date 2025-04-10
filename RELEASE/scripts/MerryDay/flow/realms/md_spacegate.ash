import md_outfit;


void main()
{
    if(get_property('_spacegatePlanetIndex') == '0')
    {
        cli_execute('spacegate destination GRIMACE; acquire exo-servo leg braces');
    }
    
    item[slot] required_equips;
    required_equips[$slot[pants]] = $item[exo-servo leg braces];
    construct_free_outfit(required_equips, ChooseFamiliar());
    set_auto_attack('StasisFight');
    adv1($location[Through the Spacegate], -1, '');
}

