script ff_bander;

import md_outfit;
import md_library

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
        && get_property('_banderRunaways').to_int() < floor((familiar_weight($familiar[frumious bandersnatch]) + weight_adjustment()) / 5);
}

boolean gingerbread_bander_run()
{
    cli_execute('outfit gingerbread best');
    use_familiar($familiar[frumious bandersnatch]);
    return adv1($location[Gingerbread Upscale Retail District], -1, "runaway;");
}

boolean doctor_bander_can()
{
    return get_property('questDoctorBag') != 'unstarted'
        && get_property('_banderRunaways').to_int() < floor((familiar_weight($familiar[frumious bandersnatch]) + weight_adjustment()) / 5);
}

boolean doctor_bander_run()
{
    if(item_amount(get_property('doctorBagQuestItem').to_item()) == 0)
        cli_execute('acquire 1 ' + get_property('doctorBagQuestItem'));
    maximize('familiar weight, equip doctor bag', false);
    return adv1(get_property('doctorBagQuestLocation').to_location(), -1, "runaway;");
}

boolean fungi_bander_can()
{
    return get_property('_banderRunaways').to_int() < floor((familiar_weight($familiar[frumious bandersnatch]) + weight_adjustment()) / 5);
}

boolean fungi_bander_run()
{
    use_familiar($familiar[frumious bandersnatch]);
    ensure_song($effect[Ode to Booze]);

    return adv1($location[the fun-guy mansion], -1, "skill 7527; runaway;");
}

void main()
{
    while(gap_can())
        gap_run();
    while(gingerbread_bander_can())
        gingerbread_bander_run();
    while(doctor_bander_can())
        doctor_bander_run();
    maximize('familiar weight, equip tearaway pants', false);
    if(fungi_bander_can())
        fungi_bander_run();
}