script ff_spade;

boolean spade_can()
{
    return get_property('_archSpadeDigs').to_int() < 11;
}

boolean spade_run()
{
    set_property('choiceAdventure1596', 3);
    use(1, $item[Archaeologist's Spade]);
    set_property('choiceAdventure1596', 0);
    return true;
}

while(spade_can())
{
    merry_auto_attack();
    construct_free_outfit($familiar[skeleton of crimbo past]);
    spade_run();
}