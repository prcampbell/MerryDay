string[int] autobotCurrentUpgrades()
{
    return split_string(get_property('autumnatonUpgrades', ','));
}

int autobotTurnsLeft()
{
    return get_property("autumnatonQuestTurn").to_int() - total_turns_played();
}

boolean autobotCheckForUpgrade(string upgrade)
{
	string currentUpgrades = get_property("autumnatonUpgrades");
	if(contains_text(currentUpgrades,upgrade))
	{
		return true;
	}
	return false;
}

int autobotLegs()
{
    return autobotCheckForUpgrade("leftleg1").to_int() + autobotCheckForUpgrade("rightleg1").to_int();
}

int autobotTurnsForQuest()
{
    return 11 * max(1, get("_autumnatonQuests") - autobotLegs());
}

