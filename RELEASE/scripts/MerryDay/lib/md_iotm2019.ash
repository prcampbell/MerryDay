script md_iotm2019;



boolean MaySaber( int upgrade ) 
{
    string page;
    
	if ( get_property("_saberMod").to_int() == 0 && retrieve_item(1,$item[Fourth of May Cosplay Saber]) ) {
		page = visit_url("main.php?action=may4");
		run_choice(upgrade);
	}
	return ( get_property("_saberMod").to_int() == upgrade );
}