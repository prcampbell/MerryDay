boolean hasDinseyQuest()
{
	string text = visit_url(questLog);
	foreach qName in $strings[Social Justice Adventurer II, Teach a Man to Fish Trash, Whistling Zippity-Doo-Dah, Nasty\, Nasty Bears, Give Me Fuel, Super Luber, Social Justice Adventurer I, Will Work With Food]
	{
		if (contains_text(text,qName))
			return TRUE;
	}
	return FALSE;
}

string parseDinseyQuest()
{
	string text = visit_url(questLog);
	string output;
	foreach qName in $strings[Social Justice Adventurer I, Teach a Man to Fish Trash, Whistling Zippity-Doo-Dah, Nasty\, Nasty Bears, Give Me Fuel, Super Luber, Social Justice Adventurer II, Will Work With Food]
	{
		if (contains_text(text,qName))
			output = qName;
	}
	return output;
}


boolean has_dinsey_access()
{
    return(get_property('_stenchAirportToday').to_boolean() || get_property('stenchAirportAlways').to_boolean())
}

boolean get_dinsey_access()
{
    if(!has_dinsey_access())
    {
        cli_execute('acquire 1 one-day ticket to dinsey landfill');
        use(1, $item[one-day ticket to dinsey landfill]);
    }
    return has_dinsey_access();
}

boolean dispose_garbage()
{
    return false;
}

boolean get_quest()
{
    if(hasDinseyQuest())
        return true;
    
    return false;
}

void main()
{
    get_dinsey_access();
}