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

equip($slot[weapon], $item[staff of hatred]);
cli_execute('familiar god lobster');
cli_execute('autoattack NostalgiaKill');
while (get_property('_godLobsterFights') < 2) {
    // Get equipment from the fight.
    set_property('choiceAdventure1310', '2');
    try_equip($item[God Lobster's Scepter]); //'
    visit_url('main.php?fightgodlobster=1');
    run_combat();
    visit_url('choice.php');
    if (handling_choice()) run_choice(2);
}


//equip($slot[weapon], $item[The Jokester's Gune]);//'
//equip($slot[acc1], $item[pro skateboard]);
//Fight swarm of beatles
//Nostalgia, envy, mctwist, spit jurassic acid