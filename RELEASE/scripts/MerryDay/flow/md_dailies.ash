/*
Pantogram
ChibiBuddy
Refresh Latte
Free Goofballs
Horsery
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
April Instrument
Mayam Calendar
Cheat Cards
Extrude Items
Pick Cargo Pocket
Clip Art
Mr. Store Catalogue
Chateau Desk
Kremlin's Briefcase
Swimming Pool Item
Internet Meme Shop
Rainbow Gravitation
Tea Trea
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
Equip Shorter Order Cook with Blue Plate
Mummery Meat - Jill
Mummery Item - Tot
Moveable Feast
    - Pocket Professor
    - Bandersnatch
    - Jill
tiny stillsuit - Slimeling
*/

import "VotingBooth.ash";


void Morning()
{
    set_property('hpAutoRecovery', '0.8');
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

    
    
    cli_execute('breakfast');
    
    set_auto_attack(0);
}


void main()
{
    Morning();
}