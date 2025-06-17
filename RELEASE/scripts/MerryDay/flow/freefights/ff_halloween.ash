script ff_halloween
import md_outfit.ash;

/*

1000 meat -- chocolate covered ping-pong ball (Trainbot Trappings)
1000 meat -- violent pastilles (Violent Vestments)
1066 meat -- exploding gum (The Jokester's Costume)
1111 meat -- roll of Hob-Os (Hodgman's Regal Frippery)
1331 meat -- Spant eggs (Spant Armor)
1332 meat -- Good 'n' Slimy (Slimesuit)
1420 meat -- herb brownies (Filthy Hippy Disguise)
1528 meat -- Wickers bar (Wicker Wear)
1568 meat -- fistful of wood shavings (Lathed Livery)
1700 meat -- groggipop (Crimbuccaneer rigging)
1800 meat -- cocoa chondrule (Meteor Masquerade)
1994 meat -- shadow candy (Shadow Shuit)
2100 meat -- fudge-shaped hole in space-time (Clothing of Loathing)
2196 meat -- Finnish Fish (Shallow Sea Fishing Outfit)
2222 meat -- Wrotz (Wrought Wrappings)
2547 meat -- worst candy (Hateful Habiliment)
2700 meat -- dubious peppermint (Wumpus-Hair Wardrobe)
2800 meat -- snowball (Snowman Suit)
2899 meat -- Flag by the Foot™ (Flagstone Finery)
3223 meat -- abandoned candy (El Vibrato Relics)
3500 meat -- Aerheads (Aeroutfit)
3750 meat -- terra panna cotta (Terra Cotta Tackle)
4334 meat -- Gabarbar (Gabardine Guise)
4748 meat -- porcelain candy dish (Ceramic Suit)

*/


boolean halloween_available()
{
    return get_property('_mapToACandyRichBlockUsed').to_boolean();
}

boolean halloween_map_use()
{
    if(item_amount($item[map to a candy-rich block]) > 1 && !get_property('_mapToACandyRichBlockUsed').to_boolean())
    {
        set_property('choiceAdventure804', '2');
        use(1, $item[map to a candy-rich block]);
        set_property('choiceAdventure804', '');
        return true;
    }
        
    else
        return false;
}

boolean halloween_outfit()
{
    //We should check what we want to grab here
    return false;
}



boolean treat_run()
{
    string advstring;
    string block = get_property('_trickOrTreatBlock');
    string[int] blockMap;
    item[slot] needs;

    advstring = visit_url("place.php?whichplace=town&action=town_trickortreat");
 
    for i from 0 to length(block) -1
    {
        blockmap[i] = char_at(block, i);
        if(blockmap[i] == 'L')
        {
            advstring = visit_url("choice.php?whichchoice=804&pwd="+my_hash()+"&option=3&whichhouse="+i);
            if (advstring.contains_text("A Fun-Size Dilemma"))
			{
				advstring = visit_url("choice.php?whichchoice=806&pwd="+my_hash()+"&option=2");
				print("House #"+(i+1)+" is the star house! Grabbed huge candy bowl.","blue");
			}
            advstring = visit_url("place.php?whichplace=town&action=town_trickortreat");
        }
    }
    
    return true;        
}

boolean trick_run()
{
    string advstring;
    string block = get_property('_trickOrTreatBlock');
    string[int] blockMap;
    item[slot] needs;
    needs[$slot[hat]] = $item[witch hat];
    construct_free_outfit(needs, $familiar[chest mimic]);
    set_auto_attack('StasisFight');

    advstring = visit_url("place.php?whichplace=town&action=town_trickortreat");
 
    for i from 0 to length(block) -1
    {
        blockmap[i] = char_at(block, i);
        if(blockmap[i] == 'D')
        {
            advstring = visit_url("choice.php?whichchoice=804&pwd="+my_hash()+"&option=3&whichhouse="+i);
            if (advstring.contains_text("paulblart.gif") || advstring.contains_text("tooold.gif") || advstring.contains_text("vandalkid.gif"))
            {
                print("Battle! House #"+(i+1)+" contains a TT monster.","orange");
                advstring = run_combat();
                if (contains_text(advstring,"You lose. You slink away, dejected and defeated."))
                    abort("You're getting beaten up! Maybe you should change your CCS?");
            }
            else
            {
                abort("Uh oh! Met something unexpected!");
            }
            advstring = visit_url("place.php?whichplace=town&action=town_trickortreat");
        }
    }
    set_auto_attack(0);
    return true;
}


void main()
{
    if(!halloween_available())
    {
        halloween_map_use();
    }
    if(!halloween_available())
    {
        trick_run();
    }
    
}