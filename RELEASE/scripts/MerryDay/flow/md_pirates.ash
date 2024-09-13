
/*
//Swift Clipper
choiceAdventure1349 => 4
//GetOut
choiceAdventure1350 => 1

//Crab Island (I Hope this is consistent?)
choiceAdventure1352 => 1

Go to Port Beginning
Equip piraterealm party Hat
equip piraterealm eyepatch
equip red roger's red right foot

Head to Groggy's

Hire Second mate 
Acquire curious anemometer
Acquire Swift Clipper 

Head to Sea 
*/


use_familiar($familiar[Blavious Kloop]);
equip($slot[off-hand], $item[latte lovers member's mug]);

if(get_property('choiceAdventure1204') != 1)
{
    //string tmp = get_property('choiceAdventure1204')
}

set_property('choiceAdventure1204', '1');

if(!(to_boolean(get_property("_gingerbreadClockAdvanced"))))
{
    visit_url('adventure.php?snarfblat=477');
    run_choice(1);
}
adv1($location[Gingerbread Train Station], -1, 'skill gulp latte; skill throw latte;');

/*
while(to_int(get_property("_gingerbreadCityTurns")) < 5)
{
    adv1($location[Gingerbread Train Station], -1, "");
}

  

  cli_execute('Librams; latte refill cajun rawhide carrot');
  adv1($location[Train Station], -1, 'gulp latte; throw latte;');
  cli_execute('Librams; latte refill cajun rawhide carrot');
  adv1($location[Train Station], -1, 'gulp latte; throw latte;');
  cli_execute('Librams; latte refill cajun rawhide carrot');
  adv1($location[Train Station], -1, '');
*/

