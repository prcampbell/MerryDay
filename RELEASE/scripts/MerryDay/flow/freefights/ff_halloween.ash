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
    return !get_property('_mapToACandyRichBlockUsed').to_boolean();
}

boolean halloween_map_use()
{
    if(item_amount($item[map to a candy-rich block]) > 1 && !get_property('_mapToACandyRichBlockUsed').to_boolean())
        use(1, $item[map to a candy-rich block]);
    else
        return false;
}

boolean halloween_outfit()
{
    //We should check what we want to grab here
    equip($slot[hat], $item[])
}

void do_house(string advstring, int i)
{
    if (advstring.contains_text("whichhouse="+i+">"))
    {
        advstring = visit_url("choice.php?whichchoice=804&pwd="+my_hash()+"&option=3&whichhouse="+i);
        
        if (advstring.contains_text("You can't go Trick-or-Treating without a costume!"))
            abort("You need a costume to trick-or-treat! Any normal outfit (Bugbear Costume, Mining Gear, etc.) counts as a costume."+((outfitted)?" Make sure your \"trick\" and \"treat\" outfits have costumes.":""));
        

        boolean revisit_block = true;
        int[item] candies;
        if (advstring.contains_text("A Fun-Size Dilemma"))
        {
            advstring = visit_url("choice.php?whichchoice=806&pwd="+my_hash()+"&option=2");
            print("House #"+(i+1)+" is the star house! Grabbed huge candy bowl.","blue");
            totalcandies["huge bowl of candy"] += 1;
        }
        else if (advstring.contains_text("You're fighting"))
        {
            if (advstring.contains_text("paulblart.gif") || advstring.contains_text("tooold.gif") || advstring.contains_text("vandalkid.gif"))
            {
                kandykolor = "orange";
                print("Battle! House #"+(i+1)+" contains "+get_monster(advstring)+".","orange");
                advstring = run_combat();
                post_combat_junk();
                if (contains_text(advstring,"You lose. You slink away, dejected and defeated."))
                    print("You're getting beaten up! Maybe you should change your CCS?");
                else
                    candies = extract_items(advstring);
            }
            else
            {
                if (advstring.contains_text("All-Hallow's Steve"))
                    abort("Encountered Steve, the hallowed boss! You'd better fight this guy yourself.");
                else
                    abort("Unidentified monster!");
            }
        }
        else
        {
            revisit_block = false;
            candies = extract_items(advstring);
        }
        foreach c in candies
        {
            totalcandies[c.to_string()] += candies[c];
            print("Looted "+((candies[c]!=1)?candies[c].to_string()+" ":"")+c+" from house #"+(i+1)+".",kandykolor);
            if (!revisit_block)
                is_candy[c.to_string()] = true;
        }
        if (revisit_block)
            advstring = trick_page();
    }
    else
        print("House #"+(i+1)+" has already been looted.","green");
}

boolean treat_run()
{



    //This is how to do combats
    string advstring = visit_url("place.php?whichplace=town&action=town_trickortreat");
    matcher housematch;
    for i from 0 to 11
    {
        housematch = create_matcher("whichhouse="+i+">[^>]*?house_d", advstring);
        if (advstring.contains_text("whichhouse="+i+">") && find(housematch))
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
                abort("Uh oh!");
            }
            advstring = visit_url("place.php?whichplace=town&action=town_trickortreat");
        }      
    }

    //This is how to do treats
    use_familiar($familiar[trick-or-treating tot]);
    cli_execute('outfit Ceramic Suit');
    string advstring = visit_url("place.php?whichplace=town&action=town_trickortreat");
    for i from 0 to 11
    {
        if (advstring.contains_text("whichhouse="+i+">"))
        {
            advstring = visit_url("choice.php?whichchoice=804&pwd="+my_hash()+"&option=3&whichhouse="+i);
            if (advstring.contains_text("A Fun-Size Dilemma"))
			{
				advstring = visit_url("choice.php?whichchoice=806&pwd="+my_hash()+"&option=2");
				print("House #"+(i+1)+" is the star house! Grabbed huge candy bowl.","blue");
			}
        }
        advstring = visit_url("place.php?whichplace=town&action=town_trickortreat");        
    }


        
}


void main()
{
    if(!halloween_available())
    {
        halloween_map_use();
    }
    item[slot] needs;
    needs[$slot[hat]] = $item[witch hat];
    construct_free_outfit($familiar[chest mimic]);
}