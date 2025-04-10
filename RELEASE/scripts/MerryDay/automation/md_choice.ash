script merryChoice.ash

 
void main ( int choiceID, string whichpage ) 
{
	switch (choiceID) 
    {
		case 788: /*Encounter: Life is like a Cherry of Bowls
					choice 1: Let's roll (stats)
					choice 6: Let's don't (skip adventure)*/
				run_choice(6);			
			return;

		case 780: /*Encounter: Action Elevator
					choice 1: Go to the Thrice-Cursed Penthouse (penthouse empty)
					choice 2: Go to the mezzanine (Increase Thrice-Cursed)
					choice 3: Go down to the parking garage (Relocate pygmy witch lawyers to Hidden Park)
					choice 6: Exit through the gift shop (skip adventure)*/
				run_choice(6);			
			return;
		case 886: /*Encounter: Chasin' Babies
					Unsupported choice adventure #886
					choice 1: Try the poppet
					choice 2: Try the rocking horse
					choice 3: Try the jack-in-the-box
					choice 6: Do nothing*/
				run_choice(6);			
			return;
		case 1062: /*Encounter: Lots of Options
					choice 2: Check out the shopping carts (acquire food)
					choice 3: Look through the cardboard boxes (acquire drinks)
					choice 4: Check out the spooky noises (gain moxie stats)
					choice 7: Let sleeping oysters lie*/
				run_choice(7);			
			return;
		case 1116: /* All They Got Inside is Vacancy (and Ice)
					3: Look for some <> (fill bucket by 10-15%)
					4: Raid the bar (acquire cocktailcrafting supplies)
					5: Raid some guest rooms (1/3, 3 wal-mart gift certificates)
					6: Leave*/
			if ( available_choice_options() contains 3 && get_property("walfordBucketProgress").to_int() < 91 )
				run_choice(3);
			else if ( available_choice_options() contains 5 )
				run_choice(5);
			else if ( available_choice_options() contains 4 )
				run_choice(4);
			else
				run_choice(6);			
			return;
		case 1119: /* Olive Backwards In Time (DMT)
					choice 1: A wiggling of tuneless shapes. (acquire some abstractions)
					choice 3: A pyramid that encloses. (acquire modern picture frame)
					6: Leave*/
				run_choice(6);			
			return;
		case 1236: /* 			Encounter: Space Cave
				Manual control requested for choice #1236
				choice 1: Gather some rock samples (acquire some alien rock samples)
				choice 6: Just leave (skip adventure)*/
				run_choice(6);			
			return;





		case 1340:	/* Is There A Doctor In The House?
					1: accept quest
					2: decline quest
					3: turn off phone for the day */
			location doctorLocation = get_property("doctorBagQuestLocation").to_location();
			if ( !doctorLocation.wanderers || doctorLocation.combat_percent < 99 || $locations[The Oasis, The Skeleton Store, Camp Logging Camp, The Obligatory Pirate's Cove] contains doctorLocation )
			{
				print("Declining doctor bag quest in "+doctorLocation,"blue");
				run_choice(2);
			}
			/*else if (my_path() == "Community Service" && $locations[Camp Logging Camp] contains doctorLocation)
			{
				print("Declining doctor bag quest in "+doctorLocation,"blue");
				run_choice(2);
			}*/
			else 
			{
				print("Accepting doctor bag quest in "+doctorLocation,"blue");
				run_choice(1);
			}
			return;
		case 1322:
			if (get_property("_questPartyFairQuest") == "food" || get_property("_questPartyFairQuest") == "booze"
			|| get_property("_questPartyFairQuest") == "trash"
			|| get_property("_questPartyFairQuest") == "woots"
			|| get_property("_questPartyFairQuest") == "partiers") 
			{
				run_choice(1); // Accept Quest
			} 
			else 
			{
				run_choice(2); // Decline Quest
			}
			return;
		case 1324:/*It Hasn't Ended, It's Just Paused
					1: Head upstairs
					2: Check out the kitchen
					3: Go to the backyard
					4: Investigate the basement
					5: fight
		*/
			if(get_property("_questPartyFairQuest") == "food")
			{
				run_choice(2);
				return;
			}
			if(get_property("_questPartyFairQuest") == "booze")
			{
				run_choice(3);
				return;
			}
			run_choice(5);
			return;
		case 1326:
			/* Gone Kitchin'
							1: Get myst substats
							2: 20 turns of Spiced Up (+20% mus exp gain)
							3: Talk to Geraldine [learn required food]
							4: Give Geraldine the snacks [complete food quest]
							5: Burn some trash (req gas can) [burn ~25% of remaining trash] */
					switch (get_property("_questPartyFairQuest")) {
						case "food":
							switch ( get_property("_questPartyFair") ) {
								case "started":
									run_choice(3);
									break;
								case "step2":
									run_choice(4);
									break;
							}
							break;
						case "trash":
							run_choice(5);
							break;
						default:
							abort("Why are you in the NEP kitchen?");					
					}
			return;
		case 1327:	/* Forward to the Back
							1: Get mox substats
							2: 50 turns of Citronella Armpits [+30 ML]
							3: Find Gerald [learn required booze]
							4: Give Gerald the booze [complete booze quest]
							5: Pour Purple Beast into the pool [clear out partiers] */
					switch (get_property("_questPartyFairQuest")) {
						case "booze":
							switch ( get_property("_questPartyFair") ) {
								case "started":
									run_choice(3);
									break;
								case "step2":
									run_choice(4);
									break;
							}
							break;
						case "partiers":
							run_choice(5);
							break;
						default:
							abort("Why are you in the NEP backyard?");	
					}
					break;
		case 1497: /* Calling Rufus
						1: fight the entity
						2: find the artifact
						3: collect the goods

					*/
					if(have_effect($effect[shadow affinity]) == 0 && !get_property('_shadowAffinityToday').to_boolean())
					{
						run_choice(2);
						return;
					}
					else 
					{
						run_choice(3);
						return;
					}
						
					
					
			break;
		case 1500:	/* <choice adventure name>
					1: The Forge
					2: Shadow Waters
					3: Loot Forest*/
					if(!get_property('_shadowForestLooted').to_boolean())
					{
						run_choice(3);
						return;
					}
					else
					{
						run_choice(2);
						return;
					}
		case 786:	/* Working Holiday
					choice 1: Knock on the boss's office door (office empty)
					choice 2: Raid the supply cabinet (Get random item)
					choice 3: Pick a fight with a cubicle drone (Fight pygmy witch accountant)
					choice 6: Take the day off (skip adventure)*/
					run_choice(6);
					break;
		case 918:	/* Yachtzee!
					1: Raid a minifridge (cocktail ingredients or Ultimate Mind Destroyer)
					2: Dig through the wreckage (5k meat)
					3: Give that guy some beads, for crying out loud (get Beach Bucks)*/
					run_choice(2);
					break;

		case 1352:	/* Island #1, Who Are You?
					choice 1: Crab Island
					choice 2: Glass Island
					choice 3: Battle Island
					choice 6: Dessert Island
					*/
					run_choice(1);
					break;
		case 1361:	/* Avast, a Mast!
					choice 1: Search the wreckage for plunder
					
					*/
					run_choice(1);
					break;
		case 1362:	/* Stormy Weather
					choice 1: Batten down the hatches
					choice 2: Try to gain some extra distance
					*/
					run_choice(2);
					break;
		case 1367:	/* The Ship is Wrecked
					choice 1: Fix it with glue
					choice 2: Wait for assistance
					*/
					run_choice(2);
					break;
		case 1355:	/* Land Ho
					choice 1: Head Inland
					*/
					run_choice(1);
					break;
		case 1353:	/* What's Behind Island #2
					choice 2: Isla Gublar
					choice 3: Cemetery Island
					choice 5: Trash Island
					*/
					run_choice(5);
					break;
		case 1354:	/* Encounter: Third Island's the Charm
					choice 1: Signal Island
					choice 2: Tiki Island
					choice 3: Storm Island
					choice 7: Decide Later
					*/
					run_choice(3);
					break;
		case 1356:	/* Encounter: Smooth Sailing
						choice 1: Have a snack
						choice 2: Have a cocktail
						choice 3: Do some birdwatching
					
					*/

					run_choice(3);
					break;	
		case 1357:	/* High Tide, Low Morale
					choice 2: Have a party
					choice 3: Give everybody bonus wages
					choice 4: Do a little dance for them
					
					*/
					run_choice(4);
					break;
		case 1358:	/* The Starboard is Bare
					choice 1: Catch some fish
					choice 2: Dive for bigger bounty
					
					*/
					if(contains_text(get_property('_pirateRealmCrewmate'),'luttonous'))
						run_choice(2);
					else
						run_choice(1);
					break;
		case 1359: /*
						Encounter: Grog for the Grogless
					choice 1: Ferment some seawater
					choice 2: Dive for sunken casks*/
					run_choice(1);
					break;
		case 1360:	/* Like Shops in the Night
					choice 1: Buy 5 food
					choice 2: Buy 5 booze
					choice 3: Buy 1 glue
					choice 4: Buy an additional cannon
					choice 6: Sail away
					
					*/
					int g = get_property('_pirateRealmGold').to_int();
					while(g > 20)
					{
						run_choice(1);
						run_choice(2);
						g = g - 20;
					}
					run_choice(6);
					break;
		case 1363:	/* Who Pirates the Pirates?
					choice 1: Fire the guns
					choice 2: Attempt to flee
					
					*/

					run_choice(2);
					break;
		case 1365:	/* A Sea Monster!
					choice 1: Fight it
choice 2: Flee it!
					
					*/

					run_choice(2);
					break;							
		case 1364:	/* An  Opportunity for Dastardly Do
					choice 1: Attack them
					choice 2: Leave them alone
					
					*/

					run_choice(2);
					break;
		case 1368:	/* Encounter: All-You-Can-Fight Crab
					Unsupported choice adventure #1368
					choice 1: Fight the giant giant crab
					
					*/

					run_choice(1);
					break;
		case 1376:	/* 	Encounter: Your Empire of Dirt
					Unsupported choice adventure #1376
					choice 1: Dig through the refuse
					*/

					run_choice(1);
					break;

		case 1384:	/* Encounter: The Calm After the Storm
					choice 1: Investigate the equipment
					
					*/

					run_choice(1);
					break;	

/*June Cleaver Encounters*/
		case 1467:	/* Encounter: Poetic Justice
					choice 1: Hand in the poem your brother wrote (Moxie substats)
					choice 2: Admit that you didn't write anything (Mysticality substats)
					choice 3: Fake an injury on the playground (Gain 5 adventures, get beaten up)
					choice 4: Snap out of it! (Do nothing)
					*/
					run_choice(3);
					break;	
		case 1468:	/* Encounter: Aunts not Ants
					Manual control requested for choice #1468
					choice 1: Act rudely so they leave! (Moxie substats)
					choice 2: Be on your best behavior so you can go later. (Muscle substats)
					choice 3: Sneak out the back door. (get Ashamed)
					choice 4: Snap out of it! (Do nothing)
					*/
					if(get_property('_juneCleaverSkips').to_int() < 5)
						run_choice(4);
					else
						run_choice(2);
					break;		
		case 1469:	/* Encounter: Delicious Sprouts
					Encounter: Beware of Aligator
					choice 1: Come clean to Dad and let him take it to the zoo. (get Yapping Pal)
					choice 2: Claim the housekeeper is drunk. (Dad's brandy)
					choice 3: Ignore the situation and charge your friends admission to see the alligator. (1500 meat)
					
					*/
					if(get_property('_juneCleaverSkips').to_int() < 5)
						run_choice(4);
					else
						run_choice(3);
					break;
		case 1470:	/* Encounter: Teacher's Pet
					choice 1: Ignore the situation. (30 turns of Teacher's Pet)
					choice 2: Confess your love to Miss Teacher! (teacher's pen)
					choice 3: Prank the teacher and get your friends off your case. (Muscle substats)
					choice 4: Snap out of it! (Do nothing)					
					*/
					if(get_property('_juneCleaverSkips').to_int() < 5)
						run_choice(4);
					else
						run_choice(2);
					break;
		case 1471:	/* Encounter: Lost and Found
					choice 1: Cash in that savings bond from your Aunt! (savings bond)
					choice 2: Challenge Lumpy's accusation. (Muscle substats, 250 meat, get beaten up)
					choice 3: Tell Father what happened. (Mysticality substats)
					choice 4: Snap out of it! (Do nothing)				
					*/
					if(get_property('_juneCleaverSkips').to_int() < 5)
						run_choice(4);
					else
						run_choice(1);
					break;


		case 1472:	/* Encounter: Summer Days
					choice 1: Sneak away and watch the movie at the nearby drive-in. (trampled ticket stub)
					choice 2: Suck it up and go fishing. (fire-roasted lake trout)
					choice 3: Make a cool fort on the small island in the lake. (Moxie substats)
					choice 4: Snap out of it! (Do nothing)				
					*/
					if(get_property('_juneCleaverSkips').to_int() < 5)
						run_choice(4);
					else
						run_choice(1);
					break;
		case 1473:	/* Encounter: Bath Time

					choice 1: Use Mother's hair dryer and towels to dry things up. (Muscle substats, gob of wet hair)
					choice 2: Confess to Mother and Father. (get Wholesomely Resolved)
					choice 3: Pretend you don't notice. (get Kinda Damp)
					choice 4: Snap out of it! (Do nothing)*/
					if(get_property('_juneCleaverSkips').to_int() < 5)
						run_choice(4);
					else
						run_choice(1);
					break;					

		case 1474:	/* Encounter: Delicious Sprouts
					Choice option 1474/4 is not available.
					choice 1: Just eat 'em. (Mysticality substats)
					choice 2: Hide them in your napkin. (guilty sprout)
					choice 3: Go to your room. (Muscle substats)		
					
					*/
					if(get_property('_juneCleaverSkips').to_int() < 5)
						run_choice(4);
					else
						run_choice(2);
					break;

		case 919:	/* Encounter: Break Time!
					choice 1: Plunder the cash register (get Beach Bucks)
					choice 2: Turn up the freezer (+15ML on Sundaes)
					choice 3: Turn up the stoves (+15ML on Burgers)
					choice 4: Turn up the booze hose pressure (+15ML on Cocktails)
					choice 5: Cut the power (reset ML on monsters)
					choice 6: Cut and run (leave without using a turn)		
					
					*/
					run_choice(6);
					break;

											
		case -1:	/* <choice adventure name>
					1: 
					2: */
			abort("How did you get to choice -1? Did you fall through the case in md_choice.ash");
			return;
	}
}