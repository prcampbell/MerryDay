script Librams;

int minMP = max(0,my_maxmp()*to_float(get_property("mpAutoRecoveryTarget")));

static {
	string[coinmaster,string,int,item] cm_txt;
	file_to_map( "data/coinmasters.txt", cm_txt );
}

int recent_price(item it) {
	if ( !it.tradeable )								// untradeable items don't have mall value
		return 0;
	else if ( historical_age(it) < 7.0 )				// 1 week sounds about right
		return historical_price(it);
	else if (mall_price(it)>0)
		return mall_price(it);
	else if (mall_price(it)<=0 && my_hash() != "")	{ 	// items that are not in the mall return -1
		if ( is_npc_item(it) || is_coinmaster_item(it) )// Includes items such as lucky lindy, which are marked tradable, but can never be owned
			return 0;
		else if ( historical_age(it) < 4015 )			// historical age returns infinite for items that have never been seen before: 11 years should do it
			return historical_price(it);
		else
			return 1000000000;
	}
	else {
		abort("No idea how to price item: "+it);
		return -1;
	}
}



int coinmasterValue (item it);

int averageValue ( boolean [item] itemList );

int itemValue ( item it ) {
	int specialValue ( item it ) {
		switch (it) {
			case $item[spooky putty monster]:
				return itemValue($item[spooky putty sheet]);
			case $item[empty Rain-Doh can]:
				return itemValue($item[can of Rain-Doh]);
			case $item[coffee pixie stick]:
				return itemValue($item[Game Grid ticket])*10;
			case $item[Merc Core deployment orders]:
				return itemValue($item[one-day ticket to conspiracy island]);
			case $item[roll of hob-os]:
				return 4.5*averageValue($items[sterno-flavored Hob-O, frostbite-flavored Hob-O, fry-oil-flavored Hob-O, strawberry-flavored Hob-O, garbage-juice-flavored Hob-O]);
			case $item[bricko brick]:
				return 90;
			case $item[bricko trunk]:
				return 5*itemValue($item[BRICKO brick])+itemValue($item[BRICKO eye brick])/10;
			case $item[d4]:
				return 2.5*itemValue($item[generic restorative potion]);
			case $item[d6]:
				return 3.5*itemValue($item[generic mana potion]);
			case $item[d8]:
				return 4.5*itemValue($item[generic healing potion]);
			case $item[unfinished ice sculpture]:
				return 3*itemValue($item[snow berries])+3*itemValue($item[ice harvest]);
			case $item[bag of park garbage]:
				return 200;
			case $item[gathered meat-clip]:
				return 500;
			case $item[free-range mushroom]:
				return 3*itemValue($item[mushroom filet]);
			case $item[plump free-range mushroom]:
				return itemValue($item[free-range mushroom])+3*itemValue($item[mushroom filet]);
			case $item[bulky free-range mushroom]:
				return itemValue($item[plump free-range mushroom])+3*itemValue($item[mushroom filet]);
			case $item[giant free-range mushroom]:
				return itemValue($item[bulky free-range mushroom])+itemValue($item[mushroom slab]);
			case $item[immense free-range mushroom]:
				return itemValue($item[giant free-range mushroom])+itemValue($item[mushroom slab]);
			case $item[colossal free-range mushroom]:
				return itemValue($item[immense free-range mushroom])+itemValue($item[house-sized mushroom]);
			case $item[magical sausage casing]:
				return get_property("valueOfAdventure").to_int() - (available_amount($item[magical sausage casing])+get_property("_sausagesMade").to_int()-get_property("_sausageFights").to_int())/5*111;
			default:
				if ( npc_price(it) > 0 )
					return npc_price(it);
				return 0;
		}
	}
 
	int singularValue( item it ) {
		int minValue = specialValue(it);
		if ( !it.tradeable )
			minValue = max(minValue,coinmasterValue(it));
		if ( recent_price(it) <= max(100,2* autosell_price(it)) )
			return max( minValue , autosell_price(it) );
		else 
			return max( minValue , recent_price(it) );
	}
 
	int maxValue = singularValue(it);
	if ( count(get_related(it,"fold")) > 0 )
		foreach j in get_related(it,"fold")
			maxValue = min( maxValue, singularValue(j) );
/*	if ( count(get_related(it,"zap")) > 0 )
		foreach j in get_related(it,"zap")
			maxValue = min( maxValue, singularValue(j) );
*/	
	return maxValue;
}
 
int tokenItemValue(item check) {
	item best;
	float pc,bestValue;
	foreach c, direction, price, it, row in cm_txt {
		if ( c.item == check && check != $item[none] && direction == "buy" && it.tradeable ) {
			pc = to_float(itemValue(it))/to_float(price);
			if ( false )
				print(price+" "+check+" can be traded for "+it+" for "+to_string(pc,"%,.2f")+" meat per token");
			if ( pc > bestValue ) {
				bestValue = pc; 
				best = it;
			}	
		}
	}
	return to_int(bestValue);
}
 
int averageValue ( boolean [item] itemList ) {
	int total;
	if ( count(itemList) == 0 )
		return 0;
	foreach it in itemList
		total += itemValue(it);
	return total/count(itemList);
}
 
int totalValue ( int [item] itemList ) {
	int total;
	foreach it in itemList
		total += itemValue(it)*itemList[it];
	return total;
}
 
int totalValue ( float [item] itemList ) {
	int total;
	foreach it in itemList
		total += itemValue(it)*itemList[it];
	return total;
}
 
int totalValue ( item [int] itemList ) {
	int total;
	foreach i,it in itemList
		total += itemValue(it);
	return total;
}
 
int totalValue ( boolean [item] itemList ) {
	int total;
	foreach it in itemList
		total += itemValue(it);
	return total;
}

int coinmasterValue(item check) {
	boolean dummy = false;
	foreach c in $coinmasters[]
		if ( check == c.item )
			dummy = true;
	if ( dummy && !check.tradeable )
		return tokenItemValue(check);
 
	if ( check != $item[Merc Core deployment orders] )
		foreach c, direction, price, it, row in cm_txt
			if ( direction == "buy" && check == it )
				return ItemValue(c.item)*price;
	return 0;
}
 
boolean useInRun = get_property("Librams.InRun").to_boolean();
boolean simulate = false;
boolean valuesInitialized = false;
 
static {
	record libram_record {
		string name; // Easily referenced name of this skill
		boolean useLibram; // Should this libram be summoned from?
		boolean [item] commonItems;
		float commonChance;
		boolean [item] rareItems1;
		float rareChance1;
		boolean [item] rareItems2;
		float rareChance2;
		int castLimit;
		int castValue;
	};
 
	libram_record [skill] LibramList;
	// CREATE RECORDS FOR ALL THE LIBRAMS
		LibramList[$skill[Summon Candy Heart]].name			= "Hearts";
		LibramList[$skill[Summon Candy Heart]].commonItems	= $items[white candy heart,pink candy heart,orange candy heart,lavender candy heart,yellow candy heart,green candy heart];
 
		LibramList[$skill[Summon Party Favor]].name			= "Favors";
		LibramList[$skill[Summon Party Favor]].commonItems	= $items[divine noisemaker,divine can of silly string,divine blowout];
		LibramList[$skill[Summon Party Favor]].rareItems1	= $items[divine champagne flute,divine champagne popper,divine cracker];
 
		LibramList[$skill[Summon Love Song]].name			= "Songs";
		LibramList[$skill[Summon Love Song]].commonItems	= $items[love song of vague ambiguity,love song of smoldering passion,love song of icy revenge,love song of sugary cuteness,love song of disturbing obsession,love song of naughty innuendo];
 
		LibramList[$skill[Summon BRICKOs]].name				= "BRICKOs";
		LibramList[$skill[Summon BRICKOs]].commonItems		= $items[BRICKO brick];
		LibramList[$skill[Summon BRICKOs]].rareItems1		= $items[BRICKO eye brick];
 
		LibramList[$skill[Summon Dice]].name				= "Dice";
		LibramList[$skill[Summon Dice]].commonItems			= $items[d4,d6,d8,d10,d12,d20];
 
		LibramList[$skill[Summon Resolutions]].name			= "Resolutions";
		LibramList[$skill[Summon Resolutions]].commonItems	= $items[resolution: be wealthier,resolution: be happier,resolution: be feistier,resolution: be stronger,resolution: be smarter,resolution: be sexier];
		LibramList[$skill[Summon Resolutions]].rareItems1	= $items[resolution: be kinder,resolution: be luckier,resolution: be more adventurous];
 
		LibramList[$skill[Summon Taffy]].name				= "Taffies";
		LibramList[$skill[Summon Taffy]].commonItems		= $items[pulled red taffy, pulled orange taffy, pulled blue taffy, pulled violet taffy];
		LibramList[$skill[Summon Taffy]].rareItems1			= $items[pulled green taffy, pulled indigo taffy];
		LibramList[$skill[Summon Taffy]].rareItems2			= $items[pulled yellow taffy];
}
 
 
void UpdateLibramList( skill Libram ) {
	LibramList[Libram].castValue = 0;
	switch (Libram) {
		case $skill[Summon Candy Heart]:
		case $skill[Summon Love Song]:
		case $skill[Summon Dice]:
			LibramList[Libram].castLimit 	= 200;
			break;
		case $skill[Summon Party Favor]:
			LibramList[Libram].rareChance1	= 1.0/2.0**(1+get_property("_favorRareSummons").to_int());
			LibramList[Libram].castLimit 	= min( 200 , 2**(get_property("_favorRareSummons")-1).to_int() );
			break;
		case $skill[Summon BRICKOs]:
			LibramList[Libram].rareChance1	= ( get_property("_brickoEyeSummons").to_int() <= 1 ? 0.5 : (get_property("_brickoEyeSummons").to_int() >= 3 ? 0 : 0.3333333) );
			LibramList[Libram].castLimit 	= ( get_property("_brickoEyeSummons").to_int() >= 3 ? 200 : 3-get_property("_brickoEyeSummons").to_int() );
			LibramList[Libram].castValue 	+= 2*itemValue($item[BRICKO brick]);
			break;
		case $skill[Summon Resolutions]:
			LibramList[Libram].rareChance1	= ( get_property("_resolutionRareSummons").to_int() < 3 ? 0.14 : 0.02 );
			LibramList[Libram].castLimit	= ( get_property("_resolutionRareSummons").to_int() >= 3 ? 200 : (3-get_property("_resolutionRareSummons").to_int()) );
			break;
		case $skill[Summon Taffy]:
			LibramList[Libram].rareChance1	= ( get_property("_taffyRareSummons").to_int()-get_property("_taffyYellowSummons").to_int() < 3 ? 0.2 : 0 );
			LibramList[Libram].rareChance2	= ( get_property("_taffyYellowSummons").to_int() < 1 ? 0.1 : 0 );
			LibramList[Libram].castLimit 	= ( get_property("_taffyYellowSummons").to_int()<1 ? 1 : get_property("_taffyRareSummons").to_int() >= 4 ? 200 : (4-get_property("_taffyRareSummons").to_int()) );
			break;
	}
 
	LibramList[Libram].commonChance			= 1.0 - LibramList[Libram].rareChance1 - LibramList[Libram].rareChance2;
	LibramList[Libram].castValue 			+= averageValue(LibramList[Libram].commonItems)*LibramList[Libram].commonChance;
	LibramList[Libram].castValue 			+= averageValue(LibramList[Libram].rareItems1)*LibramList[Libram].rareChance1;
	LibramList[Libram].castValue 			+= averageValue(LibramList[Libram].rareItems2)*LibramList[Libram].rareChance2;
}
 
int numLibrams;
foreach s,L in LibramList {
	if ( get_property("Librams.Use"+L.name) != "" )
		L.useLibram = (have_skill(s) && get_property("Librams.Use"+L.name).to_boolean());
	else
		L.useLibram = have_skill(s);
	if ( L.useLibram )
		numLibrams++;
}
 
skill bestLibram() {
	if ( !valuesInitialized ) {
		foreach s in LibramList
			UpdateLibramList(s);
		valuesInitialized = true;
	}
	skill best;
	int bestValue;
	foreach s,L in LibramList
		if ( L.useLibram && L.commonChance < 0.91 && L.castValue > bestValue ) {
			best = s;
			bestValue = L.castValue;
		}
	if ( best != $skill[none] )
		return best;
	foreach s,L in LibramList
		if ( L.useLibram && L.castValue > bestValue ) {
			best = s;
			bestValue = L.castValue;
		}
	return best;
}
 
int nextLibramCost() {
	return mp_cost($skill[Summon BRICKOs]);
}
 
int maxCasts(boolean burnAllMP) {
	int x = get_property("libramSummons").to_int();
	int y = x;
	int total = 0;
	repeat {
		y++;
		total += max(1,y*(y-1)/2 + mana_cost_modifier() );
	} until ( total > my_mp()-(burnAllMP ? 0 : minMP) );
	return y-x-1;
}
 
void LibramBurn( boolean burnAllMP ) {
	int minMPLibram = minMP;
	if ( burnAllMP )
		minMPLibram = 0;
	if ( can_interact() || useInRun ) {
		if ( numLibrams > 0 ) {
			if ( nextLibramCost() < my_mp()-minMPLibram) {
				if ( equipped_amount($item[sphygmayomanometer]) == 0 )
					restore_hp(0);
				while ( nextLibramCost() < my_mp()-minMPLibram ) {
					skill libramSkill = bestLibram();
					int [item] resolutionInventory;
					if ( libramSkill == $skill[Summon Resolutions] ) {
						foreach it in LibramList[libramSkill].rareItems1
							resolutionInventory[it] = item_amount(it);
					}
					int casts = 1;
					if ( numLibrams == 1 )
						casts = min( 200, maxCasts(burnAllMP) );
					else if ( LibramList[libramSkill].castLimit > 1 )
						casts = min( maxCasts(burnAllMP), LibramList[libramSkill].castLimit );
					print("Casting "+libramSkill+" "+casts+" times. Value per cast: "+LibramList[libramSkill].castValue,"blue");
					if ( !simulate )
						use_skill(casts, libramSkill);
 
					if ( libramSkill == $skill[Summon Resolutions] ) {
						int resolutionRares = get_property("_resolutionRareSummons").to_int();
						foreach it in LibramList[libramSkill].rareItems1
							resolutionRares += item_amount(it)-resolutionInventory[it];
						set_property("_resolutionRareSummons",resolutionRares);
					}
					UpdateLibramList(libramSkill);
					if ( simulate )
						break;
				}
			}
			else {
				print_html("<font color=\"blue\">Libram summon #"+ (get_property("libramSummons").to_int()+1) + " when MP > "+(nextLibramCost() + minMPLibram)+"</font>");
			//	print_html("Libram summon #"+ (get_property("libramSummons").to_int()+1) + " when MP > " + int_to_string(ceil(next_summon_mp() + minmp - 1)) + ".", "blue", 3);
			}
		}
		else
			print("No librams available/selected for use","red");
	}
	else
		print("Librams set to not be used in run","red");
}
 
void LibramBurn() {
	LibramBurn(false);
}
 
void main() {
	LibramBurn(false);
}
