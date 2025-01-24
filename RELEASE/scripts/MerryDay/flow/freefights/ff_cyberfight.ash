script ff_cyberfight;

string cyberfight = "if !monstername hacker; skill throw cyber rock;repeat;endif;if monstername hacker;if hasskill saucegeyser;skill saucegeyser;attack with your weapon;repeat;endif;";

boolean cyberfight_can()
{
    return get_property("_cyberFreeFights").to_int() < 10
}

boolean cyberfight_run()
{
    if(get_property("_cyberFreeFights").to_int() == 9) 
    {
        return adv1($location[Cyberzone 2], -1, cyberfight);
    }
    return adv1($location[Cyberzone 1], -1, cyberfight);
}



void main()
{
cli_execute("set choiceAdventure1545=1");
set_auto_attack(0);
set_property("battleAction", "custom combat script");
write_ccs(to_buffer(cyberfight), "cyberfight");
set_ccs("cyberfight");

while (get_property("_cyberFreeFights").to_int() < 9)
{
adv1($location[Cyberzone 1], -1, cyberfight);
}
while (get_property("_cyberFreeFights").to_int() == 9) {
adv1($location[Cyberzone 2], -1, cyberfight);
}
adv1($location[Cyberzone 1], -1, cyberfight);
}
