boolean[monster] peridotManuallyDesiredMonsters()
{
	// manually specify some favoured monsters
	boolean[monster] desired_monsters;
	desired_monsters[$monster[lobsterfrogman]] = true;
	desired_monsters[$monster[black panther]] = true;
	desired_monsters[$monster[white lion]] = true;
	desired_monsters[$monster[monstrous boiler]] = true;
	desired_monsters[$monster[modern zmobie]] = true;
	desired_monsters[$monster[dairy goat]] = true;
	desired_monsters[$monster[writing desk]] = true;
	// Quest gremlins need IDs because there's multiple
	desired_monsters[$monster[547]] = true; // erudite gremlin (tool) 
	desired_monsters[$monster[549]] = true; // batwinged gremlin (tool)
	desired_monsters[$monster[551]] = true; // vegetable gremlin (tool)
	desired_monsters[$monster[553]] = true; // spider gremlin (tool)
    desired_monsters[$monster[Sloppy Seconds Sundae]] = true;
	return desired_monsters;
}

void peridotChoiceHandler(int choice, string page)
{

	monster popChoice;
	location loc = my_location();
	matcher mons = create_matcher("bandersnatch\" value=\"(\\d+)", page);
	monster[int] monOpts;
	int i = 0;
	int bestmon = 0;
	while(find(mons))
	{
		//record the possible monsters and identify the best one to target
		monOpts[i] = mons.group(1).to_int().to_monster();
		// Manual monster specifications
		if (peridotManuallyDesiredMonsters() contains monOpts[i])
		{
			bestmon = i;
			break; // if we've got a force desired monster, don't bother with the rankings any more
		}
		i += 1;
	}
	popChoice = monOpts[bestmon];
	if(popChoice.to_int() == 0) //still nothing found so just peace out
	{
		run_choice(2); //if no match is found, hit the exit choice
		return;
	}
	run_choice(1, "bandersnatch=" + popChoice.to_int());
	return;
}

boolean haveUsedPeridot(int loc)
{
	string[int] perilLocs = split_string(get_property("_perilLocations"),",");
	foreach i, str in perilLocs
	{
		if (loc == to_int(str))
		{
			return true;
		}
	}
	return false;
}

boolean haveUsedPeridot(location loc)
{
	return haveUsedPeridot(loc.to_int());
}

void mobiusChoiceHandler(int choice, string page)
{

	string[int] choices = available_choice_options();
	int[string] choiceMap;
	foreach idx, text in choices
	{
		choiceMap[text] = idx;
	}

	void mobiusChoice(string opt) {
			int num = choiceMap[opt];
			run_choice(num);
	}

	string pos;


	// we want to get +15 paradoxicity for more time cops and the 13-paradoxicity +item effect
	// in a single day, we'll hit the NC maybe 9 times
	// we can't guarantee we'll be able to use the effects, but the items are good
	// taking the long odds would be good if we can definitely remove the effect / handle the HP loss

	// first clock per day gives 3 adventures, second gives 2
	if (get_property("_clocksUsed").to_int() < 2) {
		pos = "Go back and set an alarm";
		if (choiceMap contains pos) 
        {
			mobiusChoice(pos);
			if(item_amount($item[clock]) > 0)
			{
				use(1, $item[clock]);
			}
			return;
		}
		// gives +15 myst, +30 MP: rarely useful but sets up the clock
		pos = "Go back and take a 20-year-long nap";
		if (choiceMap contains pos) {
			mobiusChoice(pos);
			return;
		}
	}

	// 100 turns of +5 fam xp is worth refreshing
	if (have_effect($effect[Lifted by your Bootstraps]) == 0) {
		pos = "Let yourself get lifted up by your bootstraps";
		if (choiceMap contains pos) {
			mobiusChoice(pos);
			return;
		}
	}

	if (my_paradoxicity() < 15) {
		// take paradox-increasing options without negative effects in approximate utility order
		// some would have been taken earlier, so taking them here implies they're less useful
		foreach str in $strings[
			Stop your arch-nemesis as a baby,
			Borrow meat from your future,
			Hey\, free gun!,
			Shoot yourself in the foot,
			Mind your own business,
			Lift yourself up by your bootstraps,
			Draw a goatee on yourself,
			Go for a nature walk,
			Steal a cupcake from young Susie,
			Plant some trees and harvest them in the future,
			Borrow a cup of sugar from yourself,
			Steal a club from the past,
			Go back and take a 20-year-long nap,
			Plant some seeds in the distant past,
			Go back and write a best-seller.,
			Defend yourself,
			Play Schroedinger's Prank on yourself,
			Peek in on your future,
			Give your past self investment tips,
		] {
			if (choiceMap contains str) {
				mobiusChoice(str);
				return;
			}
		}
	}

	// meat is normally useful
	pos = "Borrow meat from your future";
	if (choiceMap contains pos) {
		mobiusChoice(pos);
		return;
	}
	pos = "Repay yourself in the past";
	if (choiceMap contains pos) {
		mobiusChoice(pos);
		return;
	}

	run_choice(1);
	return;
}
