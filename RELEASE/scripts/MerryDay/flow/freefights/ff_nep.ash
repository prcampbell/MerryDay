script "ff_nep.ash"

import md_outfit;

//TODO: Finish the quest for free if we can.

boolean nep_have() 
{
	return get_property("neverendingPartyAlways").to_boolean() || get_property("_neverendingPartyToday").to_boolean();
}

int nep_free_turns() 
{
	return get_property("_neverendingPartyFreeTurns").to_int();
}

boolean nep_done()
{
	return get_property("_questPartyFair") == "finished";
}

boolean nep_free_turn_can() 
{
	return nep_have() && nep_free_turns() < 10 && !nep_done();
}

boolean nep_free_turn_run() 
{
	int turns = nep_free_turns();
	if((get_property("_questPartyFairQuest") == "food" || get_property("_questPartyFairQuest") == "booze") 
		&& turns = 9 && !get_property('_claraBellUsed').to_boolean())
	{
		print("Preparing to complete Neverending Party for free", "purple");
		item item_wanted = $item[none];
		int item_wanted_amount = 0;
		string [int] progress_property_text_split = get_property("_questPartyFairProgress").split_string(" ");
		if (progress_property_text_split.count() == 2 && progress_property_text_split[0].to_int() == 10)
		{
			item_wanted_amount = progress_property_text_split[0].to_int();
			item_wanted = progress_property_text_split[1].to_item();
			if (item_wanted != $item[none])
				print("Want " + item_wanted_amount + " of " + item_wanted + " (from mafia tracking)");
		}
		/*if (item_wanted == $item[none])
		{
			//Parse the one we want:
			string [int][int] matches;
			if (active_quest == QUEST_TYPE_GERALD)
			{
				matches = partial_match.group_string("Get ([0-9]+) (.*?) for Gerald at the");
			}
			else
			{
				matches = partial_match.group_string("Get ([0-9]+) (.*?) for Geraldine at the");
			}
			if (matches.count() == 0)
				matches = partial_match.group_string("Take the ([0-9]+) (.*?) to Geraldine in the kitchen");
			int amount_wanted = matches[0][1].to_int();
			string plural_wanted = matches[0][2];
			item_wanted_amount = amount_wanted;
			//Convert plural back:
			foreach it in $items[]
			{
				if (it.plural == plural_wanted)
				{
					item_wanted = it;
					break;
				}
			}
			print("Want " + item_wanted_amount + " of " + item_wanted + " (assumed match against plural \"" + plural_wanted + "\")");
		}*/
		if (item_wanted == $item[none])
		{
			abort("Error: cannot recognise item the quest wants.", "red");
		}


		use(1, $item[clara's bell]);
		adv1($location[The Neverending Party], -1, "");
		return nep_free_turns() > turns;
	}

	print("Preparing to spend Neverending Party free turn #" + (turns + 1) +".", "purple");
	if(available_amount(get_property('')))
	adv1($location[The Neverending Party], -1, "");
	return nep_free_turns() > turns;
}

void main()
{
    set_auto_attack('StasisFight');
    construct_free_outfit();
    equip($slot[off-hand], $item[Kramco Sausage-o-Matic&trade;]);
    
	while(nep_free_turn_can())
		nep_free_turn_run();
    set_auto_attack(0);
}