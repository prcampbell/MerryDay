script md_library;


boolean has_effect( effect ef ) 
{
	return (have_effect(ef) > 0);
}

boolean switchClan(int targetID) 
{
	if ( to_int(my_id()) > 30 && get_clan_id() != targetID ) {
		visit_url("showclan.php?recruiter=1&whichclan="+ targetID +"&pwd&whichclan=" + targetID + "&action=joinclan&apply=Apply+to+this+Clan&confirm=on");
	}
	return ( get_clan_id() == targetID );
}

void ensure_effect(effect ef, int turns) 
{
    if (have_effect(ef) < turns) {
        if (!cli_execute(ef.default) || have_effect(ef) == 0) {
            error('Failed to get effect ' + ef.name + '.');
        }
    } else {
        print('Already have effect ' + ef.name + '.');
    }
}

void ensure_effect(effect ef) 
{
    ensure_effect(ef, 1);
}

boolean[effect] song_slot_3 = $effects[Power Ballad of the Arrowsmith, The Magical Mojomuscular Melody, The Moxious Madrigal, Ode to Booze, Jackasses' Symphony of Destruction];
boolean[effect] song_slot_4 = $effects[Carlweather's Cantata of Confrontation, The Sonata of Sneakiness, Polka of Plenty];
void open_song_slot(effect song) 
{
    if(have_effect(song) == 0)
    {
        boolean[effect] song_slot;
        if (song_slot_3 contains song) song_slot = song_slot_3;
        else if (song_slot_4 contains song) song_slot = song_slot_4;
        foreach shruggable in song_slot 
		{
            cli_execute("shrug "+ shruggable.to_string());
        }
    }
    
}

void ensure_song(effect ef) 
{
    if (have_effect(ef) == 0) 
	{
        open_song_slot(ef);
        if (!cli_execute(ef.default) || have_effect(ef) == 0) 
		{
            error('Failed to get effect ' + ef.name + '.');
        }
    } 
	else 
	{
        print('Already have effect ' + ef.name + '.');
    }
}

boolean buyRaffle(int ticket_qty) 
{
	if(available_amount($item[raffle ticket]) < ticket_qty && visit_url("main.php").contains_text("map7beach.gif") && my_path() != "Zombie Slayer")
		cli_execute("raffle " + (ticket_qty-available_amount($item[raffle ticket])) + (can_interact() ? " inventory": " storage"));
	return(available_amount($item[raffle ticket]) >= ticket_qty);
}