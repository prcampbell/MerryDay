script md_outfit;


record bjorn_data
{
	familiar fam;
	item [int] drops;
	float dropChance;
	boolean limited;
};

bjorn_data [int] get_bjorn_data(boolean includeUnowned)
{
	bjorn_data [int] res;

	void add_entry(familiar fam, boolean [item] drops, float dropChance, boolean limited)
	{
		if(!have_familiar(fam) && !includeUnowned)
		{
			return;
		}

		bjorn_data entry;
		entry.fam = fam;
		foreach it in drops
		{
			entry.drops[entry.drops.count()] = it;
		}
		entry.dropChance = dropChance;
		entry.limited = limited;
		res[res.count()] = entry;
	}

	void add_entry(familiar fam, boolean [item] drops, float dropChance)
	{
		add_entry(fam, drops, dropChance, false);
	}

	//add_entry($familiar[angry goat], $items[goat cheese pizza], 1);
	//add_entry($familiar[cocoabo], $items[white chocolate chips], 1);
	add_entry($familiar[crimbo elf], $items[candy cane, cold hots candy, wint-o-fresh mint], 1);
	//add_entry($familiar[flaming gravy fairy], $items[hot nuggets], 1);
	//add_entry($familiar[frozen gravy fairy], $items[cold nuggets], 1);
	//add_entry($familiar[stinky gravy fairy], $items[stench nuggets], 1);
	//add_entry($familiar[spooky gravy fairy], $items[spooky nuggets], 1);
	//add_entry($familiar[attention-deficit demon], $items[chorizo brownies, white chocolate and tomato pizza, carob chunk noodles], 1);
	add_entry($familiar[sweet nutcracker], $items[candy cane, eggnog, fruitcake, gingerbread bugbear], 1);
	//add_entry($familiar[sleazy gravy fairy], $items[sleaze nuggets], 1);
	//add_entry($familiar[astral badger], $items[spooky mushroom, knob mushroom, knoll mushroom], 2);
	add_entry($familiar[ancient yuletide troll], $items[candy cane, eggnog, fruitcake, gingerbread bugbear], 1);
	add_entry($familiar[adorable seal larva], $items[hot nuggets, cold nuggets, stench nuggets, spooky nuggets, sleaze nuggets], 0.35);
	//add_entry($familiar[green pixie], $items[bottle of tequila], 1);
	//add_entry($familiar[gluttonous green ghost], $items[bean burrito, enchanted bean burrito, jumping bean burrito], 1);
	// hunchbacked minion based on a guess by bmaher
	add_entry($familiar[hunchbacked minion], $items[skeleton bone, skeleton bone, skeleton bone, skeleton bone, skeleton bone, skeleton bone, skeleton bone, skeleton bone, skeleton bone, skeleton bone, skeleton bone, skeleton bone, skeleton bone, skeleton bone, skeleton bone, skeleton bone, skeleton bone, skeleton bone, skeleton bone, disembodied brain], 1);
	//add_entry($familiar[untamed turtle], $items[snailmail bits, turtlemail bits, turtle wax], 0.35);
	//add_entry($familiar[cotton candy carnie], $items[cotton candy pinch], 1);
	add_entry($familiar[stocking mimic], $items[angry farmer candy, cold hots candy, rock pops, tasty fun good rice candy, wint-o-fresh mint], 1);
	//add_entry($familiar[bricko chick], $items[bricko brick], 1);
	add_entry($familiar[pottery barn owl], $items[volcanic ash], 0.1);
	//add_entry($familiar[piano cat], $items[beertini, papaya slung, salty slug, tomato daiquiri], 1);
	//add_entry($familiar[robot reindeer], $items[candy cane, eggnog, fruitcake, gingerbread bugbear], 1);
	add_entry($familiar[li\'l xenomorph], $items[lunar isotope], 1.0 / 17.0);
	//	add_entry($familiar[reanimated reanimator], $items[broken skull, broken skull, broken skull, broken skull, hot wing], 1);
	add_entry($familiar[warbear drone], $items[warbear whosit], 1.0 / 4.5);
	add_entry($familiar[golden monkey], $items[gold nuggets], 0.5);
	add_entry($familiar[mini kiwi], $items[mini kiwi], 0.1);

	void limited_add_entry(familiar fam, boolean [item] drops, float dropChance, string prop, int limit)
	{
		if(get_property(prop).to_int() < limit)
		{
			add_entry(fam, drops, dropChance, true);
		}
	}

	limited_add_entry($familiar[machine elf], $items[abstraction: sensation, abstraction: thought, abstraction: action, abstraction: category, abstraction: perception, abstraction: purpose], 0.2, "_abstractionDropsCrown", 25);
	limited_add_entry($familiar[garbage fire], $items[burning newspaper], 3 - get_property("_garbageFireDropsCrown").to_int(), "_garbageFireDropsCrown", 3);
	limited_add_entry($familiar[grim brother], $items[grim fairy tale], 1, "_grimFairyTaleDropsCrown", 2);
	limited_add_entry($familiar[grimstone golem], $items[grimstone mask], 1, "_grimstoneMaskDropsCrown", 1);
	limited_add_entry($familiar[trick-or-treating tot], $items[hoarded candy wad], 1, "_hoardedCandyDropsCrown", 3);
	limited_add_entry($familiar[optimistic candle], $items[glob of melted wax], 1, "_optimisticCandleDropsCrown", 3);
	limited_add_entry($familiar[adventurous spelunker], $items[bubblewrap ore, cardboard ore, styrofoam ore, teflon ore, velcro ore, vinyl ore], 1, "_oreDropsCrown", 6);
	limited_add_entry($familiar[twitching space critter], $items[space beast fur], 1, "_spaceFurDropsCrown", 1);
	limited_add_entry($familiar[puck man], $items[yellow pixel], 0.25, "_yellowPixelDropsCrown", 1);

	return res;
}

item wadify(item nugget)
{
	switch(nugget)
	{
	case $item[hot nuggets]: return $item[hot wad];
	case $item[cold nuggets]: return $item[cold wad];
	case $item[sleaze nuggets]: return $item[sleaze wad];
	case $item[stench nuggets]: return $item[stench wad];
	case $item[spooky nuggets]: return $item[spooky wad];
	case $item[twinkly nuggets]: return $item[twinkly wad];
	default: return $item[none];
	}
}

int get_price(item it)
{
	int dropVal = mall_price(it);
	if(dropVal == max(100, 2 * autosell_price(it)))
	{
		item wad = wadify(it);
		if(wad != $item[none])
		{
			return max(mall_price(wad) / 5, autosell_price(it));
		}
		return autosell_price(it);
	}
	return dropVal;
}

float bjorn_average_value(bjorn_data bd)
{
	float value = 0;
	foreach i, it in bd.drops
	{
		value += get_price(it);
	}
	value /= bd.drops.count();
	value *= bd.dropChance;
	return value;
}

bjorn_data [int] get_bjorn_data_sorted(boolean includeUnowned)
{
	bjorn_data [int] data = get_bjorn_data(includeUnowned);
	sort data by bjorn_average_value(value);
	return data;
}

bjorn_data get_best_bjorn_data()
{
	bjorn_data [int] data = get_bjorn_data_sorted(false);
	return data[data.count() - 1];
}

familiar get_best_bjorn()
{
	return get_best_bjorn_data().fam;
}

familiar ChooseFamiliar()
{
    foreach f in $familiars[Li'l Xenomorph, Baby Sandworm, Rogue Program,  Astral Badger, Green Pixie, Llama lama, Blavious Kloop, Fist Turkey]
			if ( have_familiar(f) && f.drops_today < 1 )
				return f;
    foreach f in $familiars[Li'l Xenomorph, Baby Sandworm, Rogue Program,  Astral Badger, Green Pixie, Llama lama, Blavious Kloop, Fist Turkey]
			if ( have_familiar(f) && f.drops_today < 2 )
				return f;
    foreach f in $familiars[Li'l Xenomorph, Baby Sandworm, Rogue Program,  Astral Badger, Green Pixie, Llama lama, Blavious Kloop, Fist Turkey]
			if ( have_familiar(f) && f.drops_today < 3 )
				return f;
    foreach f in $familiars[Li'l Xenomorph, Baby Sandworm, Rogue Program,  Astral Badger, Green Pixie, Llama lama, Blavious Kloop, Fist Turkey]
			if ( have_familiar(f) && f.drops_today < 4 )
				return f;
    foreach f in $familiars[Li'l Xenomorph, Baby Sandworm, Rogue Program,  Astral Badger, Green Pixie, Llama lama, Blavious Kloop, Fist Turkey]
			if ( have_familiar(f) && f.drops_today < 5 )
				return f;
    return $familiar[reagnimated gnome];
}

void construct_free_outfit(item[slot] required_equips)
{
	location ghostLocation = to_location(get_property("ghostLocation"));

	//free outfits prioritize charging equipment

//back
	if(required_equips[$slot[back]] != $item[none])
	{
		equip($slot[back], required_equips[$slot[back]]);
	}
	else if (ghostLocation == $location[none] && total_turns_played() > get_property("nextParanormalActivity").to_int() )
	{
		equip($slot[back], $item[protonic accelerator pack]);
	}
	else if(get_property('_vampyreCloakeFormUses').to_int() < 10)
    {
        equip($slot[back], $item[vampyric cloake]);
    }
    else
    {
        equip($slot[back], $item[buddy bjorn]);
        bjornify_familiar(get_best_bjorn());    
    }

//hat
	if(required_equips[$slot[hat]] != $item[none])
	{
		equip($slot[hat], required_equips[$slot[hat]]);
	}
    else if(equipped_item($slot[back]) != $item[buddy bjorn])
    {
        equip($slot[hat], $item[crown of thrones]);
        enthrone_familiar(get_best_bjorn());
    }
    else
    {
        equip($slot[hat], $item[daylight shavings helmet]);
    }

	//shirt
	if(required_equips[$slot[shirt]] != $item[none] && can_equip(required_equips[$slot[shirt]]))
	{
		equip($slot[shirt], required_equips[$slot[shirt]]);
	}
	else
	{
		equip($slot[shirt], $item[jurassic parka]);
	}

	//pants
	if(required_equips[$slot[pants]] != $item[none] && can_equip(required_equips[$slot[pants]]))
	{
		equip($slot[pants], required_equips[$slot[pants]]);
	}
    else if(get_property('_pantsgivingCount').to_int() < 5)
    {
        equip($slot[pants], $item[pantsgiving]);
    }
    else if(get_property('sweat').to_int() < 75)
    {
        equip($slot[pants], $item[designer sweatpants]);
    }
    else 
    {
        if(available_amount($item[pantogram pants]) > 0)
            equip($slot[pants], $item[pantogram pants]);
        else
            equip($slot[pants], $item[pantsgiving]);
    }

	//weapon
    if(required_equips[$slot[weapon]] != $item[none] && can_equip(required_equips[$slot[weapon]]))
	{
		equip($slot[weapon], required_equips[$slot[weapon]]);
	}
    else 
	{
		equip($slot[weapon], $item[june cleaver]);
	}
	
	//off-hand

	if(required_equips[$slot[off-hand]] != $item[none] && can_equip(required_equips[$slot[off-hand]]))
	{
		equip($slot[off-hand], required_equips[$slot[off-hand]]);
	}
	else
	{
		equip($slot[off-hand], $item[Kol Con 13 snowglobe]);
	}
    
	//accessories
	if(required_equips[$slot[acc1]] != $item[none] 
		&& can_equip(required_equips[$slot[acc1]])
		&& required_equips[$slot[acc1]] != $item[mr. screege's spectacles]
		&& required_equips[$slot[acc1]] != $item[mr. cheeng's spectacles]
		&& required_equips[$slot[acc1]] != $item[stinky cheese eye]
		)
	{
		equip($slot[acc1], required_equips[$slot[acc1]]);
	}
    else if(get_property('questDoctorBag') == 'unstarted')
        equip($slot[acc1], $item[Lil' Doctor&trade; bag]);
    else 
        equip($slot[acc1], $item[Lucky Gold Ring]);

	if(required_equips[$slot[acc2]] == $item[teacher's pen] && get_property('_stinkyCheeseCount').to_int() < 100)
    {
		//stinky cheese charging over-rides familiar experience
        if(available_amount($item[stinky cheese eye]) == 0)
        cli_execute('fold stinky cheese eye');
        equip($slot[acc2], $item[stinky cheese eye]);
    }
	else if(required_equips[$slot[acc2]] != $item[none] 
		&& can_equip(required_equips[$slot[acc2]])
		&& required_equips[$slot[acc2]] != $item[mr. screege's spectacles]
		&& required_equips[$slot[acc2]] != $item[Lil' Doctor&trade; bag]
		&& required_equips[$slot[acc2]] != $item[Lucky Gold Ring]
		)
	{
		equip($slot[acc2], required_equips[$slot[acc2]]);
	}
	if(get_property('_stinkyCheeseCount').to_int() < 100)
    {
        if(available_amount($item[stinky cheese eye]) == 0)
        cli_execute('fold stinky cheese eye');
        equip($slot[acc2], $item[stinky cheese eye]);
    }
	else
	{
		equip($slot[acc2], $item[mr. cheeng's spectacles]);
	}

	if(required_equips[$slot[acc3]] != $item[none] 
		&& can_equip(required_equips[$slot[acc3]])
		&& required_equips[$slot[acc3]] != $item[Lil' Doctor&trade; bag]
		&& required_equips[$slot[acc3]] != $item[Lucky Gold Ring]
		&& required_equips[$slot[acc3]] != $item[stinky cheese eye]
		)
	{
		equip($slot[acc3], required_equips[$slot[acc3]]);
	}
	else 
	{
		equip($slot[acc3], $item[mr. screege's spectacles]);
	}
    
	
	if(required_equips[$slot[familiar]] != $item[none])
	{
		equip($slot[familiar], required_equips[$slot[familiar]]);
	}
	

}

boolean should_grow(familiar fam)
{
	if($familiars[chest mimic, grey goose, pocket professor] contains fam)
	{
		return true;
	}
	else
	{
		return false;
	}
}

void construct_free_outfit(item[slot] required_equips, familiar fam)
{
	use_familiar(fam);

	if(should_grow(fam))
	{
		//These are familiars we want to fatten up, so add familiar exp to required_equips
		if(required_equips[$slot[hat]] == $item[none])
		{
			required_equips[$slot[hat]] = $item[giant yellow hat];
		}
		if(required_equips[$slot[weapon]] == $item[none])
		{
			required_equips[$slot[weapon]] = $item[yule hatchet];
		}
		if(required_equips[$slot[off-hand]] == $item[none])
		{
			required_equips[$slot[off-hand]] = $item[familiar scrapbook];
		}
		if(required_equips[$slot[acc1]] == $item[none])
		{
			required_equips[$slot[acc1]] = $item[messenger bag rna];
		}
		if(required_equips[$slot[acc2]] == $item[none])
		{
			required_equips[$slot[acc2]] = $item[teacher's pen];
		}
		if(required_equips[$slot[acc3]] == $item[none])
		{
			required_equips[$slot[acc3]] = $item[teacher's pen];
		}
		if(required_equips[$slot[familiar]] == $item[none])
		{
			required_equips[$slot[familiar]] = $item[toy cupid bow];
		}

	}
	construct_free_outfit(required_equips);
}

void construct_free_outfit(familiar fam)
{
	item[slot] nothing;
	construct_free_outfit(nothing, fam);   
}

void construct_free_outfit()
{
	item[slot] nothing;
	construct_free_outfit(nothing);   
}

void construct_meat_outfit(item[slot] required_equips, familiar fam)
{
	use_familiar(fam);

	equip($slot[hat], $item[apriling band helmet]);
	//equip($slot[hat], $item[crumpled felt fedora]);
	equip($slot[back], $item[Buddy Bjorn]); //Happy medium or Misshapen Animal Skeleton
	equip($slot[shirt], $item[Jurassic Parka]); //Kachungasaur
	equip($slot[pants], $item[Pantsgiving]);
	//equip($slot[pants], $item[repaid diaper]);
	//equip($slot[pants], $item[pantogram pants]);

	equip($slot[acc1], $item[yamtility belt]);
	equip($slot[acc2], $item[wormwood wedding ring]);
	equip($slot[acc3], $item[ring of the skeleton lord]);

	equip($slot[weapon], $item[fourth of may cosplay saber]);
	//equip($slot[weapon], $item[garbage sticker]);
	equip($slot[off-hand], $item[latte lovers member's mug]);

	equip($slot[familiar], $item[amulet coin]);
}