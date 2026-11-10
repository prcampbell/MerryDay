script ff_archeologicalspade;

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
    return location_has_skeletons(my_location()) && get_property('_archSpadeDigs').to_int() < 11;
}

boolean spade_run()
{
    return use(1, $item[archaeologist's spade]);
}