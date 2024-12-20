familiar ChooseFamiliar()
{
    foreach f in $familiars[Jill-of-all-Trades, Li'l Xenomorph, Baby Sandworm, Rogue Program,  Astral Badger, Green Pixie, Llama lama, Blavious Kloop, Fist Turkey]
			if ( have_familiar(f) && f.drops_today < 1 )
				return f;
    if($familiar[Obtuse Angel].drops_today < 1)
        return $familiar[Obtuse Angel];
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
    return $familiar[Cookbookbat];
}

void main()
{
    use_familiar(ChooseFamiliar());
    if(item_amount($item[autumn-aton]) > 0)
    {
        cli_execute('fallguy send Shadow Rift');
    }


    equip($slot[weapon], $item[june cleaver]);
    equip($slot[off-hand], $item[deft pirate hook]);




    equip($slot[hat], $item[goggles of loathing]);


    if(get_property('_batWingsFreeFights').to_int() < 5)
        equip($slot[back], $item[bat wings]);
    else
        equip($slot[back], $item[buddy bjorn]);

    if(have_effect($effect[everything looks yellow]) == 0)
        equip($slot[shirt], $item[jurassic parka]);
    else
        equip($slot[shirt], $item[hodgman's disgusting technicolor overcoat]);
    
    if(get_property('_pantsgivingCount').to_int() < 50)
        equip($slot[pants], $item[Pantsgiving]);
    else if(get_property('_stinkyCheeseCount').to_int() < 100)
        equip($slot[pants], $item[stinky cheese diaper]);
    else if(get_property('sweat').to_int() < 75)
        equip($slot[pants], $item[designer sweatpants]);
    else
        equip($slot[pants], $item[designer sweatpants]);    

    if(have_effect($effect[everything looks red]) == 0)
        equip($slot[acc1], $item[everfull dart holster]);
    else 
        equip($slot[acc1], $item[mafia thumb ring]);
    equip($slot[acc2], $item[retrospecs]);
    equip($slot[acc3], $item[lucky gold ring]);   
}