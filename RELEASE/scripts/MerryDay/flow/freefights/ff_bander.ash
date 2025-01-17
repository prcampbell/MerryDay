script ff_bander;

import md_outfit;

boolean gap_can()
{
    return get_property("_navelRunaways").to_int() < 3 
        && get_property('_gingerbreadCityTurns').to_int() > 5
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

void main()
{
    if(gap_can())
        gap_run();
}