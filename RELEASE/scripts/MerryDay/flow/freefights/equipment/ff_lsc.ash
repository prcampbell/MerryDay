script ff_lsc;

import md_outfit;
import md_library.ash;


boolean lcs_can()
{
    return get_property('_clubEmTimeUsed') < 5;
}

boolean lcs_run()
{
    print('Free Fight : LEGENDARY seal-clubbing club', 'blue');
    location target = wandererLocation();
    item[slot] required_equips = LocationNeeds(target);
    string macro = 'skill 7584;';
    if(required_equips[$slot[weapon]] != $item[none])
    {
        target = defaultTargetLocation();
    }

    required_equips[$slot[weapon]] = $item[legendary seal-clubbing club];
    

    construct_free_outfit(required_equips);

    if(get_auto_attack() != 0)
        set_auto_attack(0);

    return adv1(target, -1, macro);
}


