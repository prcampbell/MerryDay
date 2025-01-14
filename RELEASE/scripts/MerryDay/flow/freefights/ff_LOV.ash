script "ff_lov";

boolean LOV_can()
{
    return !get_property('_loveTunnelUsed').to_boolean();
}

void LOV_run()
{
    if (!(get_property('_loveTunnelUsed').to_boolean())) {
        // Run the fights
        visit_url("place.php?whichplace=town_wrong&action=townwrong_tunnel");
	    run_choice(1);
        // Fight 1 - Epaul
        run_choice(1);
        run_combat();
        run_choice(2);
        // Fight 2 - Familiar
        run_choice(1);
        run_combat();
        run_choice(2);
        // Fight 3 - Enamorang
        run_choice(1);
        run_combat();
        run_choice(3);
    }
}

void main()
{
    if(LOV_can())
        LOV_run();
}