script md_embezzlers;

/*

basemeat (1000) * % meat gain * number of embezzlers (5)

*/

/*
150 | 20 turns - sorority brain
100 | 100 turns - Always be Collecting
100 | 30 turns - battery (car)
100 | 20 turns - flapper fly
60 | 40 turns - Smoldering Clover candle
55 | 10 turns - Polka Pop
50 | 20 turns - red snowcone
50 | 10 turns - peppermint twist
50 | 20 turns - Meat-inflating powder
50 | 20 turns airborne mutagen
50 | 30 turns - cuppa Chari tea
50 | 30 turns - patent avarice tonic
50 | 30 turn - cursed wishbone
50 | 30 turns - savings bond
50 | 30 turns - autumn dollar
40 | 20 turns - blue grass
30 | 20 turns - pink-frosted astral cupcake
30 | 10 turns - begpwnia
30 | 20 turns - resolution: be wealthier
25 | 30 turns - salt wages
20 | 10 turns - bag of Cheat-Os
20 | 10 turns - pink candy heart
20 | 10 turns - blackberry polite
20 | 15 turns - shark cartilage
20 | 1 turn - holly-flabored Hob-O
20 | 10 turns - fudge-shaped hole in space-time
20 | 20 turns - tin cup
20 | 30 turns - Gene Tonic: Humanoid
can of v-11
cranberry cordial
baggie of powdered sugar
resolution: be luckier
disco horoscope
jug of porquoise juice
flask of porquoise juice
vial of proquoise juice

*/
//warbear liquid lasers
//Gene Tonic: Constellation
//Gene Tonic: Fish
//irradiated pet snacks
//stephen's secret formula
//dog ointment
//gingerbread spice latte
//short stack of pancakes




void embezzler_potions(int numberOfEmbezzlers, int meatDrop)
{
    foreach it in $items[]
    {
        if(item_type(it) == 'potion' && numeric_modifier(effect_modifier(it, "effect"), "meat drop") > 0)
        {
            if ((meatDrop * (numeric_modifier(effect_modifier(it, "effect"), "meat drop") / 100) * numberOfEmbezzlers) > mall_price(it))
                use(1, it);
        }
    }
    if(contains_text(get_property('_birdOfTheDayMods'), 'Meat Drop') && my_mp() >= 425)
    {
        while(get_property('_birdsSoughtToday') < 6)
        {
            use_skill(1, $skill[Seek out a Bird]);
        }
    }
    if(have_effect($effect[Kicked in the Sinuses]) == 0 && item_amount($item[jumping horseradish]) > 0 && my_fullness() < fullness_limit())
    {
        eat(1, $item[jumping horseradish]);
    }
    if(have_effect($effect[Inspired Chef]) == 0 && (item_amount($item[boris's bread]) > 0 || item_amount($item[yeast of boris]) > 1) && my_fullness() < fullness_limit())
    {
        eat(1, $item[boris's bread]);
    }
    if(have_effect($effect[all blued up]) == 0 && item_amount($item[blueberry muffin]) > 0 && my_fullness() < fullness_limit())
    {
        eat(1, $item[blueberry muffin]);
    }

    if(have_effect($effect[Synthesis: Greed]) == 0 && my_spleen_use() < spleen_limit())
    {
        cli_execute('synthesize greed');
    }
    if(have_effect($effect[boxing day glow]) == 0 && my_spleen_use() < spleen_limit())
    {
        chew(1, $item[body spradium]);
    }

}

boolean august_can()
{
    if(!get_property('_aug2Cast').to_boolean() 
        && get_property('_augSkillsCast').to_int() < 5)
        return true;
    else 
        return false;
}

boolean august_run()
{
    use_skill(1, $skill[Aug. 2nd: Find an Eleven-Leaf Clover Day]);
    
    return adv1($location[Cobb's Knob Treasury], -1, '');
}

boolean sax_can()
{
    return get_property('_aprilBandSaxophoneUses').to_int() < 3 && item_amount($item[apriling band saxophone]) > 0;
}

boolean sax_run()
{
    cli_execute('aprilband play sax');
    return adv1($location[Cobb's Knob Treasury], -1, '');
}

boolean hotdog_can()
{
    return item_amount($item[tattered scrap of paper]) > 25 && get_clan_id() == 84165;
}

boolean hotdog_run()
{
    visit_url('clan_viplounge.php?preaction=hotdogsupply&whichdog=-102&quantity=25');
    visit_url('clan_viplounge.php?preaction=eathotdog&whichdog=-102');
    if(have_effect($effect[Lucky!]) > 0)
    {
        return adv1($location[Cobb's Knob Treasury], -1, '');
    }
    else
    {
        return false;
    }
}

boolean pillkeeper_can()
{
    return !get_property('_freePillKeeperUsed').to_boolean();
}

boolean pillkeeper_run()
{
    cli_execute('pillkeeper free lucky');
    return adv1($location[Cobb's Knob Treasury], -1, '');
}

boolean embezzlers_can()
{
    return august_can() && sax_can() && pillkeeper_can();
}


boolean embezzlers_run()
{
    embezzler_potions(6, 1000);
    use_familiar($familiar[jill-of-all-trades]);
    maximize('meat drop, switch hobo monkey', false);
    set_auto_attack('BackupMeat');
    if(august_can())
        august_run();
    while(sax_can())
        sax_run();
    if(pillkeeper_can())
        pillkeeper_run();
    if(hotdog_can())
        hotdog_run();
    set_auto_attack(0);
    return true;
}

void main()
{
    embezzlers_run();
}