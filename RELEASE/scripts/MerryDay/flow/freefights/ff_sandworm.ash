void BuffItems() 
{
 
	if ( available_amount($item[li'l ninja costume]) <= 0 ) {
		
		if ( my_familiar() == $familiar[stooper] && freeLiver() == 0 || freeLiver() == -1 && my_familiar() != $familiar[stooper] )
			use_familiar($familiar[stooper]);
		equip($item[The Jokester's Gun]);
		if(can_adv( $location[Lair of the Ninja Snowmen], false ))
			adv1($location[Lair of the Ninja Snowmen], -1, "");
		else
			c2t_cartographyHunt($location[The Haiku Dungeon], $monster[amateur ninja]);
		equip($item[fourth of may cosplay saber]);
	}
	set_location($location[Friar Ceremony Location]);
	if ( available_amount($item[li'l ninja costume]) <= 0 ) //'
		abort("Couldn't get li'l ninja costume, for some reason");
	use_familiar($familiar[Trick-or-Treating Tot]);
	if(!contains_text(get_property('_mummeryMods'), 'Item Drop'))
		cli_execute('mummery item');
	if ( !has_effect($effect[Steely-eyed squint]) && !get_property("_steelyEyedSquintUsed").to_boolean() && have_skill($skill[Steely-eyed Squint]) )
		use_skill($skill[Steely-eyed Squint]);
	if ( !has_effect($effect[Clyde's Blessing]) && retrieve_item($item[The Legendary Beat]) && !get_property("_legendaryBeat").to_boolean() ) //'
		use($item[The Legendary Beat]);
	if ( !has_effect($effect[Pork Barrel]) && is_unrestricted($item[shrine to the barrel god]) && get_property("barrelShrineUnlocked").to_boolean() && !get_property("_barrelPrayer").to_boolean() && my_class() == $class[Pastamancer] )
		cli_execute("barrelprayer buff");
	if ( !has_effect($effect[Billiards Belligerence]) 		&& get_property("_poolGames") < 3 && (get_clan_lounge() contains $item[Clan pool table] ) )
		cli_execute("pool 3");
	if ( !has_effect($effect[There's No N in Love]) 		&& !get_property("_clanFortuneBuffUsed").to_boolean() && (get_clan_lounge() contains $item[Clan Carnival Game] ) )
		cli_execute("fortune buff item");
	if ( !has_effect($effect[Uncucumbered]) 				&& !get_property("_daycareSpa").to_boolean() && (get_property("daycareOpen").to_boolean() || get_property("_daycareToday").to_boolean()) )
		cli_execute("daycare mysticality");
	if ( have_skill($skill[Fat Leon's Phat Loot Lyric]) && !has_effect($effect[Fat Leon's Phat Loot Lyric]) )
		use_skill($skill[Fat Leon's Phat Loot Lyric]);
	if ( !has_effect($effect[Clyde's Blessing]) && retrieve_item($item[The Legendary Beat]) && !get_property("_legendaryBeat").to_boolean() ) //'
		use($item[The Legendary Beat]);
	if(!has_effect($effect[Certainty]) && item_amount($item[abstraction: Certainty]) > 0  && my_spleen_use() < spleen_limit())
		cli_execute('chew abstraction: certainty');
	if(!has_effect($effect[Synthesis: Collection]) && my_spleen_use() < spleen_limit())
		cli_execute('synthesize collection');
	

	maximize("item drop, -equip lucky sock",false);
	cli_execute("gain 4900 item");	// 	Ezandora's gain.ash
}


void ChestXRay() {
	while ( get_property("_chestXRayUsed") < 3 && (get_property("garbageChampagneCharge")>0) )
     {
		boolean [item] RequiredItems;
		RequiredItems[$item[Lil' Doctor&trade; bag]] = true; //'
		set_location($location[Friar Ceremony Location]);
        use_familiar($familiar[Trick-or-Treating Tot]);
		maximize("item drop, -equip lucky sock,equip Lil' Doctor&trade; bag",false);
		use( 1, $item[drum machine] );
		if ( get_property("garbageChampagneCharge")==0 && !get_property("_garbageItemChanged").to_boolean() ) {
			cli_execute("fold wad of used tape");
			cli_execute("fold broken champagne bottle");
		}
	}
}


void OtherFreeFreeKills() 
{
	while ( get_property("_usedReplicaBatoomerang") < 3 && (get_property("garbageChampagneCharge") > 0) ) 
	{	
        // other free kills are higher in combat order, so they'll be used before the boomerang: lightning strike, shattering punch, mob hit, asdon martin missile

		set_location($location[Friar Ceremony Location]);
		use_familiar($familiar[Trick-or-Treating Tot]);
		maximize("item drop, -equip lucky sock",false);

		use( 1, $item[drum machine] );

        if ( get_property("garbageChampagneCharge").to_int() == 0 && !get_property("_garbageItemChanged").to_boolean() ) {
            cli_execute("fold wad of used tape");
            cli_execute("fold broken champagne bottle");
        }

	}

}

void MadnessKills()
{
	cli_execute('closet take * powderedMadness');
	if ( get_property("garbageChampagneCharge").to_int() == 0 && !get_property("_garbageItemChanged").to_boolean() ) 
	{
		cli_execute("fold wad of used tape");
		cli_execute("fold broken champagne bottle");
	}
	while ( get_property("_powderedMadnessUses") < 5 && item_amount($item[powdered madness]) > 0 && (get_property("garbageChampagneCharge") > 0) ) 
	{	
		cli_execute('ccs madness');
		set_location($location[Friar Ceremony Location]);
		use_familiar($familiar[Trick-or-Treating Tot]);
		maximize("item drop, -equip lucky sock",false);
		use( 1, $item[drum machine] );

		print("GarbageChampaneCharge:", "red");
		print(get_property("garbageChampagneCharge"), "purple");

		print("_garbageItemChanged:", "red");
		print(get_property("_garbageItemChanged:"), "purple");
		
		print((get_property("garbageChampagneCharge").to_int() == 0 && !get_property("_garbageItemChanged").to_boolean()).to_string(),"green");

		if ( get_property("garbageChampagneCharge").to_int() == 0 && !get_property("_garbageItemChanged").to_boolean() ) {
			cli_execute("fold wad of used tape");
			cli_execute("fold broken champagne bottle");
		}
	}
}

void Sandworm() 
{
	set_auto_attack(0);
    if ( get_property("garbageChampagneCharge")==0 && !get_property("_garbageItemChanged").to_boolean() ) 
    {
        cli_execute("fold wad of used tape");
        cli_execute("fold broken champagne bottle");
    }
 
	if ( !(get_property("garbageChampagneCharge") > 0
			&& ( 
                has_effect($effect[Steely-eyed squint]) 
                || !get_property("_steelyEyedSquintUsed").to_boolean() && have_skill($skill[Steely-eyed Squint]) 
                )
            )
        ) 
		return;
    cli_execute('mood apathetic');
	BuffItems();
	ChestXRay();
	OtherFreeFreeKills();
}

void main()
{
	Sandworm();
}