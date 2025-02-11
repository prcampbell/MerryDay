script merryChoice.ash

 
void main ( int choiceID, string whichpage ) 
{
	switch (choiceID) 
    {
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
					if(item_amount(get_property('rufusDesiredItems').to_item()) > 3)
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
		case -1:	/* <choice adventure name>
					1: 
					2: */
			abort("How did you get to choice -1? Did you fall through the case in md_choice.ash");
			return;
	}
}