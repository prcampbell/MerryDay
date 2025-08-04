script ff_speakeasy;

boolean speakeasy_can()
{
    return get_property('_speakeasyFreeFights').to_int() < 3;
}

boolean speakeasy_run()
{
    if(item_amount($item[government per-diem]) > 0 && get_property('_speakeasyFreeFights').to_int() < 3)
        use(1, $item[government per-diem]);
    return adv1($location[an unusually quiet barroom brawl], -1, '');
}