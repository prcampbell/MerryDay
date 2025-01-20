
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



ash 
set_property('choiceAdventure1497',3);

while(have_effect($effect[shadow waters]) < 600)
{
    use(1, $item[closed-circuit pay phone]);

    if(item_amount(get_property('rufusQuestTarget').to_item()) >= 3)
    {
        use(1, $item[closed-circuit pay phone]);
        adv1($location[Shadow Rift (The Distant Woods)], -1, "");
    }
    else
    {
        break;
    }
}*/

void pirates_init()
{
    //get eyepatch
    //equip eyepatch, ensure low stats
    /*
    visitUrl("place.php?whichplace=realm_pirate&action=pr_port");
      runChoice(1); // Head to Groggy's
      runChoice(1); // Select the first crew-member. Better options exist probably.
      runChoice(4); // Grab the Anemometer
      runChoice(4); // Swift Clipper, if it's unlocked
      runChoice(1); // Head to the sea
      */
}

void crabSail()
{

}

boolean crabs_run()
{
    return false;
}

boolean giantcrab_run()
{
    return false;
}

void trashSail()
{

}

void main()
{
    pirates_init();
    crabSail();
    crabs_run();
    giantcrab_run();
    trashSail();
}


