import c2t_megg.ash;
import md_outfit.ash;

familiar fam = $familiar[none];
item fameq = $item[none];
familiar throne = $familiar[none];
familiar bjorn = $familiar[none];
item[slot] equipment;
int autoAttack, turnsPlayed, clan;
boolean SetupSaved = FALSE;
string aa;	
string afterAdventureScript;
string beforeAdventureScript;
string sourceTerminalEducate1;
string sourceTerminalEducate2;
location lastLocation;
string questLog = "questlog.php?which=1";
string kiosk = "place.php?whichplace=airport_stench&action=airport3_kiosk";
string parka;

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

void SaveSetup() 
{
	if (!SetupSaved) 
	{
		print("Saving setup ...", "green");
		fam = my_familiar();
		throne = my_enthroned_familiar();
		bjorn = my_bjorned_familiar();
		fameq = familiar_equipped_equipment(fam);
		foreach eqSlot in $slots[]
			equipment[eqSlot] = equipped_item(eqSlot);
		if(have_equipped($item[jurassic parka]))
			parka = get_property('parkaMode');
		aa = get_auto_attack();
        beforeAdventureScript = get_property("betweenBattleScript");
        set_property("betweenBattleScript", "");
		afterAdventureScript = get_property("afterAdventureScript"); 
		set_property("afterAdventureScript", ""); //Note Awkward workaround: required to stop nested calls of the after Adventure script (as would otherwise happen after any of the adv1() calls in the script). The nesting messes up the restoration of the setup
		SetupSaved = TRUE; //To prevent overriding the first saved setup, in case multiple of the functions in the script get called in succession (like picking a bricko fight and then busting a ghost). 
//Specifically done at the end, because Restoring a partial setup can get kinda messy (folder holder slots are in $slots[], as I found out the hard way after wondering for a while why my folder holder would randomly be empty every once in a while).
	}
}

void RestoreSetup() 
{
	if (SetupSaved) 
	{
		print("Restoring setup ... ", "green");
		set_property("afterAdventureScript", afterAdventureScript);
        set_property("betweenBattleScript", beforeAdventureScript);
		if (aa != get_auto_attack())
        {   
            print("Trying to set autoattack to ... ", "green");
            print(aa, "purple");
            if(aa == '99184996')
                cli_execute('autoattack BasicBarf');
            else
                set_auto_attack(aa);
        }
			
		if(fam != my_familiar()) 
		{
			use_familiar(fam);
			if(my_familiar() != $familiar[Comma Chameleon])
			{
				if(fameq != $item[none])
				{
					equip(fameq);
				}
			}
					
		}
		cli_execute('outfit birthday suit');
		foreach eqSlot in $slots[]
		{
			if(available_amount(equipment[eqSlot]) == 0 && equipment[eqSlot] != $item[none])
			{
				cli_execute('fold ' + equipment[eqSlot].to_string());
			}
			if (equipped_item(eqSlot) != equipment[eqSlot])
				equip(eqSlot, equipment[eqSlot]);
		}
		if(have_equipped($item[jurassic parka]) && get_property('parkaMode') != parka)
			cli_execute('parka '+ parka);

		if (throne != my_enthroned_familiar()) 
			enthrone_familiar( throne );
		if (bjorn != my_bjorned_familiar())
			bjornify_familiar(bjorn);
		
		print("... Restored setup", "green");
	}
}

void bustGhost() 
{
	if(to_location(get_property("ghostLocation")) == $location[none])
		return;
	buffer stun() 
	{
		buffer stun;
		void addstun(skill sk) {
			if(sk != $skill[none] && have_skill(sk)) {
				stun.append("if hasskill ");
				stun.append(to_int(sk));
				stun.append("; skill ");
				stun.append(to_int(sk));
				stun.append("; endif; ");
			}
		}
		void addstun(item it) {
			if(it != $item[none] && available_amount(it) > 0) {
				stun.append("if hascombatitem ");
				stun.append(to_int(it));
				stun.append("; use ");
				stun.append(to_int(it));
				stun.append("; endif; ");
			}
		}
		foreach sk in $skills[Summon Love Gnats, Mind Bullets]
			addstun(sk);
		addstun(stun_skill());
		if(length(stun) == 0)
			addstun($skill[Shadow Noodles]);
		foreach it in $items[chloroform rag, gas balloon, floorboard cruft]
			if(length(stun) == 0)
				addstun(it);
		return stun.insert(0, "skill Shoot Ghost; "); // Inserting because something goes wrong when stun is first? This attack gets ignored!
	}
	SaveSetup();
    set_auto_attack(0);
	item acc3;
	familiar fam;
	location ghostLocation = to_location(get_property("ghostLocation"));
	if(my_inebriety() <= inebriety_limit() 
		&& to_boolean(get_property("kingLiberated")) 
		&& ghostLocation != $location[none]) 
	{ 
		// If last adventure was getting beaten up, then ABORT! (Last adventure might have been losing to this ghost.)
		if(run_combat().contains_text("<p>You lose.  You slink away"))
			abort("Whoa! Not doing well here! Fight this ghost manually!");
		
		item[slot] needs;

		switch(ghostLocation) 
		{
			case $location[Inside the Palindome]:
				needs[$slot[acc3]] = $item[Talisman o' Namsilat];
				break;
			case $location[The Skeleton Store]:
				if(get_property("questM23Meatsmith") == "unstarted") 
				{
					visit_url("shop.php?whichshop=meatsmith&action=talk");
					run_choice(1);
				}
				break;
			case $location[The Overgrown Lot]:
				if(get_property("questM24Doc") == "unstarted") 
				{
					visit_url("shop.php?whichshop=doc&action=talk");
					run_choice(1);
				}
				break;
			case $location[Madness Bakery]:
				if(get_property("questM25Armorer") == "unstarted") 
				{
					visit_url("shop.php?whichshop=armory&action=talk");
					run_choice(1);
				}
				break;
		}	

		use_familiar(chooseFamiliar());
		
		needs[$slot[back]] = $item[protonic accelerator pack];
		construct_free_outfit(needs);
		(!adv1(ghostLocation, -1, "skill Shadow Noodles; while hasskill Shoot Ghost; skill Shoot Ghost; if hasskill Trap Ghost; skill Trap Ghost; endif; endwhile;"));
		
	}
}

void BrickoPrime() 
{
	location ghostLocation = to_location(get_property("ghostLocation"));
	if (to_boolean(get_property("kingLiberated")) && ghostLocation == $location[none] && total_turns_played() > get_property("nextParanormalActivity").to_int() ) 
	{
		if (get_property("_brickoFights").to_int()<10) 
		{
			SaveSetup();
			set_auto_attack(1);
			
			use_familiar(chooseFamiliar());
			item[slot] needs;
			needs[$slot[back]] = $item[protonic accelerator pack];
			construct_free_outfit(needs);
			
			use( 1, $item[BRICKO Ooze] );
			location ghostLocation = to_location(get_property("ghostLocation"));
			if  ( ghostLocation == $location[none] )
				//cli_execute("/timer 51 Ghost!");
			//else	
				set_property("nextParanormalActivity", get_property("nextParanormalActivity").to_int() + 50);
			set_auto_attack(0);
		}
		
		else 
		{
			SaveSetup();
			equip($slot[back],$item[protonic accelerator pack]);
			(!adv1(my_location(),0,""));
			location ghostLocation = to_location(get_property("ghostLocation"));
			//if  ( ghostLocation != $location[none] )
				//cli_execute("/timer 51 Ghost!");
		}
	}
}

void voteMonster()
{
	if(get_property("_voteFreeFights") < 3 && (total_turns_played() % 11) == 1 && get_property("lastVoteMonsterTurn") < total_turns_played())
	{
		location guzzlrLocation = to_location(get_property("guzzlrQuestLocation"));
		item votedSticker = to_item("&quot;I Voted!&quot; sticker");
		location doctorLocation = to_location(get_property("doctorBagQuestLocation"));
		location ghostLocation = to_location(get_property("ghostLocation"));
	
		location target;
		string macro = 'skill saucegeyser;';

		item[slot] needs;
		needs[$slot[acc3]] = votedSticker;	
		SaveSetup();
	
		if (ghostLocation == $location[none] && total_turns_played() > get_property("nextParanormalActivity").to_int() )
		{
			needs[$slot[back]] = $item[protonic accelerator pack];
		}
		else if(doctorLocation != $location[none] && can_adventure(doctorLocation) && doctorLocation != $location[The Dire Warren])
		{
			target = doctorLocation;
		}
		else if(guzzlrLocation != $location[none] && can_adventure(guzzlrLocation))
		{
			target = guzzlrLocation;
		}
		else if(hasDinseyQuest())
		{
			if(parseDinseyQuest() == 'Social Justice Adventurer I')
			{
				target = $location[Pirates of the Garbage Barges];
			}
				
			else if(parseDinseyQuest() == 'Social Justice Adventurer II')
			{
				target = $location[Uncle Gator's Country Fun-Time Liquid Waste Sluice];
			}
				
			else if(parseDinseyQuest() == 'Whistling Zippity-Doo-Dah')
			{
				needs[$slot[hat]] = $item[Dinsey mascot mask];
				target = $location[The Toxic Teacups];
			}
			else if(parseDinseyQuest() == 'Teach a Man to Fish Trash')
			{
				needs[$slot[weapon]] = $item[trash net];
				target = $location[Pirates of the Garbage Barges];
			}	
		}
		else
		{
			if(my_location() != $location[none]
				&& my_location().environment != 'underwater'
				&& my_location().wanderers
			)
			{
				target = my_location();				
			}
			else
			{
				target = $location[The Haunted Kitchen];
			}

		}

		use_familiar(chooseFamiliar());
		construct_free_outfit(needs);
		print('Trying to fight vote monster in' + target.to_string());
		(!adv1(target, -1, macro));
		
		if(contains_text(visit_url(questlog),"<b>Kiosk</b>"))
		{
			visit_url(kiosk);
			run_choice( 3 );
			run_choice( 6 );
		}
	}
	
}

boolean SpookyravenAccess( location l ) {
	if ( !contains_text(l,"Haunted") || l == $location[The Haunted Sorority House] ) {
		abort("That is not a Spookyraven Location");
		return false;
	}
	else {
		switch(l) {
			case $location[The Haunted Pantry]:
			case $location[The Haunted Kitchen]:
			case $location[The Haunted Conservatory]:
				return true;
			case $location[The Haunted Library]:
				return item_amount($item[[7302]Spookyraven library key]) > 0;
			case $location[The Haunted Billiards Room]:
				return item_amount($item[Spookyraven billiards room key]) > 0;
			case $location[The Haunted Gallery]:
			case $location[The Haunted Bathroom]:
			case $location[The Haunted Bedroom]:
			case $location[The Haunted Ballroom]:
				return get_property("questM21Dance") != "unstarted";
			case $location[The Haunted Boiler Room]:
			case $location[The Haunted Laundry Room]:
			case $location[The Haunted Wine Cellar]:
				return !contains_text(get_property("questL11Manor"),"started");
			case $location[The Haunted Laboratory]:
			case $location[The Haunted Nursery]:
			case $location[The Haunted Storage Room]:
				return get_property("questM17Babies") != "unstarted";
		}
	}
	return false;
}

void LightsOut() {
	if ( total_turns_played() % 37 == 0 && get_property("lastLightsOutTurn") != total_turns_played() ) {
		location StephenRoom,ElizabethRoom,LightsOutLocation;
		ElizabethRoom = get_property("nextSpookyravenElizabethRoom").to_location();
		StephenRoom = get_property("nextSpookyravenStephenRoom").to_location();
		monster LightsOutMonster;
 
		if ( ElizabethRoom == $location[The Haunted Gallery] && SpookyravenAccess(ElizabethRoom)) {
			LightsOutLocation = ElizabethRoom;
			LightsOutMonster = $monster[ghost of Elizabeth Spookyraven];
		}
		else if ( StephenRoom == $location[The Haunted Laboratory] && SpookyravenAccess(StephenRoom)) {
			LightsOutLocation = StephenRoom;
			LightsOutMonster = $monster[Stephen Spookyraven];
		}
		else if ( StephenRoom != $location[none] && SpookyravenAccess(StephenRoom) )
			LightsOutLocation = StephenRoom;
		else if ( ElizabethRoom != $location[none] && SpookyravenAccess(ElizabethRoom) )
			LightsOutLocation = ElizabethRoom;
 
		if ( LightsOutLocation != $location[none] ) {
			print("Lights Out: "+total_turns_played(),"blue");
			SaveSetup();
			set_location(LightsOutLocation);
			if ( LightsOutMonster != $monster[none] ) {
				//ChooseFamiliar(LightsOutMonster);
				//ConstructOutfit("exp",false,false);
			}
			boolean dummy = adv1(LightsOutLocation, -1, "");
		}
	}
}

void digitizeMonster()
{
	if (get_counters("Digitize Monster", -50, 0) == "Digitize Monster")
	{
		familiar familiarChoice;
		location guzzlrLocation = to_location(get_property("guzzlrQuestLocation"));
		location doctorLocation = to_location(get_property("doctorBagQuestLocation"));
		location ghostLocation = to_location(get_property("ghostLocation"));
		if(monster_phylum(get_property('_sourceTerminalDigitizeMonster').to_monster()) == get_property('redSnapperPhylum').to_phylum())
			familiarChoice = $familiar[Red-Nosed Snapper];
		else
			familiarChoice = chooseFamiliar();

		SaveSetup();

		location target;
		string macro = 'skill saucegeyser;';

		item[slot] needs;

		if(guzzlrLocation != $location[none]  && can_adventure(guzzlrLocation))
		{
			
			if (ghostLocation == $location[none] && total_turns_played() > get_property("nextParanormalActivity").to_int() )
			{
				needs[$slot[back]] = $item[protonic accelerator pack];
			}
			target = guzzlrLocation;
		}
		else if(hasDinseyQuest())
		{
			if(parseDinseyQuest() == 'Social Justice Adventurer I')
			{
				target = $location[Pirates of the Garbage Barges];
			}
				
			else if(parseDinseyQuest() == 'Social Justice Adventurer II')
			{
				target = $location[Uncle Gator's Country Fun-Time Liquid Waste Sluice];
			}
				
			else if(parseDinseyQuest() == 'Whistling Zippity-Doo-Dah')
			{
				needs[$slot[hat]] = $item[Dinsey mascot mask];
				target = $location[The Toxic Teacups];
			}
			else if(parseDinseyQuest() == 'Teach a Man to Fish Trash')
			{
				needs[$slot[weapon]] = $item[trash net];
				target = $location[Pirates of the Garbage Barges];
			}		
		}
		else if(doctorLocation != $location[none] && can_adventure(doctorLocation) && doctorLocation != $location[The Dire Warren])
		{
			if (ghostLocation == $location[none] && total_turns_played() > get_property("nextParanormalActivity").to_int() )
			{
				needs[$slot[back]] = $item[protonic accelerator pack];
			}
			target = doctorLocation;
		}
		else 
		{
			if (ghostLocation == $location[none] && total_turns_played() > get_property("nextParanormalActivity").to_int() )
			{
				needs[$slot[back]] = $item[protonic accelerator pack];
			}

			if(my_location().wanderers && my_location() != $location[The Sunken Party Yacht])
			{
				target = my_location();
			}
			else
			{
				target = $location[The Haunted Kitchen];
			}
		}
		
		use_familiar(familiarChoice);
		construct_free_outfit(needs);
		(!adv1(target, -1, macro));

		if(contains_text(visit_url(questlog),"<b>Kiosk</b>"))
		{
			visit_url(kiosk);
			run_choice( 3 );
			run_choice( 6 );
		}
	}
}

int KramcoNumber() {
	int previous = to_int(get_property("_sausageFights"));
	return 5+previous*3+max(0,previous-5)**3;
}
 
boolean KramcoUp() {
	return total_turns_played()-to_int(get_property("_lastSausageMonsterTurn"))+1 >= KramcoNumber();
}

void kramco()
{
	if (KramcoUp())
	{
		location guzzlrLocation = to_location(get_property("guzzlrQuestLocation"));
		location doctorLocation = to_location(get_property("doctorBagQuestLocation"));
		location ghostLocation = to_location(get_property("ghostLocation"));
		location target;
		string macro = 'skill saucegeyser;';
		item[slot] needs;
		
		SaveSetup();
		
		needs[$slot[off-hand]] = $item[Kramco Sausage-o-Matic&trade;];
		
		if(doctorLocation != $location[none] && can_adventure(doctorLocation) && doctorLocation.wanderers)
		{
			target = doctorLocation;
		}
		else if(guzzlrLocation != $location[none]  && can_adventure(guzzlrLocation))
		{
			target = guzzlrLocation;
		}
		else if(hasDinseyQuest())
		{ 
			if(parseDinseyQuest() == 'Social Justice Adventurer I')
				target = $location[Pirates of the Garbage Barges];
			else if(parseDinseyQuest() == 'Social Justice Adventurer II')
				target = $location[Uncle Gator's Country Fun-Time Liquid Waste Sluice];
			else if(parseDinseyQuest() == 'Whistling Zippity-Doo-Dah')
			{
				needs[$slot[hat]] = $item[Dinsey mascot mask];
				target = $location[The Toxic Teacups];
			}
		}
		else
		{
			if(my_location().wanderers && my_location().environment != 'underwater')
			{
				target = my_location();
			}
			else
			{
				target = $location[The Haunted Kitchen];
			}
				
		}

		use_familiar(chooseFamiliar());
		construct_free_outfit(needs);
		(!adv1(target, -1, macro));

		if(contains_text(visit_url(questlog),"<b>Kiosk</b>"))
		{
			visit_url(kiosk);
			run_choice( 3 );
			run_choice( 6 );
		}
	}
}

void HandleChains() {
	while ( in_multi_fight() )
		run_combat();
	while ( choice_follows_fight() )
		run_choice(-1);
}

void RemoveCurrencies() {
    if ( can_interact() ) {
        foreach it in $items[hobo nickel,sand dollar] {
            if ( it == $item[hobo nickel] && get_property("choiceAdventure272").to_int() != 2 && my_location() == $location[Hobopolis Town Square] )
                retrieve_item(20,it);
            else if ( it == $item[hobo nickel] && $locations[Burnbarrel Blvd., Exposure Esplanade, The Heap, The Ancient Hobo Burial Ground, The Purple Light District] contains my_location()
                && get_counters("Semirare window end",0,60) == "Semirare window end" && get_counters("Semirare window begin",1,60) != "Semirare window begin" )
                retrieve_item(5,it);
            else if ( available_amount(it) <= 11 )
                retrieve_item(1,it);
            else if ( item_amount(it) > 0 )
                put_closet(item_amount(it),it);
        }
    }
    foreach it in $items[mer-kin hallpass,pulled green taffy]
        if (item_amount(it) > 0 )
            put_closet(item_amount(it),it);

}

void tatters()
{
	if(have_effect($effect[everything looks green]) == 0)
	 //&& get_property('banishedMonsters').contains_text('banshee librarian') &&  get_property('banishedMonsters').contains_text('writing desk')
	 
	{
		SaveSetup();

		cli_execute('autoattack tatterfarm; familiar xo skeleton;');
		equip($slot[back], $item[bat wings]);
		equip($slot[off-hand], $item[tiny black hole]);
		equip($slot[acc1], $item[spring shoes]);
		adv1($location[The Haunted Library], -1, "");
		set_auto_attack(0);

	}
}

void purple()
{
	if(have_effect($effect[everything looks purple]) == 0)
	{
		foreach m in $monsters[witchess knight, witchess bishop, sausage goblin]
		{
			if(c2t_megg_eggs()[m] > 0)
			{
				SaveSetup();
				cli_execute('autoattack BasicAscend;');
				equip($slot[off-hand],$item[roman candelabra]); 
				c2t_megg_fight(m);
				set_auto_attack(0); 
			}
		}
		
		
	}
}

void bullseye()
{
	if(have_effect($effect[everything looks red]) == 0)
	{
		location target;
		string macro = 'skill Darts: Aim for the Bullseye;';
		location guzzlrLocation = to_location(get_property("guzzlrQuestLocation"));
		location doctorLocation = to_location(get_property("doctorBagQuestLocation"));
		location ghostLocation = to_location(get_property("ghostLocation"));

		SaveSetup();
		cli_execute('autoattack 0');

		use_familiar(chooseFamiliar());
		item[slot] needs;
		needs[$slot[acc3]] = $item[Everfull Dart Holster];

		if (ghostLocation == $location[none] && total_turns_played() > get_property("nextParanormalActivity").to_int() )
		{
			needs[$slot[back]] = $item[protonic accelerator pack];
		}

		if(doctorLocation != $location[none] && can_adventure(doctorLocation) && doctorLocation.wanderers)
		{
			target = doctorLocation;
		}
		else if(guzzlrLocation != $location[none]  && can_adventure(guzzlrLocation))
		{
			target = guzzlrLocation;
		}
		else if(hasDinseyQuest())
		{
			if(parseDinseyQuest() == 'Social Justice Adventurer I')
			{
				target = $location[Pirates of the Garbage Barges];
			}
			else if(parseDinseyQuest() == 'Social Justice Adventurer II')
			{
				target = $location[Uncle Gator's Country Fun-Time Liquid Waste Sluice];
			}
			else if(parseDinseyQuest() == 'Whistling Zippity-Doo-Dah')
			{
				needs[$slot[hat]] = $item[Dinsey mascot mask];
				target = $location[The Toxic Teacups];
			}
			else if(parseDinseyQuest() == 'Teach a Man to Fish Trash')
			{
				needs[$slot[weapon]] = $item[trash net];
				target = $location[Pirates of the Garbage Barges];
			}

					
		}
		else if(my_location().wanderers)
		{
			target = my_location();
		}
		else
		{
			target = $location[The Haunted Kitchen];
		}

		use_familiar(chooseFamiliar());
		construct_free_outfit(needs);
		(!adv1(target, -1, macro));
		if(contains_text(visit_url(questlog),"<b>Kiosk</b>"))
		{
			visit_url(kiosk);
			
			run_choice( 3 );
			run_choice( 6 );
		}
	}
}

void main() 
{

	try {
		if ( can_interact() && my_inebriety() <= inebriety_limit() && my_familiar() != $familiar[stooper])
		{
			
			lightsOut(); //Handles the lights out Quest
			digitizeMonster(); //Picks up digitize wanderers in helpful zones. Will equip a protopack if the timing is just right, to save the brickofight.
			//Lubes the tube
			if(hasDinseyQuest())
			{
				if(parseDinseyQuest() == 'Super Luber' && get_property('dinseyRollercoasterNext').to_boolean())
				{
					equip($slot[acc3], $item[lube-shoes]);
					(!adv1($location[Barf Mountain]));
				}
			}
			voteMonster(); //Picks up free Vote wanderers in helpful zones. Will equip a protopack if the timing is just right, to save the brickofight.
			kramco();
			brickoPrime();
			bustGhost(); //Basically Bales function, but with though with similar outfit switching
			tatters();
			purple();
			bullseye();
			
		}
	} 
	finally 
	{ 
		HandleChains();
		RestoreSetup(); 
	}
}