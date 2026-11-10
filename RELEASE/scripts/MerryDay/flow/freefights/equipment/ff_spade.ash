script ff_spade;

boolean location_has_skeletons(location loc)
{
    monster[int] mons = get_monsters(loc);
    foreach i, m in mons 
    {
        if (m.name.to_lower_case().contains_text("skeleton"))
        {
            return true;
        }   
    }
    return false;
}

boolean spade_can()
{
    return get_property('_archSpadeDigs').to_int() < 11
        && location_has_skeletons(get_property('lastAdventure').to_location());
}

boolean spade_run()
{
    set_property('choiceAdventure1596', 3);
    use(1, $item[Archaeologist's Spade]);
    set_property('choiceAdventure1596', 0);
    return true;
}

