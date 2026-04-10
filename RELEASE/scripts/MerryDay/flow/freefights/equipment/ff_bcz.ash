script ff_bcz;

import md_outfit;
import md_library.ash;
import md_free.ash;

boolean bcz_can()
{
    return get_property('_bczSweatBulletsCasts') < 5 && my_basestat($stat[moxie]) >= 201;
}

boolean bcz_run()
{
    print('Free Fight : BCZ: Sweat Bullets', 'blue');
    location target = wandererLocation();
    item[slot] required_equips = LocationNeeds(target);
    string macro = 'skill 7573;';
    if(required_equips[$slot[acc3]] != $item[none])
    {
        target = defaultTargetLocation();
    }

    required_equips[$slot[acc3]] = $item[blood cubic zirconia];
    

    construct_free_outfit(required_equips);

    if(get_auto_attack() != 0)
        set_auto_attack(0);

    return adv1(target, -1, macro);
}


