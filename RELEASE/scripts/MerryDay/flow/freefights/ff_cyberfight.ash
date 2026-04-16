script ff_cyberfight;
import md_outfit;

boolean cyberfight_can()
{
    return get_property("_cyberFreeFights").to_int() < 10;
}

boolean cyberfight_run()
{
    string cyberfight = "if !monstername hacker; skill throw cyber rock;repeat;endif;if monstername hacker;if hasskill saucegeyser;skill saucegeyser;attack with your weapon;repeat;endif;";

    if(get_property("_cyberFreeFights").to_int() == 9) 
    {
        return adv1($location[Cyberzone 2], -1, cyberfight);
    }
    return adv1($location[Cyberzone 1], -1, cyberfight);
} 


void flood_cyber()
{
    set_property('betweenBattleScript', '');
    set_property('afterAdventureScript', '');
    item[slot] required_equips;     
    required_equips[$slot[weapon]] = $item[monodent of the sea];     
    construct_free_outfit(required_equips);
    if(get_auto_attack() != 0)
        set_auto_attack(0);
    if(cyberfight_can())
        cyberfight_run();
    use_skill(1, $skill[Sea *dent: Summon a Wave]);
    if(handling_choice())
        run_choice(1);

    set_property("battleAction", "attack with weapon");
}

