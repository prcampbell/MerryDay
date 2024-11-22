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


boolean embezzlers_run()
{
    set_auto_attack('BackupMeat');
    if(august_can())
        august_run();
    while(sax_can())
        sax_run();
    if(hotdog_can())
        hotdog_run();
    set_auto_attack(0);
    return true;
}

void main()
{
    embezzlers_run();
}