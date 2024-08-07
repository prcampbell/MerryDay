import md_library;
import md_iotm2019;
import md_iotm2020;

void startDay()
{
	if(my_id() != '1787271')
	{
		abort();
	}
	
	if(get_property('valueOfAdventure') != '7000')
	{
		set_property('valueOfAdventure', '7000');
	}

	if(get_property('choiceAdventure1065') != 6)
	{
		set_property('choiceAdventure1065', '6');
	}

	if(get_property('garbo_stashClan') != 2046989819)
	{
		set_property('garbo_stashClan', '2046989819');
	}

	if(get_property('puzzleChampBonus') != 20)
		set_property('puzzleChampBonus', 20);

	if(get_property('skillLevel144') != 3)
		set_property('skillLevel144', 3);

	buyRaffle(11);

	if(available_amount($item[can of rain-doh]) > 0)
	{
		use(1, $item[can of rain-doh]);
	}

	if(!get_property('moonTuned').to_boolean() && my_sign() != "Wombat")
	{
		cli_execute('spoon wombat');
	}
	if ( available_amount($item[raffle prize box])>0 )
		use(available_amount($item[raffle prize box]),$item[raffle prize box]);
	if ( my_level() > 10 && get_property("questS01OldGuy") == "unstarted" )
		visit_url("place.php?whichplace=sea_oldman&action=oldman_oldman",false);

	switchClan(VIPClan);
	cli_execute("breakfast");
	if (have_skill($skill[canticle of carboloading]) && !get_property("_carboLoaded").to_boolean() )
		use_skill(1,$skill[canticle of carboloading]);


	//Glaciest();
	//Guzzlr();
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


		if ( available_amount($item[fisherman's sack]) > 0 )
			use(available_amount($item[fisherman's sack]),$item[fisherman's sack]); //'
		//StockUpList();
		//cli_execute("call briefcase unlock");
		//cli_execute("call briefcase collect");
		//voteInVotingBooth();
		//horsery();
		MaySaber(4);
		//selfEsteem(false);
	}


	//if ( Pick() ) cli_execute("garden pick");
	//getChateauStuff();
	if ( item_amount($item[BittyCar MeatCar]) > 0)
		use(1, $item[BittyCar MeatCar]);
	while ( get_property("_feelDisappointedUsed").to_int() < 3 )
		use_skill(1,$skill[Feel Disappointed]);
	cli_execute('witchess buff');
	//birdBuff();
	use(1, $item[wardrobe-o-matic]);
	if(!get_property('lockPicked').to_boolean())
	{
		if(item_amount($item[Boris's key lime pie]) <= item_amount($item[Sneaky Pete's key lime pie]) && item_amount($item[Boris's key lime pie]) <= item_amount($item[Jarlsberg's key lime pie]))
		{
			set_property('choiceAdventure1414', '1');
			use_skill($skill[Lock Picking]);
			cli_execute('make boris key lime pie');
		}
		else if(item_amount($item[Jarlsberg's key lime pie]) <= item_amount($item[Sneaky Pete's key lime pie]) && item_amount($item[Jarlsberg's key lime pie]) <= item_amount($item[Boris's key lime pie]))
		{
			set_property('choiceAdventure1414', '2');
			use_skill($skill[Lock Picking]);
			cli_execute('make jarlsberg key lime pie');
		}
		else if(item_amount($item[Sneaky Pete's key lime pie]) <= item_amount($item[Boris's key lime pie]) && item_amount($item[Sneaky Pete's key lime pie]) <= item_amount($item[Jarlsberg's key lime pie]))
		{
			set_property('choiceAdventure1414', '3');
			use_skill($skill[Lock Picking]);
			cli_execute('make sneaky pete key lime pie');
		}
	}
	cli_execute('farfuture drink');
}

void main() 
{
	startDay();
}