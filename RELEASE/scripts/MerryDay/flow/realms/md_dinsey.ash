string questLog = "questlog.php?which=1";
string kiosk = "place.php?whichplace=airport_stench&action=airport3_kiosk";

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
    return(get_property('_stenchAirportToday').to_boolean() || get_property('stenchAirportAlways').to_boolean());
}

boolean get_dinsey_access()
{
    if(!has_dinsey_access())
    {
        string tmp = get_property('autoBuyPriceLimit');
        set_property('autoBuyPriceLimit', '150000');
        cli_execute('acquire 1 one-day ticket to Dinseylandfill');
        use(1, $item[one-day ticket to Dinseylandfill]);
        set_property('autoBuyPriceLimit', tmp);
    }
    return has_dinsey_access();
}

boolean dispose_garbage()
{
    if(get_property('_dinseyGarbageDisposed').to_boolean())
    {
        return true;
    }
    else if(item_amount($item[bag of park garbage]) < 3)
    {
        if(shop_amount($item[bag of park garbage]) >= 3)
        {
            take_shop(3, $item[bag of park garbage]);
        }
        visit_url('place.php?whichplace=airport_stench&action=airport3_tunnels');
        run_choice(6);
        return true; 
    }
    else
        return false;
}

boolean buy_dinsey_ticket()
{
    while(item_amount($item[FunFunds&trade;]) >= 20)
    {
        return buy($coinmaster[The Dinsey Company Store], 1, $item[one-day ticket to Dinseylandfill]);
    }
    return false;
}

boolean get_quest()
{
    if(hasDinseyQuest())
        return true;
    
    string page = visit_url( "place.php?whichplace=airport_stench&action=airport3_kiosk" );
    
    m = create_matcher( "<b>Track Maintenance</b>.*?name=option value=(.)>", page );
    if ( m.find() ) 
    {
        // Accept the job
        print( "They do!" );
        run_choice( m.group( 1 ).to_int() );
        run_choice( 6 );
        return true;
    }
    m = create_matcher( "<b>Electrical Maintenance</b>.*?name=option value=(.)>", page );
    if ( m.find() ) 
    {
        // Accept the job
        print( "They do!" );
        run_choice( m.group( 1 ).to_int() );
        run_choice( 6 );
        return true;
    }
    m = create_matcher( "<b>Compulsory Fun</b>.*?name=option value=(.)>", page );
    if ( m.find() ) 
    {
        // Accept the job
        print( "They do!" );
        run_choice( m.group( 1 ).to_int() );
        run_choice( 6 );
        return true;
    }
    m = create_matcher( "<b>Racism Reduction</b>.*?name=option value=(.)>", page );
    if ( m.find() ) 
    {
        // Accept the job
        print( "They do!" );
        run_choice( m.group( 1 ).to_int() );
        run_choice( 6 );
        return true;
    }
    m = create_matcher( "<b>Sexism Reduction/b>.*?name=option value=(.)>", page );
    if ( m.find() ) 
    {
        // Accept the job
        print( "They do!" );
        run_choice( m.group( 1 ).to_int() );
        run_choice( 6 );
        return true;
    }
    matcher m = create_matcher( "<b>Waterway Debris Removal</b>.*?name=option value=(.)>", page );
    if ( m.find() ) 
    {
        // Accept the job
        print( "They do!" );
        run_choice( m.group( 1 ).to_int() );
        run_choice( 6 );
        return true;
    }

    // Leave the Kiosk
    run_choice( 6 );

    return false;
}

void main()
{
    get_dinsey_access();
    dispose_garbage();
    buy_dinsey_ticket();
    get_quest();
}