script merryChoice.ash

 
void main ( int choiceID, string whichpage ) {
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
			if ( !doctorLocation.wanderers || doctorLocation.combat_percent < 99 || $locations[The Oasis, The Skeleton Store, Camp Logging Camp, Obligatory Pirate Cove] contains doctorLocation )
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
			if(get_property("_questPartyFairQuest") == "food" && get_property("_questPartyFairProgress") == "")
				run_choice(2);
			if(get_property("_questPartyFairQuest") == "booze" && get_property("_questPartyFairProgress") == "")
				run_choice(3);
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
		case -1:	/* <choice adventure name>
					1: 
					2: */
			abort("How did you get to choice -1? Did you fall through the case in choiceAdventure.ash");
			return;
	}
}