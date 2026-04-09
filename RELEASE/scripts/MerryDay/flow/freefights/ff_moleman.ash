script ff_moleman;

boolean moleman_can()
{
    return !get_property('_molehillMountainUsed').to_boolean();
}

boolean moleman_run()
{
    return use(1, $item[molehill mountain]);
}
