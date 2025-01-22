script ff_leaves;

boolean leaves_can()
{
    return get_property('_leafMonstersFought').to_int() < 5;
}

boolean leaves_run()
{
    return cli_execute('leaves leaflet');
}

boolean monstera_run()
{
    return cli_execute('leaves monstera');
}

boolean leviathan_run()
{
    return cli_execute('leaves leviathan');
}

void main()
{
    set_auto_attack('StasisFight');
    equip($slot[hat], $item[daylight shavings helmet]);
    equip($slot[back], $item[buddy bjorn]);
    equip($slot[shirt], $item[jurassic parka]);
    equip($slot[weapon], $item[june cleaver]);
    equip($slot[off-hand], $item[Kramco Sausage-o-Matic&trade;]);
    equip($slot[pants], $item[tearaway pants]);
    equip($slot[acc1], $item[mr. screege's spectacles]);
    equip($slot[acc2], $item[lucky gold ring]);
    equip($slot[acc3], $item[mr. cheeng's spectacles]);
    while(leaves_can())
    {
        leaves_run();
    }
    set_auto_attack(0);
}