import md_library;
import md_iotm2019;
import md_iotm2020;
int gnome() 
{
	// Ensure that you have body parts with the following priority. Otherwise snag the kgnee
	foreach i in $items[gnomish housemaid's kgnee, gnomish coal miner's lung, gnomish athlete's foot, gnomish swimmer's ears, gnomish tennis elbow]
		if(available_amount(i) < 1) return (to_int(i) - 5767);
	return 4;
}

void startDay()
{
	if(my_id() != '1787271')
	{
		abort();
	}
	
	if(get_property('valueOfAdventure') != '6000')
	{
		set_property('valueOfAdventure', '6000');
	}

	if(get_property('choiceAdventure1065') != 6)
	{
		set_property('choiceAdventure1065', '6');
	}

	if(get_property('garbo_stashClan').to_int() != TrampClan)
	{
		set_property('garbo_stashClan', TrampClan.to_string());
	}

	if(get_property('puzzleChampBonus') != 20)
		set_property('puzzleChampBonus', 20);

	if(get_property('skillLevel144') != 3)
		set_property('skillLevel144', 3);

	if(get_property('choiceAdventureScript') != 'md_choice.ash')
		set_property('choiceAdventureScript', 'md_choice.ash');

	if(get_property('betweenBattleScript') != 'md_preadventure.ash')
		set_property('betweenBattleScript', 'md_preadventure.ash');

	if(get_property('afterAdventureScript') != '')
		set_property('afterAdventureScript', '');

	if($item[raffle ticket].item_amount() < 11)
	{
		buyRaffle(11);
	}
	
	if(available_amount($item[can of rain-doh]) > 0)
	{
		use(1, $item[can of rain-doh]);
	}

	if(!get_property('moonTuned').to_boolean() && my_sign() != "Wombat")
	{
		cli_execute('spoon wombat');
	}
	if ( available_amount($item[raffle prize box]) > 0)
		use(available_amount($item[raffle prize box]),$item[raffle prize box]);
	if ( my_level() > 10 && get_property("questS01OldGuy") == "unstarted" )
		visit_url("place.php?whichplace=sea_oldman&action=oldman_oldman",false);

	switchClan(VIPClan);
	if (have_skill($skill[canticle of carboloading]) && !get_property("_carboLoaded").to_boolean() )
		use_skill(1,$skill[canticle of carboloading]);

	if(!get_property('_spaghettiBreakfastEaten').to_boolean()
		&& item_amount($item[spaghetti breakfast]) > 1)
	{
		if(item_amount($item[munchies pill]) > 0)
		{
			eat(1, $item[munchies pill]);
		}
		eat(1, $item[spaghetti breakfast]);
	}
	if(!get_property('breakfastCompleted').to_boolean())
	{
		cli_execute("breakfast");
		if(have_familiar($familiar[Reagnimated Gnome])) 
		{
			use_familiar($familiar[Reagnimated Gnome]);
			visit_url("arena.php");
			visit_url("choice.php?pwd&whichchoice=597&option="+gnome());
		}
	}
	
	if(!get_property('_chateauDeskHarvested').to_boolean())
	{
		visit_url("place.php?whichplace=chateau&action=chateau_desk1", false);
	}

	if (item_amount($item[earthenware muffin tin]) > 0 ||
	    (!get_property("_muffinOrderedToday").to_boolean() && 
			$items[blueberry muffin, bran muffin, chocolate chip muffin, earthenware muffin tin] contains get_property("muffinOnOrder").to_item())) 
	{
		visit_url("place.php?whichplace=monorail&action=monorail_downtown");
		run_choice(7); 
		if (get_property("muffinOnOrder") != "")
		{
			cli_execute("refresh inv");
			if (item_amount(get_property("muffinOnOrder").to_item()) > 0)
			{
				
				set_property("muffinOnOrder", "");
			}
		}
		if (!get_property("_muffinOrderedToday").to_boolean() && item_amount($item[earthenware muffin tin]) > 0) {
			run_choice(1);
		}
		run_choice(1); 
		run_choice(8); 
	}


	if ( can_interact() ) 
	{
		/*
		if ( (get_property_bool("_hotAirportToday") || get_property_bool("hotAirportAlways")) && have_skill($skill[Unaccompanied Miner]) && usesRemaining("_unaccompaniedMinerUsed",5)
			&& !has_effect($effect[Object Detection]) && my_adventures()>0 && my_basestat($stat[muscle])>=85 && my_basestat($stat[mysticality])>=85 && my_basestat($stat[moxie])>=85 )
		{
			outfit("Volcano Mining");
			if ( my_hp() == 0 && !use_skill(1,$skill[Cannelloni Cocoon]) && !use_skill(5,$skill[Tongue of the Walrus]) )
				abort("Login: Couldn't restore hp to mine the volcano");
			if ( numeric_modifier("hot resistance")<15 )
				print("Not enough hot resistance to mine the volcano","red");
			else {
				while (!(contains_text(visit_url(mineurl),"Mining a chunk of the cavern wall takes one Adventure.")) )
					main@minevolcano(max(1,5-get_property_int("_unaccompaniedMinerUsed")),true);
				printlifetime();
			}
		}
		*/

		cli_execute("call briefcase unlock");
		cli_execute("call briefcase collect");
	}



	

}

void main() 
{
	startDay();
}