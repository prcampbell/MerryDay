script ff_drunks;

import md_outfit;

boolean pygmy_can()
{
    return can_adventure($location[The Hidden Bowling Alley]) && get_property('_drunkPygmyBanishes').to_int() < 11 || (get_property('_saberForceMonsterCount').to_int() > 0 && get_property('_saberForceMonster') == 'drunk pygmy') || get_property('crystalBallMonster') == 'drunk pygmy';
}

boolean pygmy_run()
{
    cli_execute('closet take * bowl of scorpions');
    if(item_amount($item[bowling ball]) > 0)
        cli_execute('closet put * bowling ball');
    cli_execute('acquire 1 bowl of scorpions');
    if(get_property('_drunkPygmyBanishes').to_int() == 10 || (get_property('_drunkPygmyBanishes').to_int() == 11 && get_property('crystalBallMonster') == 'drunk pygmy' ))
    {
        print("Wearing Crystal Ball for an additional pygmy", "purple");
        equip($item[miniature crystal ball]);
    }
    equip($item[Kramco Sausage-o-Matic&trade;]);
    print("Wearing the Kramco grinder in a goblin friendly zone.", "purple");

    return adv1($location[the hidden bowling alley], -1, '');
}

void main()
{
    print("Mini-Hipster fight farming", "purple");
    use_familiar($familiar[mini-hipster]);
    set_auto_attack('StasisFight');
    construct_free_outfit();
    while(pygmy_can())
        pygmy_run();
    set_auto_attack(0);
}