script ff_cyberfight;

boolean cyberfight_can()
{
    return get_property("_cyberFreeFights").to_int() < 10;
}

boolean cyberfight_run()
{
    string cyberfight = "if !monstername hacker; skill throw cyber rock;repeat;endif;if monstername hacker;if hasskill saucegeyser;skill saucegeyser;attack with your weapon;repeat;endif;";
    set_property("battleAction", "custom combat script");
    write_ccs(to_buffer(cyberfight), "cyberfight");
    set_ccs("cyberfight");


    if(get_property("_cyberFreeFights").to_int() == 9) 
    {
        return adv1($location[Cyberzone 2], -1, cyberfight);
    }
    return adv1($location[Cyberzone 1], -1, cyberfight);
}


