script ff_bander;

import md_outfit;

boolean gap_can()
{
    return get_property("_navelRunaways").to_int() < 3 
        && get_property('_gingerbreadCityTurns').to_int() >= 5
        && get_property('_gingerbreadCityTurns').to_int() < 14;
}

boolean gap_run()
{
    use_familiar($familiar[chocolate lab]);
    construct_free_outfit();
    equip($slot[pants], $item[greatest american pants]);
    equip($slot[familiar], $item[tiny rake]);
    equip($slot[off-hand], $item[rake]);
    return adv1($location[Gingerbread Train Station], -1, "runaway;");
}

boolean gingerbread_bander_can()
{
    return get_property('_gingerbreadCityTurns').to_int() < 15 
        && get_property('_banderRunaways').to_int() < floor((familiar_weight($familiar[bandersnatch]) + weight_adjustment()) / 5);
}

boolean gingerbread_bander_run()
{
    cli_execute('outfit gingerbread best');
    use_familiar($familiar[frumious bandersnatch]);
    return adv1($location[Gingerbread Train Station], -1, "runaway;");
}

void main()
{
    while(gap_can())
        gap_run();
    if(gingerbread_bander_can())
        gingerbread_bander_run();
}