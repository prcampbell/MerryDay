script ff_lobster

boolean lobster_can()
{
    return get_property('_godLobsterFights').to_int() < 3;
}

boolean lobster_run()
{
    use_familiar($familiar[god lobster]);
    visit_url('main.php?fightgodlobster=1');
    run_combat();
    visit_url('choice.php');
    if (handling_choice()) run_choice(2);
}

void main()
{
    if(lobster_can())
        lobster_run();
}