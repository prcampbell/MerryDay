script ff_spade;

boolean spade_can()
{
    return get_property('_archSpadeDigs').to_int() < 11
        && $locations[The VERY Unquiet Garves, The Haunted Kitchen] contains get_property('lastAdventure').to_location();
}

boolean spade_run()
{
    set_property('choiceAdventure1596', 3);
    use(1, $item[Archaeologist's Spade]);
    set_property('choiceAdventure1596', 0);
    return true;
}

