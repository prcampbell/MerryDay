script ff_rifts;

import md_outfit;
import md_familiars;

location constructRift(string container)
{
    return to_location("Shadow Rift (" + container + ")");
}

location get_rift(string container)
{
    location loc;
    switch(container) 
    {
        case "desertbeach" :
            loc = constructRift("Desert Beach");
            break;
        case "forestvillage" :
            loc =  constructRift("Forest Village");
            break;
        case "mclargehuge" :
            loc =  constructRift("Mt. McLargeHuge"); 
            break;       
        case "beanstalk" :
            loc =  constructRift("Somewhere Over the Beanstalk");
            break;
        case "loc = " :
            loc =  constructRift("Spookyraven Manor Third Floor");
            break;
        case "8bit" : 
            loc =  constructRift("The 8-Bit Realm");
            break;
        case "pyramid" :
            loc =  constructRift("The Ancient Buried Pyramid");
            break;
        case "giantcastle" :
            loc =  constructRift("The Castle in the Clouds in the Sky");
            break;
        case "woods" :
            loc =  constructRift("The Distant Woods");
            break;
        case "hiddencity" :
            loc =  constructRift("The Hidden City");
            break;
        case "cemetery" :
            loc =  constructRift("The Misspelled Cemetary");
            break;
        case "plains" :
            loc =  constructRift("The Nearby Plains");
            break;
        case "town_right" :
            loc =  constructRift("The Right Side of the Tracks");
            break;
        case "" :
            abort('Cannot construct a proper Shadow Rift');
        
            break;
    }
    return loc;
}

location riftIngressByItem(item it)
{
    if($items[shadow ice, shadow fluid, shadow glass] contains it)
    {
        return $location[Shadow Rift (The 8-Bit Realm)];
    }
    else if($items[shadow sausage, shadow brick, shadow sinew] contains it)
    {
         return $location[Shadow Rift (The Ancient Buried Pyramid)];
    }
    else if($items[shadow brick, shadow sinew, shadow nectar] contains it)
    {
         return $location[Shadow Rift (The Hidden City)];
    }
    else if($items[shadow bread, shadow brick, shadow stick] contains it)
    {
         return $location[Shadow Rift (The Misspelled Cemetary)];
    }
    else if($items[shadow fluid, shadow glass, shadow nectar] contains it)
    {
         return $location[Shadow Rift (Somewhere Over the Beanstalk)];
    }
    else if($items[shadow sausage, shadow bread, shadow fluid] contains it)
    {
         return $location[Shadow Rift (The Castle in the Clouds in the Sky)];
    }
    else if($items[shadow flame, shadow fluid, shadow sinew] contains it)
    {
         return $location[Shadow Rift (Desert Beach)];
    }
    else if($items[shadow flame, shadow nectar, shadow stick] contains it)
    {
         return $location[Shadow Rift (The Distant Woods)];
    }
    else if($items[shadow bread, shadow ice, shadow venom] contains it)
    {
         return $location[Shadow Rift (Forest Village)];
    }
    else if($items[shadow skin, shadow ice, shadow stick] contains it)
    {
         return $location[Shadow Rift (Mt. McLargeHuge)];
    }
    else if($items[shadow sausage, shadow skin, shadow venom] contains it)
    {
         return $location[Shadow Rift (The Nearby Plains)];
    }
    else if($items[shadow skin, shadow bread, shadow glass] contains it)
    {
         return $location[Shadow Rift (The Right Side of the Tracks)];
    }
    else if($items[shadow sausage, shadow flame, shadow venom] contains it)
    {
         return $location[Shadow Rift (Spookyraven Manor Third Floor)];
    }
    else 
    {
        return $location[Shadow Rift (The Misspelled Cemetary)];
    }
}
location riftIngress()
{
    return riftIngressByItem($item[shadow brick]);
}

boolean shadowrifts_can()
{
    return !get_property('_shadowAffinityToday').to_boolean() 
            || have_effect($effect[shadow affinity]) > 0 
            || item_amount($item[Rufus's shadow lodestone]) > 1
            || (get_property('rufusQuestType') == 'artifact' && item_amount(get_property('rufusQuestTarget').to_item()) > 0)
            || (get_property('rufusQuestType') == 'items' && item_amount(get_property('rufusQuestTarget').to_item()) >= 3)
            || get_property('encountersUntilSRChoice').to_int() == 0;
}

boolean rifts_run()
{
    /*
    if(get_property('rufusQuestType') == 'items' && item_amount(get_property('rufusQuestTarget').to_item()) <= 3)
    {
        buy(3, get_property('rufusQuestTarget').to_item());
    }
    */
    if(have_effect($effect[shadow affinity]) == 0 && !get_property('_shadowAffinityToday').to_boolean())
    {
        use(1, $item[closed-circuit pay phone]);
    }
    if(get_property('rufusQuestType') == 'artifact' && item_amount(get_property('rufusQuestTarget').to_item()) > 0)
    {
        use(1, $item[closed-circuit pay phone]);
    }
    if(get_property('rufusQuestType') == 'items')
    {
        if(item_amount(get_property('rufusQuestTarget').to_item()) <= 3)
        {
            buy(3, get_property('rufusQuestTarget').to_item());
        }
        use(1, $item[closed-circuit pay phone]);
    }
    if(get_property('encountersUntilSRChoice').to_int() == 0)
        return adv1($location[Shadow Rift (The Misspelled Cemetary)]);
    if(have_effect($effect[shadow affinity]) == 0 && item_amount($item[Rufus's shadow lodestone]) == 0)
        abort('Attempting to adventure in a Shadow Rift without affinity or lodestone');
    return adv1($location[Shadow Rift (The Misspelled Cemetary)]);
}

boolean shadowwaters_can()
{
    return have_effect($effect[shadow waters]) < my_adventures();
}

boolean shadowwaters_run()
{
    if(get_property('questRufus') == 'unstarted')
    {
        use(1, $item[closed-circuit pay phone]);
    }
    if(shadowrifts_can())
        return rifts_run();
    return false;
}

void main()
{
    while(shadowrifts_can())
    {
        set_auto_attack('StasisFight');
        familiarDrops();
        construct_free_outfit();
        rifts_run(); 
        set_auto_attack(0);
    }
    if(shadowwaters_can())
        shadowwaters_run();
}

/*
static ShadowRift[] allRifts = {
    // These are sorted by container name. Not that it matters.
    makeShadowRift("desertbeach", "Desert Beach", "flame", "fluid", "sinew"),
    makeShadowRift("forestvillage", "Forest Village", "bread", "ice", "venom"),
    makeShadowRift("mclargehuge", "Mt. McLargeHuge", "skin", "ice", "stick"),
    makeShadowRift("beanstalk", "Somewhere Over the Beanstalk", "fluid", "glass", "nectar"),
    makeShadowRift("manor3", "Spookyraven Manor Third Floor", "sausage", "flame", "venom"),
    makeShadowRift("8bit", "The 8-Bit Realm", "ice", "fluid", "glass"),
    makeShadowRift("pyramid", "The Ancient Buried Pyramid", "sausage", "brick", "sinew"),
    makeShadowRift("giantcastle", "The Castle in the Clouds in the Sky", "sausage", "bread", "fluid"),
    makeShadowRift("woods", "The Distant Woods", "flame", "nectar", "stick"),
    makeShadowRift("hiddencity", "The Hidden City", "brick", "sinew", "nectar"),
    makeShadowRift("cemetery", "The Misspelled Cemetary", "bread", "brick", "stick"),
    makeShadowRift("plains", "The Nearby Plains", "sausage", "skin", "venom"),
    makeShadowRift("town_right", "The Right Side of the Tracks", "skin", "bread", "glass"),
};*/

