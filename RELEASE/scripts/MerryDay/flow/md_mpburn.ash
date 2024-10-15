script mpBurn
import Librams.ash
import md_library;
import md_iotm2019;
import md_iotm2020;
 
string MPMaximizerString = "mp, -mana cost, -buddybjorn, -crownofthrones, -equip hewn moon-rune spoon, switch tot, switch disembodied hand, switch left-hand man";
boolean maximizedMP = false;
int mpRestored;

void mpBuff()
{
	//maximize('mp, outfit vile vagrant, equip brimstone bracelet, switch left-hand man', false);
	maximize('mp, outfit vile vagrant, equip brimstone bracelet, switch left-hand man', false);
	//Slotless All Stats
	//Telescope
	if (get_campground() contains $item[discount telescope warehouse gift certificate] 
		&& get_property("telescopeUpgrades").to_int() > 0 
		&& get_property("telescopeLookedHigh") == "false") 
	{
		cli_execute("telescope high");
	}
	if(!get_property("_streamsCrossed").to_boolean())
	{
		cli_execute("crossstreams");
	}
	
	if(!get_property(" _ballpit").to_boolean())
	{
		cli_execute("ballpit");
	}
	
	if(!get_property("_spacegateVaccine").to_boolean())
	{
		ensure_effect($effect[Broad-Spectrum Vaccine]);
	}
	
	ensure_effect($effect[Feeling Excited]);
	if(!get_property("_daycareSpa").to_boolean())
	{
		ensure_effect($effect[Uncucumbered]);
	}

	//monorail buff
	if (!get_property('_lyleFavored').to_boolean()) 
	{
		ensure_effect($effect[Favored by Lyle]);
	}

	//Myst Buffs
	if(have_effect($effect[[1457]blood sugar sauce magic]) == 0)
		use_skill($skill[Blood Sugar Sauce Magic]);
	ensure_effect($effect[We're All Made of Starfish]); //'

	if(my_mp() < 200 && !get_property('oscusSodaUsed').to_boolean())
	{
		use(1, $item[Oscus's neverending soda]);
	}

	ensure_effect($effect[Quiet Judgement]);
	ensure_effect($effect[Song of Bravado]);
	ensure_effect($effect[Big]);
	ensure_song($effect[The Magical Mojomuscular Melody]);
	ensure_song($effect[Stevedave's Shanty of Superiority]); //'

	
  
}

void Aug15() 
{
   
    if(have_skill($skill[Aug. 15th: Relaxation Day!]))
    { 
      LibramBurn(true);
      use_skill($skill[Aug. 15th: Relaxation Day!]);
      LibramBurn();
    }
    
}

void PYEC() 
{
	if ( !(to_boolean(get_property("expressCardUsed"))) && (take_stash(1 , $item[Platinum Yendorian Express Card])||item_amount($item[Platinum Yendorian Express Card]) > 0) ) 
  	{
		LibramBurn(true);
		use(1,$item[Platinum Yendorian Express Card]);
		put_stash(1, $item[Platinum Yendorian Express Card]);
		LibramBurn(false);
	}
}

void ClanShower() 
{
	if ( !get_property("_aprilShower").to_boolean() && switchClan(84165) )   //AfHeck
	{
		mpRestored = 1000;
		if ( mpRestored < my_maxmp()-my_mp() ) 
		{
			cli_execute("shower hot");

			while(have_effect($effect[Leash of Linguini]) < 600)
			{
				use_skill(1, $skill[Leash of Linguini]);
			}
			while(have_effect($effect[Disco Leer]) < 600)
			{
				use_skill(1, $skill[Disco Leer]);
			}
			while(have_effect($effect[Ruthlessly Efficient]) < 600)
			{
				use_skill(1, $skill[Ruthless Efficiency]);
			}
			while(have_effect($effect[Curiosity of Br'er Tarrypin]) < 600)
			{
				use_skill(1, $skill[Curiosity of Br'er Tarrypin]);
			}

			LibramBurn();
		}
	}
}

void FratNuns() 
{
	while ( get_property("sidequestNunsCompleted")=="fratboy" && get_property("nunsVisits").to_int() < 3) 
  	{
		mpRestored = 1000;
		if ( mpRestored < my_maxmp()-my_mp() ) 
		{
			cli_execute("nuns");
			LibramBurn();
		}
		else
			break;
	}
}
 
void Sausages() 
{
	while ( get_property("_sausagesEaten").to_int() < 23 && available_amount($item[magical sausage casing]) > 0) 
	{
		mpRestored = 1000;
		if ( mpRestored < my_maxmp()-my_mp() ) 
		{
			cli_execute("make magic sausage; eat magic sausage");
			LibramBurn();
		}
		else
			break;
	}
}

void GingerLatte()
{
	if(get_property("_gingerbreadCityTurns") >= 5)
		return;
	if(get_property("_gingerbreadCityTurns") == 0 && get_property("_latteRefillsUsed") != 0)
	{
		return;
	}
	if(!contains_text(get_property('latteUnlocks'), 'cajun') 
		&& !contains_text(get_property('latteUnlocks'), 'carrot')
		&& !contains_text(get_property('latteUnlocks'), 'rawhide')
	)
	{
		return;
	}
	use_familiar($familiar[Blavious Kloop]);
	equip($slot[off-hand], $item[latte lovers member's mug]);

	set_property('choiceAdventure1215', '1');
	set_property('choiceAdventure1204', '1');

	if(!(to_boolean(get_property("_gingerbreadClockAdvanced"))))
	{
		visit_url('adventure.php?snarfblat=477');
		run_choice(1);
	}
	while(to_int(get_property("_gingerbreadCityTurns")) < 5)
	{
		adv1($location[Gingerbread Train Station], -1, 'skill gulp latte; skill throw latte;');
		cli_execute('Librams; latte refill cajun rawhide carrot');
	}
}

/* 
stat highestBaseStat() {
	stat highestStat = $stat[mysticality];
	foreach st in $stats[muscle,moxie]
		if ( my_basestat(st) > my_basestat(highestStat) )
			highestStat = st;
	return highestStat;
}
 
boolean GetSphygmayomanometer() {
	if (!get_property_bool("_mayoDeviceRented") && get_property_int("mayoLevel") >= 80 ) {
		if ( MayoClinicAvailable() )
			buy(1,$item[sphygmayomanometer]);
	}
	return retrieve_item(1,$item[sphygmayomanometer]);
}
 
void MPPrep() {
	if ( my_basestat(highestBaseStat()) - my_basestat($stat[mysticality]) > 100 && !(string_modifier("Equalize") == "High" || string_modifier("Equalize") == highestBaseStat().to_string()) ) {
		if ( highestBaseStat() == $stat[moxie] ) {
			MPMaximizerString = MPMaximizerString+", equip moxie magnet";
			equip($item[moxie magnet]);
			if ( !has_effect($effect[Ten out of Ten]) && (get_property_bool("daycareOpen") || get_property_bool("_daycareToday")) && !get_property_bool("_daycareSpa") )
				cli_execute("daycare moxie");
		}
		else if ( highestBaseStat() == $stat[muscle] && StockUp(1,$item[oil of stability],654,987) 
			&& to_float(my_basestat($stat[muscle])-my_basestat($stat[mysticality]))*(100.0+numeric_modifier("mysticality percent"))*(100.0+numeric_modifier("maximum mp percent"))/100/100 > 1000 )
		{
			use(1,$item[oil of stability]);
		}
	}
	if ( !has_effect($effect[Uncucumbered]) && (get_property_bool("daycareOpen") || get_property_bool("_daycareToday")) && !get_property_bool("_daycareSpa") )
		cli_execute("daycare mysticality");
	StockUp(1,$item[green mana],5432,7654);
 
	if ( !get_property_bool("telescopeLookedHigh") && !has_effect($effect[Starry-Eyed]) )
		cli_execute("telescope high;");
	if ( !get_property_bool("_lyleFavored") && !has_effect($effect[Favored by Lyle]) ) {
		cli_execute("monorail buff;");	
		visit_url("main.php");
	}
	if ( !get_property_bool("_streamsCrossed") && !has_effect($effect[Total Protonic Reversal]) && available_amount($item[protonic accelerator pack])>0 )
		cli_execute("crossstreams;");
	if ( !get_property_bool("_ballpit") && !has_effect($effect[Having a Ball!]) && (get_clan_rumpus()["Awesome Ball Pit"] >= 10000 || switchClan(84165)) ) // AfHeck
		cli_execute("ballpit;");
	if ( !has_effect($effect[Stevedave's Shanty of Superiority]) && have_skill($skill[Stevedave's Shanty of Superiority]) && makeRoomSong() )
		use_skill(1,$skill[Stevedave's Shanty of Superiority]); //'
	if ( !has_effect($effect[Song of Bravado]) && have_skill($skill[Song of Bravado]) )
		use_skill(1,$skill[Song of Bravado]);
	if ( !has_effect($effect[Triple-Sized]) && available_amount($item[Powerful Glove])>0 && $skill[CHEAT CODE: Triple Size].dailylimit > 0 && equip($item[Powerful Glove]) )
		use_skill(1,$skill[CHEAT CODE: Triple Size]);
	if ( !has_effect($effect[[1457]Blood Sugar Sauce Magic]) && !has_effect($effect[[1458]Blood Sugar Sauce Magic]) && have_skill($skill[Blood Sugar Sauce Magic]) )
		use_skill(1,$skill[Blood Sugar Sauce Magic]);
	if ( !get_property_bool("_spacegateVaccine") && !has_effect($effect[Broad-Spectrum Vaccine]) && get_property_bool("spacegateVaccine2") && (get_property_bool("spacegateAlways") || get_property_bool("_spacegateToday")) )
		cli_execute("spacegate vaccine 2");
	GetSphygmayomanometer();
}
 
void MaybeMaximizeMP( int mpRestored ) {
	if ( !maximizedMP && (mpRestored < 0 || mpRestored > my_maxmp()-my_mp() || my_maxmp() < mp_cost($skill[Summon BRICKOs])) ) {
		MPPrep();
		maximize(MPMaximizerString,false);
		maximizedMP = true;
	}
}
 
void LicenseToChill() {
	if ( !get_property_bool("_licenseToChillUsed") && available_amount($item[License to Chill])>0 ) {
		MaybeMaximizeMP(-1);
		LibramBurn(true);
		use(1,$item[license to chill]);
		LibramBurn(false);
	}
}
void FreeRests() {
	item previousPants;
 
	if ( get_property_int("timesRested") < total_free_rests() ) {
		try {
			int mpRestored = numeric_modifier(get_dwelling(),"Base Resting MP")*(100+numeric_modifier("Resting MP Percent"))/100;
			mpRestored += numeric_modifier("Bonus Resting MP");
			if ( equipped_amount($item[pantsgiving])==0 && available_amount($item[pantsgiving])>0 )
				mpRestored += numeric_modifier($item[pantsgiving],"Bonus Resting MP");
			print("mpRestored: "+mpRestored);
			if ( mpRestored > 125 ) {
				set_property("restUsingChateau","false");
				set_property("restUsingCampAwayTent","false");
				if ( equipped_item($slot[pants]) != $item[pantsgiving] && my_fullness()>0 ) {
					previousPants = equipped_item($slot[pants]);
					equip($slot[pants],$item[pantsgiving]);
				}
			}
			else
				mpRestored = 126;
			while ( get_property_int("timesRested") < total_free_rests() ) {
				MaybeMaximizeMP(mpRestored);
				if ( mpRestored < my_maxmp()-my_mp() ) {
					cli_execute("rest free");
					LibramBurn();
				}
				else
					break;
			}
		}
		finally {
			set_property("restUsingChateau","true");
			set_property("restUsingCampAwayTent","true");
			if ( previousPants != $item[none] && equipped_item($slot[pants]) == $item[pantsgiving] )
				equip($slot[pants],previousPants);
		}
	}
}
 
void NeverendingSoda() {
	if ( !get_property_bool("oscusSodaUsed") && item_amount($item[Oscus's neverending soda]) > 0 ) {
		mpRestored = 300;
		MaybeMaximizeMP(mpRestored);
		if ( mpRestored < my_maxmp()-my_mp() ) {
			use(1,$item[Oscus's neverending soda]);
			LibramBurn();
		}
	}
}
 
void EternalCarBattery() {
	if ( !get_property_bool("_eternalCarBatteryUsed") && item_amount($item[eternal car battery]) > 0 ) {
		mpRestored = 55;
		MaybeMaximizeMP(mpRestored);
		if ( mpRestored < my_maxmp()-my_mp() ) {
			use(1,$item[eternal car battery]);
			LibramBurn();
		}
	}
}

 
*/

void unlockLatte()
{
	if(contains_text(get_property('latteUnlocks'), 'cajun') 
		&& contains_text(get_property('latteUnlocks'), 'carrot')
		&& contains_text(get_property('latteUnlocks'), 'rawhide')
	)
	{
		return;
	}
	while(!contains_text(get_property('latteUnlocks'), 'cajun'))
	{
		set_property('choiceAdventure923', '1');
		set_property('choiceAdventure461', '1');
		
		if(get_property('blackForestProgress').to_int() == 0)
		{
			return;
		}
		use_familiar($familiar[frumious bandersnatch]);
		equip($slot[off-hand], $item[latte lovers member's mug]);
		ensure_song($effect[Ode To Booze]);
		adv1($location[The Black Forest], -1, 'runaway;');
	}
	while(!contains_text(get_property('latteUnlocks'), 'rawhide'))
	{
		set_property('choiceAdventure505', '2');
		set_property('choiceAdventure505', '3');
		use_familiar($familiar[frumious bandersnatch]);
		equip($slot[off-hand], $item[latte lovers member's mug]);
		ensure_song($effect[Ode To Booze]);
		adv1($location[The Spooky Forest], -1, 'runaway;');
	}	
	while(!contains_text(get_property('latteUnlocks'), 'carrot'))
	{
		use_familiar($familiar[frumious bandersnatch]);
		equip($slot[off-hand], $item[latte lovers member's mug]);
		ensure_song($effect[Ode To Booze]);
		adv1($location[The Dire Warren], -1, 'runaway;');
	}
}
void main() 
{
	//mpBuff();
    //Aug15(); 
    //PYEC();
    //ClanShower();
    //FratNuns();
	//Sausages();
	unlockLatte();

}