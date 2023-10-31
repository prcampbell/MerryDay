script md_iotm2019;

boolean MaySaber( int upgrade ) 
{
	if ( get_property_int("_saberMod") == 0 && retrieve_item(1,$item[Fourth of May Cosplay Saber]) ) {
		page = visit_url("main.php?action=may4");
		run_choice(upgrade);
	}
	return ( get_property_int("_saberMod") == upgrade );
}