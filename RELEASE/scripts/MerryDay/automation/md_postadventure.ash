import c2t_megg.ash;

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


location get_property_loc( string property ) {
	if ( !property_exists(property) )
		abort("Couldn't find preference "+property);
	return to_location(get_property(property));
}

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

familiar ChooseFamiliar()
{
    foreach f in $familiars[Li'l Xenomorph, Baby Sandworm, Rogue Program,  Astral Badger, Green Pixie, Llama lama, Blavious Kloop, Fist Turkey]
			if ( have_familiar(f) && f.drops_today < 1 )
				return f;
    foreach f in $familiars[Li'l Xenomorph, Baby Sandworm, Rogue Program,  Astral Badger, Green Pixie, Llama lama, Blavious Kloop, Fist Turkey]
			if ( have_familiar(f) && f.drops_today < 2 )
				return f;
    foreach f in $familiars[Li'l Xenomorph, Baby Sandworm, Rogue Program,  Astral Badger, Green Pixie, Llama lama, Blavious Kloop, Fist Turkey]
			if ( have_familiar(f) && f.drops_today < 3 )
				return f;
    foreach f in $familiars[Li'l Xenomorph, Baby Sandworm, Rogue Program,  Astral Badger, Green Pixie, Llama lama, Blavious Kloop, Fist Turkey]
			if ( have_familiar(f) && f.drops_today < 4 )
				return f;
    foreach f in $familiars[Li'l Xenomorph, Baby Sandworm, Rogue Program,  Astral Badger, Green Pixie, Llama lama, Blavious Kloop, Fist Turkey]
			if ( have_familiar(f) && f.drops_today < 5 )
				return f;
    return $familiar[reagnimated gnome];
}

void SaveSetup() {
	if (!SetupSaved) {
		print("Saving setup ...", "green");
		fam = my_familiar();
		throne = my_enthroned_familiar();
		bjorn = my_bjorned_familiar();
		fameq = familiar_equipped_equipment(fam);
		foreach eqSlot in $slots[]
			equipment[eqSlot] = equipped_item(eqSlot);
		aa = get_auto_attack();
        beforeAdventureScript = get_property("betweenBattleScript");
        set_property("betweenBattleScript", "");
		afterAdventureScript = get_property("afterAdventureScript"); 
		set_property("afterAdventureScript", ""); //Note Awkward workaround: required to stop nested calls of the after Adventure script (as would otherwise happen after any of the adv1() calls in the script). The nesting messes up the restoration of the setup
		SetupSaved = TRUE; //To prevent overriding the first saved setup, in case multiple of the functions in the script get called in succession (like picking a bricko fight and then busting a ghost). 
//Specifically done at the end, because Restoring a partial setup can get kinda messy (folder holder slots are in $slots[], as I found out the hard way after wondering for a while why my folder holder would randomly be empty every once in a while).
	}
}

void RestoreSetup() {
	if (SetupSaved) {
		set_property("afterAdventureScript", afterAdventureScript);
        set_property("betweenBattleScript", beforeAdventureScript);
		if (aa != get_auto_attack())
        {   
            print("Trying to set autoattack to ... ", "green");
            print(aa, "purple");
            if(aa == '99188633')
                cli_execute('autoattack BasicAscend');
            else
                set_auto_attack(aa);
        }
			
		if(fam != my_familiar()) 
		{
			use_familiar(fam);
			equip(fameq);
		}
			
		foreach eqSlot in $slots[]
		{
			if (equipped_item(eqSlot) != equipment[eqSlot])
				equip(eqSlot, equipment[eqSlot]);
		}
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
	buffer stun() {
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
	if(my_inebriety() <= inebriety_limit() && to_boolean(get_property("kingLiberated")) && ghostLocation != $location[none]) { # && my_location() != ghostLocation) {
		// If last adventure was getting beaten up, then ABORT! (Last adventure might have been losing to this ghost.)
		if(run_combat().contains_text("<p>You lose.  You slink away"))
			abort("Whoa! Not doing well here! Fight this ghost manually!");
		
		switch(ghostLocation) {
		case $location[Inside the Palindome]:
			acc3 = equipped_item($slot[acc3]);
			equip($slot[acc3], $item[Talisman o' Namsilat]);//'
			break;
		case $location[The Skeleton Store]:
			if(get_property("questM23Meatsmith") == "unstarted") {
				visit_url("shop.php?whichshop=meatsmith&action=talk");
				run_choice(1);
			}
			break;
		case $location[The Overgrown Lot]:
			if(get_property("questM24Doc") == "unstarted") {
				visit_url("shop.php?whichshop=doc&action=talk");
				run_choice(1);
			}
			break;
		case $location[Madness Bakery]:
			if(get_property("questM25Armorer") == "unstarted") {
				visit_url("shop.php?whichshop=armory&action=talk");
				run_choice(1);
			}
			break;
		}	
		item back;
		if(!have_equipped($item[protonic accelerator pack])) {
			back = equipped_item($slot[back]);
			equip($item[protonic accelerator pack]);
		}
		fam = my_familiar();
		use_familiar(chooseFamiliar());
		//equip($item[dromedary drinking helmet]);
		(!adv1(ghostLocation, -1, "skill Shadow Noodles; while hasskill Shoot Ghost; skill Shoot Ghost; if hasskill Trap Ghost; skill Trap Ghost; endif; endwhile;"));
		// Trapped error condition in case I''m adventuring with goals
		
	}
}




void BrickoPrime() 
{
	location ghostLocation = to_location(get_property("ghostLocation"));
	if (to_boolean(get_property("kingLiberated")) && ghostLocation == $location[none] && total_turns_played() > get_property("nextParanormalActivity").to_int() ) 
	{
		if (get_property("_brickoFights").to_int()<10) {
			SaveSetup();
			set_auto_attack(1);
			outfit("birthday suit");
			//if (chooseFamiliar() != my_familiar()) use_familiar(chooseFamiliar());
			use_familiar(chooseFamiliar());
			cli_execute("/outfit Free Drops");	
			equip($slot[back],$item[protonic accelerator pack]);
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
		if (ghostLocation == $location[none] && total_turns_played() > get_property("nextParanormalActivity").to_int() )
		{
			equip($slot[back],$item[protonic accelerator pack]);
		}
		if(doctorLocation != $location[none] && can_adventure(doctorLocation) && doctorLocation != $location[The Dire Warren])
		{
			SaveSetup();
			
			cli_execute("/outfit Free Drops");

			equip($slot[acc3], votedSticker);
			use_familiar(chooseFamiliar());
			(!adv1(doctorLocation, -1, "skill saucegeyser;"));

		}
		else if(guzzlrLocation != $location[none] && can_adventure(guzzlrLocation))
		{
			SaveSetup();
			cli_execute("/outfit Free Drops");
			
			equip($slot[acc3], votedSticker);
			use_familiar(chooseFamiliar());
			(!adv1(guzzlrLocation, -1, "skill saucegeyser;"));
		}
		else if(hasDinseyQuest())
		{
			SaveSetup();
			equip($slot[acc1], votedSticker);
			if(parseDinseyQuest() == 'Social Justice Adventurer I')
				(!adv1($location[Pirates of the Garbage Barges]));
			if(parseDinseyQuest() == 'Social Justice Adventurer II')
				(!adv1($location[Uncle Gator's Country Fun-Time Liquid Waste Sluice])); //'
			else if(parseDinseyQuest() == 'Whistling Zippity-Doo-Dah')
			{
				equip($item[Dinsey mascot mask]);
				(!adv1($location[The Toxic Teacups]));
			}
			else if(parseDinseyQuest() == 'Teach a Man to Fish Trash')
			{
				equip($item[trash net]);
				(!adv1($location[Pirates of the Garbage Barges]));
			}
			if(contains_text(visit_url(questlog),"<b>Kiosk</b>"))
			{
				visit_url(kiosk);
				run_choice( 3 );
				run_choice( 6 );
				equip($slot[acc3], votedSticker);
				use_familiar(chooseFamiliar());
				(!adv1(my_location(), -1, "skill saucegeyser;"));
			}
				
		}
		else
		{
			SaveSetup();
			equip($slot[acc3], votedSticker);
			use_familiar(chooseFamiliar());
			(!adv1(my_location(), -1, "skill saucegeyser;"));
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
		ElizabethRoom = get_property_loc("nextSpookyravenElizabethRoom");
		StephenRoom = get_property_loc("nextSpookyravenStephenRoom");
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
		if(monster_phylum(get_property('_sourceTerminalDigitizeMonster').to_monster()) == $phylum[horror] && get_property('redSnapperPhylum') == 'horror')
			familiarChoice = $familiar[Red-Nosed Snapper];
		else if (get_property('_sourceTerminalDigitizeMonster').to_monster() == $monster[knob goblin embezzler])
			familiarChoice = $familiar[hobo monkey];
		else
			familiarChoice = chooseFamiliar();
		
		if(guzzlrLocation != $location[none]  && can_adventure(guzzlrLocation))
		{
			SaveSetup();
			if (get_property('_sourceTerminalDigitizeMonster').to_monster() == $monster[knob goblin embezzler])
				maximize('meat, equip mafia pointer ring', false);
			else
				cli_execute("/outfit Free Drops");
			if (ghostLocation == $location[none] && total_turns_played() > get_property("nextParanormalActivity").to_int() )
			{
				equip($slot[back],$item[protonic accelerator pack]);

			}
			use_familiar(familiarChoice);
			(!adv1(guzzlrLocation, -1, "skill saucestorm;"));
		}
		else if(hasDinseyQuest())
		{
			SaveSetup();
			if (get_property('_sourceTerminalDigitizeMonster').to_monster() == $monster[knob goblin embezzler])
				maximize('meat, equip mafia pointer ring', false);
			else
				cli_execute("/outfit Free Drops");
			
			use_familiar(familiarChoice);
			if(parseDinseyQuest() == 'Social Justice Adventurer I')
				(!adv1($location[Pirates of the Garbage Barges]));
			if(parseDinseyQuest() == 'Social Justice Adventurer II')
				(!adv1($location[Uncle Gator's Country Fun-Time Liquid Waste Sluice])); //'
			else if(parseDinseyQuest() == 'Whistling Zippity-Doo-Dah')
			{
				equip($item[Dinsey mascot mask]);
				(!adv1($location[The Toxic Teacups]));
			}
			else if(parseDinseyQuest() == 'Teach a Man to Fish Trash')
			{
				equip($item[trash net]);
				(!adv1($location[Pirates of the Garbage Barges]));
			}
			if(contains_text(visit_url(questlog),"<b>Kiosk</b>"))
			{
				visit_url(kiosk);
				run_choice( 3 );
				run_choice( 6 );
				if (get_property('_sourceTerminalDigitizeMonster').to_monster() == $monster[knob goblin embezzler])
					maximize('meat, equip mafia pointer ring, equip mafia thumb ring, equip lucky gold ring', false);
				else
					cli_execute("/outfit Free Drops");
				if (ghostLocation == $location[none] && total_turns_played() > get_property("nextParanormalActivity").to_int() )
				{
					equip($slot[back],$item[protonic accelerator pack]);
				}
				use_familiar(familiarChoice);
				if(my_location().wanderers)
				{
					(!adv1(my_location(), -1, "skill saucegeyser;"));
				}
				else
				{
					(!adv1($location[The Haunted Kitchen], -1, "skill saucegeyser;"));
				}
			}
				
		}
		else if(doctorLocation != $location[none] && can_adventure(doctorLocation) && doctorLocation != $location[The Dire Warren])
		{
			SaveSetup();
			if (get_property('_sourceTerminalDigitizeMonster').to_monster() == $monster[knob goblin embezzler])
				maximize('meat, equip mafia pointer ring', false);
			else
				cli_execute("/outfit Free Drops");
			if (ghostLocation == $location[none] && total_turns_played() > get_property("nextParanormalActivity").to_int() )
			{
				equip($slot[back],$item[protonic accelerator pack]);
			}
			use_familiar(familiarChoice);
			(!adv1(doctorLocation, -1, "skill saucestorm;"));
		}
		else 
		{
			SaveSetup();
			if (get_property('_sourceTerminalDigitizeMonster').to_monster() == $monster[knob goblin embezzler])
				maximize('meat, equip mafia pointer ring, equip mafia thumb ring, equip lucky gold ring', false);
			else
				cli_execute("/outfit Free Drops");
			if (ghostLocation == $location[none] && total_turns_played() > get_property("nextParanormalActivity").to_int() )
			{
				equip($slot[back],$item[protonic accelerator pack]);
			}
			use_familiar(familiarChoice);
			if(my_location().wanderers)
			{
				(!adv1(my_location(), -1, "skill saucegeyser;"));
			}
			else
			{
				(!adv1($location[The Haunted Kitchen], -1, "skill saucegeyser;"));
			}
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
		if(doctorLocation != $location[none] && can_adventure(doctorLocation) && doctorLocation.wanderers)
		{
			SaveSetup();
			if (ghostLocation == $location[none] && total_turns_played() > get_property("nextParanormalActivity").to_int() )
			{
				equip($slot[back],$item[protonic accelerator pack]);
			}
			equip($item[Fourth of May Cosplay Saber]);
			equip($slot[off-hand],$item[Kramco Sausage-o-Matic&trade;]); 
			use_familiar(chooseFamiliar());
			(!adv1(doctorLocation, -1, "skill saucegeyser;"));

		}
		else if(guzzlrLocation != $location[none]  && can_adventure(guzzlrLocation))
		{
			SaveSetup();
			location ghostLocation = to_location(get_property("ghostLocation"));
			cli_execute("/outfit Free Drops");
			if (ghostLocation == $location[none] && total_turns_played() > get_property("nextParanormalActivity").to_int() )
			{
				equip($slot[back],$item[protonic accelerator pack]);
			}
			equip($item[Fourth of May Cosplay Saber]);
			equip($slot[off-hand],$item[Kramco Sausage-o-Matic&trade;]); 
			use_familiar(chooseFamiliar());
			(!adv1(guzzlrLocation, -1, "skill saucegeyser;"));
		}
		else if(hasDinseyQuest())
		{
			SaveSetup();
			cli_execute("/outfit Free Drops");
			if (ghostLocation == $location[none] && total_turns_played() > get_property("nextParanormalActivity").to_int() )
			{
				equip($slot[back],$item[protonic accelerator pack]);
			}
			equip($item[Fourth of May Cosplay Saber]);
			equip($slot[off-hand],$item[Kramco Sausage-o-Matic&trade;]); 
			
			if(parseDinseyQuest() == 'Social Justice Adventurer I')
				(!adv1($location[Pirates of the Garbage Barges]));
			if(parseDinseyQuest() == 'Social Justice Adventurer II')
				(!adv1($location[Uncle Gator's Country Fun-Time Liquid Waste Sluice])); //'
			else if(parseDinseyQuest() == 'Whistling Zippity-Doo-Dah')
			{
				equip($item[Dinsey mascot mask]);
				(!adv1($location[The Toxic Teacups]));
			}
			else
			{
				(!adv1($location[The Toxic Teacups]));
			}
			if(contains_text(visit_url(questlog),"<b>Kiosk</b>"))
			{
				visit_url(kiosk);
				
				run_choice( 3 );
				run_choice( 6 );

				equip($item[Fourth of May Cosplay Saber]);
				equip($slot[off-hand],$item[Kramco Sausage-o-Matic&trade;]);
				if(my_location().wanderers)
				{
					(!adv1(my_location(), -1, "skill saucegeyser;"));
				}
				else
				{
					(!adv1($location[The Haunted Kitchen], -1, "skill saucegeyser;"));
				}
			}
				
		}
		else
		{
			SaveSetup();
			equip($item[Fourth of May Cosplay Saber]);
			equip($slot[off-hand],$item[Kramco Sausage-o-Matic&trade;]);
			if(my_location().wanderers)
			{
				(!adv1(my_location(), -1, "skill saucegeyser;"));
			}
			else
			{
				(!adv1($location[The Haunted Kitchen], -1, "skill saucegeyser;"));
			}
				
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
	if(have_effect($effect[everything looks green]) == 0 && get_property('banishedMonsters').contains_text('banshee librarian') &&  get_property('banishedMonsters').contains_text('writing desk'))
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

void main() {

	try {
		if ( can_interact() && my_inebriety() <= inebriety_limit() && my_familiar() != $familiar[stooper])
		{
			lightsOut(); //Handles the lights out Quest
			kramco();
			digitizeMonster(); //Picks up digitize wanderers in helpful zones. Will equip a protopack if the timing is just right, to save the brickofight.
			voteMonster(); //Picks up free Vote wanderers in helpful zones. Will equip a protopack if the timing is just right, to save the brickofight.
			brickoPrime();
			bustGhost(); //Basically Bales function, but with though with similar outfit switching
tatters();
purple();
		}
	} 
	finally { 
		HandleChains();
		RestoreSetup(); 
}
}