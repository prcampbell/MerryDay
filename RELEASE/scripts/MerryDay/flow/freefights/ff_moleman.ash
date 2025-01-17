script ff_moleman;

boolean moleman_can()
{
    return !get_property('_molehillMountainUsed').to_boolean();
}

boolean moleman_run()
{
    use(1, $item[molehill mountain]);
}

void main()
{
    if(moleman_can())
    {
        use_familiar($familiar[grey goose]);
        maximize('familiar exp', false);
        set_auto_attack('DroneStasis');
        moleman_run();
        set_auto_attack(0);    
    }
    
}