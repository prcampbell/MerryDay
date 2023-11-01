script md_iotm2020;

boolean GuzzlrHasQuest() 
{
	return get_property("questGuzzlr") != "unstarted";
}
 
boolean GuzzlrShouldTakeQuest() 
{
	if ( GuzzlrHasQuest() )	// Already on guzzlr quest
		return false;
	if ( get_property("_guzzlrDeliveries").to_int()>=get_property("Guzzlr.deliveryLimit").to_int() )	// Enough for today
		return false;
 
	if ( get_property("_guzzlrPlatinumDeliveries").to_int() < 1								// always take platinum quests
		|| !get_property("_guzzlrQuestAbandoned").to_boolean()										// OR take bronze/gold quests iff we can ditch the location
			&& get_property("_guzzlrGoldDeliveries").to_int() < 3 ) 									// AND if we haven't run out of gold quests for the day (prioritize bronze while charging the tablet, then gold for bucks)
		return true;
	return false;
}
 
void GuzzlrAbandonQuest() 
{
	if ( !get_property("_guzzlrQuestAbandoned").to_boolean() && GuzzlrHasQuest() ) 
    {
		set_property("choiceAdventure1412",1);
		use(1,$item[guzzlr tablet]);
	}
}
 
boolean GuzzlrKeepLocation() 
{	
	location GuzzlrLocation = get_property("guzzlrQuestLocation").to_location();
	if ( !($locations[The Oasis,Cobb's Knob Treasury] contains GuzzlrLocation) // Doesn't play nice with wanderers
		&& GuzzlrLocation.wanderers
		&& can_adv(GuzzlrLocation) 
		&& ( GuzzlrLocation.zone != "underwater"
			|| has_effect($effect[fishy])
			|| available_amount($item[fishy pipe])>0 && !get_property("_fishyPipeUsed").to_boolean()
			|| get_property("skateParkStatus") == "ice" && !get_property("_skateBuff1") .to_boolean()
			|| get_property("guzzlrDeliveryProgress").to_int() >= 66 ) )
		return true;
	else
		return false;
}

/*
 
boolean GuzzlrHasBooze() 
{
	item GuzzlrBooze = to_item(get_property("guzzlrQuestBooze"));
 
	if ( GuzzlrBooze == $item[Guzzlr cocktail set] ) 
    {
		item bestBooze;
		item bestAvailableBooze;
		item bestCraftBooze, bestCraftBoozeIngredient;
		int bestCraftValue = 1999999999;
		int totalCraft;
		boolean [item] PlatBoozes = $items[Buttery Boy,Ghiaccio Colada,Nog-on-the-Cob,Sourfinger,Steamboat];
		foreach it in PlatBoozes 
        {
			if ( bestBooze == $item[none] || itemValue(it)<itemValue(bestBooze) )
				bestBooze = it;
			if ( available_amount(it)>1 && (bestAvailableBooze == $item[none] || itemValue(it)<itemValue(bestAvailableBooze)) )
				bestAvailableBooze = it;
			totalCraft = 0;
			foreach ingredient in get_ingredients(it)
				if ( ingredient != $item[Guzzlr cocktail set] )
					totalCraft = itemValue(ingredient)*(available_amount(it)>0 ? 0.5 : 1);
			if ( totalCraft < itemValue(it) && (bestCraftBooze == $item[none] || totalCraft < bestCraftValue) ) {
				bestCraftBooze = it;
				bestCraftValue = totalCraft;
				foreach ingredient in get_ingredients(it)
					if ( ingredient != $item[Guzzlr cocktail set])
						bestCraftBoozeIngredient = ingredient;
			}
		}
 
		if ( bestAvailableBooze != $item[none] ) {
			foreach it in PlatBoozes
				if ( bestAvailableBooze == it && retrieve_item(1,it) )
					GuzzlrBooze = bestAvailableBooze;
				else
					put_closet(item_amount(it),it);
		}
		else if	( bestCraftBooze != $item[none] && bestCraftValue < itemValue(bestBooze) && StockUp(1,bestCraftBoozeIngredient,1,max(23456,itemValue(bestCraftBoozeIngredient))) && create(1,bestCraftBooze) )
			GuzzlrBooze = bestCraftBooze;
		else
			GuzzlrBooze = bestBooze;
	}
	return StockUp(1,GuzzlrBooze,1,min(23456,mall_price(GuzzlrBooze)));
}
 */
void GuzzlrTakeQuest() 
{
	if ( !GuzzlrKeepLocation() && !get_property("_guzzlrQuestAbandoned").to_boolean() )
		GuzzlrAbandonQuest();
	while ( GuzzlrShouldTakeQuest() ) {
		print("Starting guzzlr quest...","blue");
		use(1,$item[guzzlr tablet]);
		if ( !GuzzlrKeepLocation() && !get_property("_guzzlrQuestAbandoned").to_boolean() )
			GuzzlrAbandonQuest();
	}
	if ( GuzzlrHasQuest() )
		if ( !GuzzlrHasBooze() )
			GuzzlrAbandonQuest();			
}
 
boolean GuzzlrHasActiveQuest() 
{
	return (GuzzlrHasQuest() && GuzzlrKeepLocation() && GuzzlrHasBooze());
}
 
void Guzzlr() 
{
	if ( !retrieve_item(1,$item[guzzlr tablet]) )
		return;
 
	if ( can_interact() && !GuzzlrHasActiveQuest() )
		GuzzlrTakeQuest();
}
