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