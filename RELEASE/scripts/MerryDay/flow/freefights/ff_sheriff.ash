script ff_sheriff;
import md_outfit;
import md_library.ash;
import md_free.ash;

boolean sheriff_can()
{
    return get_property('_assertYourAuthorityCast').to_int() < 3;
}

boolean get_sheriff()
{
    if(item_amount($item[sheriff badge]) == 1 
        && item_amount($item[sheriff pistol]) == 1
        && item_amount($item[sheriff moustache]) == 1)
    {
        return true;
    }

    int tmp = get_clan_id();
    if(tmp != VIPClan)
    {
        switchClan(VIPClan);
    }

    foreach it in $items[Sheriff badge,Sheriff pistol,Sheriff moustache]
    {
        cli_execute("photobooth item "+to_string(it));
    }

    switchClan(tmp);
    return item_amount($item[sheriff badge]) == 1 
        && item_amount($item[sheriff pistol]) == 1
        && item_amount($item[sheriff moustache]) == 1;
}

boolean sheriff_run()
{
    print('Free Fight: Sheriff','blue');
    location target = wandererLocation();
    item[slot] sheriff_equips = LocationNeeds(target);
    string macro = 'skill 7532;';
    if(sheriff_equips[$slot[weapon]] != $item[none]
        && sheriff_equips[$slot[acc1]] != $item[none]
        && sheriff_equips[$slot[acc2]] != $item[none])
    {
        target = defaultTargetLocation();
    }
    sheriff_equips[$slot[acc1]] = $item[sheriff moustache];
    sheriff_equips[$slot[acc2]] = $item[sheriff badge];
    sheriff_equips[$slot[weapon]] = $item[sheriff pistol];
    
    get_sheriff();
    construct_free_outfit(sheriff_equips);

    return adv1(target, -1, macro);
}

void main()
{
    if(sheriff_can())
    {
        sheriff_run();
    } 
}