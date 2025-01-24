script ff_rifts;

import md_outfit;
import md_familiars;

boolean shadowrifts_can()
{
    return !get_property('_shadowAffinityToday').to_boolean() 
            || have_effect($effect[shadow affinity]) > 0 
            || item_amount($item[Rufus's shadow lodestone]) > 1
            || (item_amount(get_property('rufusQuestTarget').to_item() >= 3 && get_property('rufusQuestType') == 'artifact'));
}

boolean shadowrifts_run()
{
    //set prefrence to items
    use(1, $item[closed-circuit pay phone]);
    //dress up for free fights
    //adventure in a shadow rift
    //NC => Add 3 turns of 3 random effects
    //Lodestone => Forest
    return true;
}

boolean rifts_can()
{
    return false;
}

boolean rifts_run()
{
    if(item_amount(get_property('rufusQuestTarget').to_item()) && get_property('rufusQuestType') == 'artifact')
    {
        use(1, $item[closed-circuit pay phone]);
    }
    return adv1($location[Shadow Rift (The Misspelled Cemetary)]);
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
    
}


