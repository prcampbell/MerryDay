import c2t_cartographyHunt.ash

boolean smokepatches_can()
{
    if(get_property('_fireExtinguisherCharge').to_int() >=10
        && have_effect($effect[Everything Looks Yellow]) == 0
        && get_property('_locketMonstersFought') == ''
    )
    {
        return true;
    }

    return false;
}

void smokepatches()
{
    //Get Dressed
    cli_execute('familiar xo skeleton');
    equip($slot[hat], $item[Crown of Thrones]);
    equip($slot[weapon], $item[industrial fire extinguisher]);
    equip($slot[off-hand], $item[rake]);
    equip($slot[back], $item[Vampyric Cloake]);
    equip($slot[shirt], $item[jurassic parka]);

    equip($slot[acc1], $item[lucky gold ring]);
    equip($slot[acc2], $item[Mr. Cheeng's Spectacles]);
    equip($slot[acc3], $item[Mr. Screege's Spectacles]);

    cli_execute('parka dilophosaur;enthrone garbage fire;terminal educate duplicate');
    cli_execute('autoattack StealEverything');
    cli_execute('reminisce Smoke Monster');

    equip($slot[weapon], $item[Staff of Simmering Hatred]);
    cli_execute('familiar god lobster');
    cli_execute('autoattack NostalgiaKill');
    while (get_property('_godLobsterFights') < 2) 
    {
        // Get equipment from the fight.
        set_property('choiceAdventure1310', '2');
        visit_url('main.php?fightgodlobster=1');
        run_combat();
        visit_url('choice.php');
        if (handling_choice()) run_choice(2);
    }
    set_auto_attack(0);
    equip($slot[acc3], $item[pro skateboard]);
    equip($slot[weapon], $item[The Jokester's Gun]);//'

    set_auto_attack('NostalgiaKill');
    cli_execute('reminisce swarm of scarab beatles');
    set_auto_attack(0);   
}

boolean saber_can()
{
    return get_property('_saberForceUses').to_int() < 5 && !get_property('mappingMonsters').to_boolean() && get_property('_monstersMapped').to_int() < 3;
}

void saber_run()
{
    set_property('battleAction', 'custom combat script');
    equip($slot[weapon], $item[Fourth of May Cosplay Saber]);
    set_auto_attack('UseTheForce');
    if(get_property('choiceAdventure1387').to_int() != 3)
        set_property('choiceAdventure1387', '3');

    while(get_property('_saberForceUses').to_int() < 5)
    {
        while(get_property('_monstersMapped').to_int() < 3 && !get_property('mappingMonsters').to_boolean())
        {
            buffer buf;
            //hunt 3 sundae
            use_skill(1,$skill[Map the Monsters]);

            buf = visit_url($location[Sloppy Seconds Diner].to_url(),false,true);
            if(buf.contains_text("Nothing Could Be Finer"))
                continue;
            if (!buf.contains_text('name="whichchoice" value="1435"') || !buf.contains_text("Leading Yourself Right to Them"))
                abort("Wrong thing came up when using Map the Monsters at Sloppy Seconds Diner with Sloppy Seconds Sunday");

            //select choice
            buf = visit_url("choice.php?pwd&whichchoice=1435&option=1&heyscriptswhatsupwinkwink="+$monster[Sloppy Seconds Sundae].to_int(),true,true);
            run_choice(3);

            set_property('mappingMonsters', 'false');
        }
        
        adv1($location[Sloppy Seconds Diner]  , -1, '');
    }
    set_auto_attack(0);
    set_property('mappingMonsters', 'false');
    //set mappingMonsters = false
}

void main()
{
    if(smokepatches_can())
        smokepatches();

    if(saber_can())
    {
        saber_run();
    }
}