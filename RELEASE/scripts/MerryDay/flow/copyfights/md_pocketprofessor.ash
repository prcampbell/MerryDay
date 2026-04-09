boolean thesis_can()
{
    return !get_property('_thesisDelivered').to_boolean() && $familiar[Pocket Professor].experience >= 400;
}

boolean thesis_run()
{
    set_auto_attack('Thesis');
    use_familiar($familiar[pocket professor]);
    maximize('mus, equip kramco', false);
    adv1($location[noob cave], -1, 'skill 7316;');
    set_auto_attack(0);
    return true;
}

boolean profsausage_can()
{
    return get_property('_pocketProfessorLectures').to_int() == 0 && !get_property('_locketMonstersFought').contains_text('sausage goblin');
}

boolean profsausage_run()
{
    set_auto_attack('BasicProfChain');
    use_familiar($familiar[pocket professor]);
    maximize('familiar weight, equip pocket professor memory chip', false);
    cli_execute('reminisce sausage goblin');
    set_auto_attack(0);
    return true;
}

boolean prof_can(monster it)
{
    return get_property('_pocketProfessorLectures').to_int() == 0 && !get_property('_locketMonstersFought').contains_text(it.to_string());
}

boolean prof_run(monster it)
{
    set_auto_attack('BasicProfChain');
    use_familiar($familiar[pocket professor]);
    maximize('familiar weight, equip pocket professor memory chip', false);
    cli_execute('reminisce ' + it.to_string());
    set_auto_attack(0);
    return true;
}