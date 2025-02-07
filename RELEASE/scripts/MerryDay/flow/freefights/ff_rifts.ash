script ff_rifts;

import md_outfit;
import md_familiars;

boolean shadowrifts_can()
{
    return !get_property('_shadowAffinityToday').to_boolean() 
            || have_effect($effect[shadow affinity]) > 0 
            || item_amount($item[Rufus's shadow lodestone]) > 1
            || (get_property('rufusQuestType') == 'artifact' && item_amount(get_property('rufusQuestTarget').to_item()) > 0)
            || (get_property('rufusQuestType') == 'items' && item_amount(get_property('rufusQuestTarget').to_item()) >= 3)
            || get_property('_shadowRiftCombats').to_int() == 11;
}

boolean rifts_run()
{
    if(have_effect($effect[shadow affinity]) == 0 && !get_property('_shadowAffinityToday').to_boolean())
    {
        use(1, $item[closed-circuit pay phone]);
    }
    if(get_property('rufusQuestType') == 'artifact' && item_amount(get_property('rufusQuestTarget').to_item()) > 0)
    {
        use(1, $item[closed-circuit pay phone]);
    }
    if(get_property('rufusQuestType') == 'items' && item_amount(get_property('rufusQuestTarget').to_item()) >= 3)
    {
        use(1, $item[closed-circuit pay phone]);
    }
    if(get_property('_shadowRiftCombats').to_int() == 11)
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


