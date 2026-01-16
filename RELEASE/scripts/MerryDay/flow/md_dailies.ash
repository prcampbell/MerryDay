import md_library;
import md_iotm2019;
import md_iotm2020;

/*

ChibiBuddy
Refresh Latte
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
SongBoom - Meat (Food Vibrations if drunk)f
MCD
Implement glitch
BittyCar MeatCar
Lodestone

*/

/*
AugustScepter Summons
Pantogram
Pick Cargo Pocket
Mr. Store Catalogue
Kremlin's Briefcase
Free Goofballs
Beach Comb
Internet Meme Shop

Fantasy Realm Hat
Check NEP Quest
Check Barf Quest
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

void dailyMeatBuffs()
{
    if(!get_property('_lodestoneUsed').to_boolean() && $item[lodestone].item_amount() > 0)
    {
        use(1, $item[lodestone]);
    }
    if(!get_property('_favoriteBirdVisited').to_boolean() && have_skill($skill[visit your favorite bird]))
    {
        use_skill(1, $skill[visit your favorite bird]);
    }
    if(!get_property('_clanFortuneBuffUsed').to_boolean())
    {
        cli_execute('fortune buff meat');
    }
    while(get_property('_sourceTerminalEnhanceUses').to_int() < 3)
    {
        cli_execute('terminal enhance meat');
    }
    if(!get_property('demonSummoned').to_boolean() && get_property('questL11Manor') == 'finished')
    {
        cli_execute('summon 2');
    }
    if(!get_property('concertVisited').to_boolean() && get_property('sidequestArenaCompleted') == 'fratboy')
    {
        cli_execute('concert w');
    }
    if(contains_text(get_property('_birdOfTheDayMods'), 'Meat Drop') && my_mp() >= 425)
    {
        while(get_property('_birdsSoughtToday') < 6)
        {
            use_skill(1, $skill[Seek out a Bird]);
        }
    }

    if(get_property('_monkeyPawWishesUsed').to_int() == 0 && my_inebriety() < 10 && have_effect($effect[refined palate]) == 0)
    {
        cli_execute('monkeypaw effect Refined Palate');
        while(my_inebriety() < 10)
        {
            ensure_song($effect[ode to booze]);
            drink(1, $item[sacramento wine]);
        }
    }
    else
    {
        if(get_property('_monkeyPawWishesUsed').to_int() == 0)
        {
            cli_execute('monkeypaw effect Braaaaaains');
        }
        
    }
    if(get_property('_monkeyPawWishesUsed').to_int() == 1)
    {
        cli_execute('monkeypaw effect Covetous Robbery');
    }
    if(get_property('_monkeyPawWishesUsed').to_int() == 2)
    {
        cli_execute('monkeypaw effect Sinuses For Miles');
    }
    if(get_property('_monkeyPawWishesUsed').to_int() == 3)
    {
        cli_execute('monkeypaw effect Frosty');
    }
    if(get_property('_monkeyPawWishesUsed').to_int() == 4)
    {
        cli_execute('monkeypaw effect Braaaaaains');
    }
    if(!get_property('_portableSteamUnitUsed').to_boolean())
    {
        use(1, $item[portable steam unit]);
    }
    if(get_property('_kgbClicksUsed').to_int() < 22)
    {
        cli_execute('briefcase collect; briefcase buff item;');
        while(get_property('_kgbClicksUsed').to_int() < 22) 
            cli_execute('briefcase buff meat');
    }
    while(get_property('_poolGames').to_int() < 3)
    {
        cli_execute('pool 1');
    }

    if(!contains_text(get_property('_beachHeadsUsed'), '10'))
    {
        cli_execute('beach head familiar');
    }
    if(!contains_text(get_property('boomBoxSong'), 'Total Eclipse of Your Meat')) {cli_execute('boombox meat');}
    if(!get_property('_witchessBuff').to_boolean())
    {
        cli_execute('witchess buff');
    }
}

void dailyFamiliarBuffs()
{
    if(!get_property('friarsBlessingReceived').to_boolean())
    {
        cli_execute('friars blessing familiar');
    }
    if(!get_property('_defectiveTokenUsed').to_boolean() && $item[defective game grid token].item_amount() > 0)
    {
        use(1, $item[defective game grid token]);
    }
}

void dailyItemBuffs()
{
if(!get_property('_legendaryBeat').to_boolean() && $item[The Legendary Beat].item_amount() > 0)
    {
        use(1, $item[The Legendary Beat]);
    }
    if(!get_property('_redwoodRainStickUsed').to_boolean() && $item[redwood rain stick].item_amount() > 0)
    {
        use(1, $item[redwood rain stick]);
    }
    if(get_property('_augSkillsCast') < 4 && !get_property('_aug7Cast').to_boolean())
    {
        use_skill(1, $skill[Aug. 7th: Lighthouse Day!]);
    }
}

void dailyEffects()
{
    while ( get_property("_feelDisappointedUsed").to_int() < 3 )
		use_skill(1,$skill[Feel Disappointed]);
    if(!get_property('_glennGoldenDiceUsed').to_boolean() && $item[glenn's golden dice].item_amount() > 0)
    {
        use(1, $item[glenn's golden dice]);
    }

    while (get_property('_campAwaySmileBuffs') < 3) 
    { 
        visit_url('place.php?whichplace=campaway&action=campaway_sky');
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

}

void gravitate() 
{
    while(have_skill($skill[Rainbow Gravitation]) 
        && get_property("prismaticSummons").to_int() < 3)
    {
        foreach key in $items[twinkly wad, hot wad, cold wad, spooky wad, stench wad, sleaze wad]
        {
            retrieve_item(1, key);
        }
            
        use_skill(1, $skill[rainbow gravitation]);
    }

}

void dailyItems()
{
    cli_execute('closet put * meat');
	cli_execute('closet take 5000000 meat');
    set_property('hpAutoRecovery', '0.8');
	set_property("hpAutoRecoveryTarget", "1.0");

    if($item[Draftsman's driving gloves].item_amount() == 0 &&
       $item[Nouveau nosering].item_amount() == 0 &&
       $item[Brutal brogues].item_amount() == 0)
    {
        cli_execute('bastille myst draftsman gesture');
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

    if(!get_property('_olympicSwimmingPoolItemFound').to_boolean())
    {
        cli_execute('swim item');
    }

    while(get_property('_candyEggsDeviled').to_int() < 3 && item_amount($item[candy egg deviler]) > 0 )
	{
		cli_execute('devilcandyegg angry farmer candy');
	}
    
    if(get_property('_saberMod') == 0)
    {
        MaySaber(4);
    }

    if (get_property("_internetPrintScreenButtonBought") == "false"
	&& $item[BACON].item_amount() > 111)
    {
        cli_execute("coinmaster buy bacon print screen button");
    }

    /*Get Guzzlr cocktail set*/
    if(get_property('_guzzlrPlatinumDeliveries') == 0
    && !get_property('_guzzlrQuestAbandoned').to_boolean())
    {
        visit_url("inventory.php?tap=guzzlr", false);
        run_choice(4); // take platinum quest
        wait(1); // mafia's tracking breaks occasionally if you go too fast.
        visit_url("inventory.php?tap=guzzlr", false);
        run_choice(1); // abandon
        run_choice(5); // leave the choice.
    }

    /*End Guzzlr*/
    if(get_property('_voteModifier') == '')
    {
        voteInVotingBooth();
    }
    
    if(get_property('_birdOfTheDay') == '')
    {
        use(1, $item[bird-a-day calendar]);
    }
    
    //Chateau juice bar
    if(!get_property('_chateauDeskHarvested').to_boolean())
    {
        visit_url('place.php?whichplace=chateau&action=chateau_desk2');
    }
    

    if(!get_property('_timeSpinnerReplicatorUsed').to_boolean())
        cli_execute('FarFuture drink');
    if(get_property('_horsery') == '')
    {
        cli_execute('horsery dark');
    }
    if($item[futuristic hat].available_amount() == 0)
    {
        use(1, $item[wardrobe-o-matic]);
    }
    
    if(get_property('_deckCardsDrawn').to_int() < 15 && !contains_text('_deckCardsSeen', 'Island')) { cli_execute('cheat Island');}
    if(get_property('_deckCardsDrawn').to_int() < 15 && !contains_text('_deckCardsSeen', 'Ancestral Recall')) { cli_execute('cheat Ancestral Recall');}
    if(get_property('_deckCardsDrawn').to_int() < 15 && !contains_text('_deckCardsSeen', 'Gift Card')) { cli_execute('cheat Gift Card');}

    while(get_property('_sourceTerminalExtrudes').to_int() < 3 && item_amount($item[source essence]) > 10) 
    { 
        cli_execute('terminal extrude booze.ext'); 
    }
    if(get_property('_clipartSummons').to_int() < 1)
    {
        cli_execute('make box of familiar jacks');
    }
    if(get_property('_clipartSummons').to_int() < 2)
    {
        cli_execute('make bucket of wine');
    }
    if(get_property('_clipartSummons').to_int() < 3)
    {
        cli_execute('make borrowed time');
    }

    if(!get_property('_pottedTeaTreeUsed').to_boolean())
    {
        cli_execute('teatree shake');
    }
    
    gravitate();
    
    
    if ( available_amount($item[fisherman's sack]) > 0 )
    {
        use(available_amount($item[fisherman's sack]),$item[fisherman's sack]);
    }

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
        if($familiar[Grey Goose].experience < 400)
        {
            use_familiar($familiar[Grey Goose]);
        }
        else if($familiar[Chest Mimic].experience < 550)
        {
            use_familiar($familiar[Chest Mimic]);
        }
        else 
        {
            use_familiar($familiar[Pocket Professor]);
        }
        cli_execute('mayam rings fur bottle yam clock');
    }

    if(!get_property('_leafDayShortenerCrafted').to_boolean() && item_amount($item[inflammable leaf]) > 222)
    {
        cli_execute('leaves day shortener');
    }

    while(get_property('_leafLassosCrafted').to_int() < 3 && item_amount($item[inflammable leaf]) > 69)
    {
        cli_execute('leaves lit leaf lasso');
    }

    if(!get_property('lockPicked').to_boolean())
	{
		if(item_amount($item[Boris's key lime pie]) <= item_amount($item[Sneaky Pete's key lime pie]) && item_amount($item[Boris's key lime pie]) <= item_amount($item[Jarlsberg's key lime pie]))
		{
			set_property('choiceAdventure1414', '1');
			use_skill($skill[Lock Picking]);
            if(item_amount($item[Boris's key]) > 0);
			cli_execute('make boris key lime pie');
		}
		else if(item_amount($item[Jarlsberg's key lime pie]) <= item_amount($item[Sneaky Pete's key lime pie]) && item_amount($item[Jarlsberg's key lime pie]) <= item_amount($item[Boris's key lime pie]))
		{
			set_property('choiceAdventure1414', '2');
			use_skill($skill[Lock Picking]);
            if(item_amount($item[jarlsberg's key]) > 0);
			cli_execute('make jarlsberg key lime pie');
		}
		else if(item_amount($item[Sneaky Pete's key lime pie]) <= item_amount($item[Boris's key lime pie]) && item_amount($item[Sneaky Pete's key lime pie]) <= item_amount($item[Jarlsberg's key lime pie]))
		{
			set_property('choiceAdventure1414', '3');
			use_skill($skill[Lock Picking]);
            if(item_amount($item[Sneaky Pete's key]) > 0);
			cli_execute('make sneaky pete key lime pie');
		}
	}

    if(!get_property('_candyCaneSwordOvergrownShrine').to_boolean())
    {
        equip($slot[weapon], $item[candy cane sword cane]);
        visit_url('adventure.php?snarfblat=348');
        run_choice(4);
        run_choice(6);
    }

    if(get_property('_bittycar') == '' && item_amount($item[bittycar meatcar]) > 0)
    {
        use(1, $item[bittycar meatcar]);
    }

    set_auto_attack(0);
}


void main()
{
    dailyEffects();
    dailyItems();
}