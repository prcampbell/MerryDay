script ff_rifts;

boolean shadowrifts_can()
{
    return !get_property('_shadowAffinityToday').to_boolean() 
            || have_effect($effect[shadow affinity]) > 0 
            || item_amount($item[shadow lodestone]) > 1;
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

}

boolean rifts_run()
{
    return adv1($location[Shadow Rift (The Misspelled Cemetary)]);
}

void main()
{
    if(rifts_can())
        rifts_run();
}
