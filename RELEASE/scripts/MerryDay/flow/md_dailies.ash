/*
Pantogram
ChibiBuddy
Refresh Latte
Free Goofballs
Beach Comb
Clan Fortunes
Glenn's Golden Dice
Clan Pool Table
Speakeasy Pool Table
Daycare Buff
Daycare free scavenge
redwood rainstick
Witchess Puzzle
Friar's Blessing
Legendary Beat
Portable Steam Unit
Summon Demon
Source Terminal Enhance
Source Terminal Enquire
Mad Tea Party
SongBoom - Meat (Food Vibrations if drunk)
MCD
Implement glitch
BittyCar MeatCar
Check NEP Quest
Check Barf Quest
*/

/*
AugustScepter Summons
Mayam Calendar
Pick Cargo Pocket
Mr. Store Catalogue
Kremlin's Briefcase

Internet Meme Shop

Fantasy Realm Hat
Lodestone
SIT Bugs
Rake Leaves
-Lit Lasso
-Day Shortener
CandyCane Meat Shrine
*/

/*
Amulet Coin?
*/

import "VotingBooth.ash";

int gnome() {
	// Ensure that you have body parts with the following priority. Otherwise snag the kgnee
	foreach i in $items[gnomish housemaid's kgnee, gnomish coal miner's lung, gnomish athlete's foot, gnomish swimmer's ears, gnomish tennis elbow]
		if(available_amount(i) < 1) return (to_int(i) - 5767);
	return 4;
}

void gravitate() 
{
    int rainbowLeft;
    boolean noSummonsLeft() {
        rainbowLeft = 3 - get_property("prismaticSummons").to_int();
        return rainbowLeft < 1;
    }
    if(!have_skill($skill[Rainbow Gravitation]) || noSummonsLeft()) return;
    foreach key in $items[twinkly wad, hot wad, cold wad, spooky wad, stench wad, sleaze wad]
        retrieve_item(rainbowLeft, key);
    use_skill(rainbowLeft, $skill[rainbow gravitation]);
}

void Morning()
{
    cli_execute('closet put * meat');
	cli_execute('closet take 5000000 meat');
    set_property('hpAutoRecovery', '0.8');
	set_property("hpAutoRecoveryTarget", "1.0");

    cli_execute('swim item');

    if (get_property("_internetPrintScreenButtonBought") == "false"
	&& $item[BACON].item_amount() > 111)
    {
        cli_execute("coinmaster buy bacon print screen button");
    }


    /*Get Guzzlr cocktail set*/
                visit_url("inventory.php?tap=guzzlr", false);
                run_choice(4); // take platinum quest
                wait(1); // mafia's tracking breaks occasionally if you go too fast.
                visit_url("inventory.php?tap=guzzlr", false);
                run_choice(1); // abandon
                run_choice(5); // leave the choice.
    /*End Guzzlr*/

    voteInVotingBooth();
    use(1, $item[bird-a-day calendar]);
    //Chateau juice bar
    visit_url('place.php?whichplace=chateau&action=chateau_desk2');

    /*Default buffs*/
    if (have_effect($effect[That's Just Cloud-Talk, Man]) == 0) { //'
            visit_url('place.php?whichplace=campaway&action=campaway_sky');
        }   
    cli_execute('bastille myst draftsman gesture');

    if(get_property('_timeSpinnerMinutesUsed').to_int() == 0)
        cli_execute('FarFuture drink');
    
    cli_execute('horsery dark');

    if(get_property('_deckCardsDrawn').to_int() < 15 && !contains_text('_deckCardsSeen', 'Island')) { cli_execute('cheat Island');}
    if(get_property('_deckCardsDrawn').to_int() < 15 && !contains_text('_deckCardsSeen', 'Ancestral Recall')) { cli_execute('cheat Ancestral Recall');}
    if(get_property('_deckCardsDrawn').to_int() < 15 && !contains_text('_deckCardsSeen', 'Gift Card')) { cli_execute('cheat Gift Card');}

    while(get_property('_sourceTerminalExtrudes').to_int() < 3) { cli_execute('terminal extrude booze.ext'); }
    if(get_property('_clipartSummons').to_int() < 3)
    {
        cli_execute('make box of familiar jacks');
    }
    if(get_property('_clipartSummons').to_int() < 2)
    {
        cli_execute('make bucket of wine');
    }
    if(get_property('_clipartSummons').to_int() < 1)
    {
        cli_execute('make borrowed time');
    }

    cli_execute('teatree shake');
    gravitate();
    
    
    if(have_familiar($familiar[Reagnimated Gnome])) 
    {
        familiar f = my_familiar();
        use_familiar($familiar[Reagnimated Gnome]);
        visit_url("arena.php");
        visit_url("choice.php?pwd&whichchoice=597&option="+gnome());
        /*
        if(equipped_item($slot[familiar]) == $item[none])
            equip($item[gnomish housemaid's kgnee]);
        use_familiar(f); // Restore original familiar
        */
    }

    if(!contains_text(get_property('boomBoxSong'), 'Total Eclipse of Your Meat')) {cli_execute('boombox meat');}
    if(item_amount($item[blue plate]) > 0)
    {
        use_familiar($familiar[Shorter-Order Cook ]);
        equip($slot[familiar], ($item[blue plate]));
    }
    if(item_amount($item[tiny stillsuit]) > 0)
    {
        use_familiar($familiar[slimeling]);
        equip($slot[familiar], ($item[tiny stillsuit]));
    }

    if(get_property('_aprilBandInstruments') < 2 && item_amount($item[Apriling band saxophone]) == 0)
    {
        cli_execute('aprilband item saxophone');
    }
    if(get_property('_aprilBandInstruments') < 2 && item_amount($item[Apriling band tuba]) == 0)
    {
        cli_execute('aprilband item tuba');
    }

    if(!contains_text(get_property('_mummeryUses'), '1') && !contains_text(get_property('_mummeryMods'), 'Meat Drop'))
    {
        use_familiar($familiar[jill-of-all-trades]);
        cli_execute('mummery meat');
    }
    if(!contains_text(get_property('_mummeryUses'), '4') && !contains_text(get_property('_mummeryMods'), 'Item Drop'))
    {
        use_familiar($familiar[trick-or-treating tot]);
        cli_execute('mummery item');
    }

    if(item_amount($item[moveable feast]) > 0 && get_property('_feastUsed') < 5 && !contains_text(get_property('_feastedFamiliars'), 'Frumious Bandersnatch'))
    {
        use_familiar($familiar[frumious bandersnatch]);
        use(1, $item[moveable feast]);
    }
    if(item_amount($item[moveable feast]) > 0 && get_property('_feastUsed') < 5 && !contains_text(get_property('_feastedFamiliars'), 'Pocket Professor'))
    {
        use_familiar($familiar[pocket professor]);
        use(1, $item[moveable feast]);
    }
    if(item_amount($item[moveable feast]) > 0 && get_property('_feastUsed') < 5 && !contains_text(get_property('_feastedFamiliars'), 'Jill-of-All-Trades'))
    {
        use_familiar($familiar[jill-of-all-trades]);
        use(1, $item[moveable feast]);
    }

    if(!contains_text(get_property('_mayamSymbolsUsed'), 'yam1')
     && !contains_text(get_property('_mayamSymbolsUsed'), 'meat')
     && !contains_text(get_property('_mayamSymbolsUsed'), 'eyepatch')
     && !contains_text(get_property('_mayamSymbolsUsed'), 'yam4'))
    
    {
        cli_execute('mayam resonance yamtility belt');
    }
    if(!contains_text(get_property('_mayamSymbolsUsed'), 'chair')
     && !contains_text(get_property('_mayamSymbolsUsed'), 'yam2')
     && !contains_text(get_property('_mayamSymbolsUsed'), 'cheese')
     && !contains_text(get_property('_mayamSymbolsUsed'), 'explosion'))
    
    {
        cli_execute('mayam rings chair yam cheese explosion');
    }
    if(!contains_text(get_property('_mayamSymbolsUsed'), 'fur')
     && !contains_text(get_property('_mayamSymbolsUsed'), 'bottle')
     && !contains_text(get_property('_mayamSymbolsUsed'), 'yam3')
     && !contains_text(get_property('_mayamSymbolsUsed'), 'clock'))
    
    {
        if($familiar[Pocket Professor].experience < 400)
        {
            use_familiar($familiar[Pocket Professor]);
        }
        else if($familiar[Chest Mimic].experience < 550)
        {
            use_familiar($familiar[Chest Mimic]);
        }
        else 
        {
            use_familiar($familiar[Grey Goose]);
        }
        cli_execute('mayam rings fur bottle yam clock');
    }

    

/*
    if(!get_property('_candyCaneSwordOvergrownShrine').to_boolean())
    {

        equip($slot[weapon], $item[candy cane sword cane]);
        adv1($location[An Overgrown Shrine (Northeast)], -1, '');
        run_choice(4);
        run_choice(6);

    }
*/
    

    set_auto_attack(0);
}


void main()
{
    Morning();
}