script ff_witchess;

import md_outfit;

int wKnight = 1936;


boolean witchess_can()
{
    return get_campground() contains $item[Witchess Set] && get_property("_witchessFights").to_int() < 5
}

boolean witchess_run(int piece)
{
    visit_url("campground.php?action=witchess");
    run_choice(1);
    visit_url("choice.php?option=1&pwd="+my_hash()+"&whichchoice=1182&piece="+piece.to_string(), false);
    run_combat();
}

boolean witchess_run()
{
    //default to fighting a knight
    witchess_run(1936);
}

void main()
{
    item[slot] required_equips;
    required_equips[$slot[off-hand]] = $item[roman candelabra];
    construct_free_outfit($familiar[chest mimic]);
    set_auto_attack('MimicEggs');
    witchess_run();
    set_auto_attack(0);
}