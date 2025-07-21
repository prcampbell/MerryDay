script ff_witchess;

import md_outfit;

int wKnight = 1936;
int wBishop = 1942;


boolean witchess_can()
{
    return get_campground() contains $item[Witchess Set] && get_property("_witchessFights").to_int() < 5;
}

boolean witchess_run(monster piece)
{
    visit_url("campground.php?action=witchess");
    run_choice(1);
    visit_url("choice.php?option=1&pwd="+my_hash()+"&whichchoice=1182&piece="+piece.to_int().to_string(), false);
    run_combat();
    set_property('_MerryWitchessFights', get_property('_MerryWitchessFights').to_int() + 1);
    return true;
}

boolean witchess_run(int piece)
{
    visit_url("campground.php?action=witchess");
    run_choice(1);
    visit_url("choice.php?option=1&pwd="+my_hash()+"&whichchoice=1182&piece="+piece.to_string(), false);
    run_combat();
    set_property('_MerryWitchessFights', get_property('_MerryWitchessFights').to_int() + 1);
    return true;
}

boolean witchess_run()
{
    if(item_amount($item[jumping horseradish]) > item_amount($item[sacramento wine]))
        return witchess_run(wBishop);
    else
        return witchess_run(wKnight);
}

void main()
{
    item[slot] required_equips;
    required_equips[$slot[off-hand]] = $item[roman candelabra];
    if(get_property('sourceTerminalEducate1') != 'digitize.edu'
        && get_property('sourceTerminalEducate2') != 'digitize.edu')
    {
        cli_execute('terminal educate digitize.edu');
    }
    construct_free_outfit(required_equips, $familiar[chest mimic]);
    set_auto_attack('MimicEggs');
    witchess_run();
    set_auto_attack(0);
}