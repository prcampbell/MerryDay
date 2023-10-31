script md_library;


boolean has_effect( effect ef ) 
{
	return (have_effect(ef) > 0);
}

boolean switchClan(int targetID) 
{
	if ( to_int(my_id()) > 30 && get_clan_id() != targetID ) {
		visit_url("showclan.php?recruiter=1&whichclan="+ targetID +"&pwd&whichclan=" + targetID + "&action=joinclan&apply=Apply+to+this+Clan&confirm=on");
	}
	return ( get_clan_id() == targetID );
}