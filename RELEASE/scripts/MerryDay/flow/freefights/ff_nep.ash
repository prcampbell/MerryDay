script "ff_nep.ash"

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
	return nep_have() && nep_free_turns() < 9 && !nep_done();
}

boolean nep_free_turn_run() {
	int turns = nep_free_turns();
	print("Preparing to spend Neverending Party free turn #" + (turns + 1) +".", "purple");
	adv1($location[The Neverending Party], -1, "");
	return nep_free_turns() > turns;
}

void main()
{
    set_auto_attack('StasisFight');
    equip($slot[hat], $item[daylight shavings helmet]);
    equip($slot[back], $item[buddy bjorn]);
    //bjornify_familiar(get_best_bjorn());
    equip($slot[shirt], $item[jurassic parka]);
    equip($slot[weapon], $item[june cleaver]);
    equip($slot[off-hand], $item[Kramco Sausage-o-Matic&trade;]);
    if(available_amount($item[stinky cheese diaper]) == 0)
        cli_execute('fold stinky cheese diaper');
    equip($slot[pants], $item[stinky cheese diaper ]);
    equip($slot[acc1], $item[Lil' Doctor&trade; bag]);
    equip($slot[acc2], $item[lucky gold ring]);
    equip($slot[acc3], $item[mr. cheeng's spectacles]);
    
	while(nep_free_turn_can())
		nep_free_turn_run();
    set_auto_attack(0);
}