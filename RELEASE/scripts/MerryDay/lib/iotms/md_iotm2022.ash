string[int] autobotCurrentUpgrades()
{
    return split_string(get_property('autumnatonUpgrades'), ',');
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
    return 11 * max(1, get_property("_autumnatonQuests").to_int() - autobotLegs());
}

/*
Cargo Cultist Shorts

const bellPockets = [
	['Sizzling desk bell', 'YR source', 517, '/images/adventureimages/ccs_daughter.gif'],
	['Uncanny desk bell', '3 eldritch effluvium', 590, '/images/adventureimages/ccs_tentacle.gif'],
	['Nasty desk bell', 'Goat cheese, milk', 653, '/images/adventureimages/ccs_disciple.gif'],
	['Greasy desk bell', 'Star chart, 2 stars/lines', 533, '/images/adventureimages/ccs_astrologer.gif'],
];

const chessPockets = [
	['Onyx pawn', '', 105, '/images/itemimages/chess7.gif'],
	['Onyx knight', '', 4, '/images/itemimages/chess12.gif'],
	['Onyx bishop', '', 537, '/images/itemimages/chess8.gif'],
	['Onyx rook', '', 197, '/images/itemimages/chess9.gif'],
	['Onyx queen', '', 506, '/images/itemimages/chess11.gif'],
	['Onyx king', '', 88, '/images/itemimages/chess10.gif'],
	['Alabaster pawn', '', 46, '/images/itemimages/chess1.gif'],
	['Alabaster knight', '', 275, '/images/itemimages/chess6.gif'],
	['Alabaster bishop', '', 567, '/images/itemimages/chess2.gif'],
	['Alabaster rook', '', 111, '/images/itemimages/chess3.gif'],
	['Alabaster queen', '', 651, '/images/itemimages/chess5.gif'],
	['Alabaster king', '', 523, '/images/itemimages/chess4.gif'],
];

const yegPockets = [
	['Alarm clock', 'Stats potion', 121, '/images/itemimages/yeg_clock.gif'],
	['Ashtray', 'Combat item', 409, '/images/itemimages/yeg_ashtray.gif'],
	['Disposable razor', 'Combat item', 322, '/images/itemimages/yeg_razor.gif'],
	['Hand soap', 'Spell dmg potion', 177, '/images/itemimages/yeg_soap.gif'],
	['Minibar key', 'Random booze', 660, '/images/itemimages/yeg_key.gif'],
	['Mouthwash', 'Spooky potion', 26, '/images/itemimages/yeg_mouthwash.gif'],
	['Pillow mint', 'Food', 439, '/images/itemimages/yeg_mint.gif'],
	['Sewing kit', 'Full HP restore', 642, '/images/itemimages/yeg_sewingkit.gif'],
	['Stationery', 'Hearty messages', 130, '/images/itemimages/yeg_stationery.gif'],
	['Toothbrush', 'Weapon dmg potion', 284, '/images/itemimages/yeg_toothbrush.gif'],
];

const aftercoreItemPockets = [
	['Cursed piece of thirteen', 'Meat or fight scary pirate', 600, '/images/itemimages/pieceof13.gif'],
	['Candy crayons', 'Increased stat from food', 87, '/images/itemimages/candycrayons.gif'],
	['Dubious peppermint', 'Makes numberwang', 627, '/images/itemimages/candy.gif'],
	['Worst candy', '+10% combat', 548, '/images/itemimages/confused.gif'],
	['Handful of honey', 'Makes honey gear', 28, '/images/itemimages/honeyglob.gif'],
	['Chocolate seal-clubbing club', '+adv for Seal Clubbers', 381, '/images/itemimages/choc1.gif'],
	['Chocolate turtle totem', '+adv for Turtle Tamers', 477, '/images/itemimages/choc2.gif'],
	['Chocolate pasta spoon', '+adv for Pastamancers', 654, '/images/itemimages/choc3.gif'],
	['Chocolate saucepan', '+adv for Saucerors', 438, '/images/itemimages/choc4.gif'],
	['Chocolate disco ball', '+adv for Disco Bandits', 430, '/images/itemimages/choc5.gif'],
	['Chocolate stolen accordion', '+adv for Accordion Thieves', 189, '/images/itemimages/choc6.gif'],
];

*/

string[int] cargoPockets;
