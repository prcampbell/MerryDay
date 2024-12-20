void main()
{
    if(item_amount($item[autumn-aton]) > 0)
    {
        cli_execute('fallguy send Shadow Rift');
    }
    if(get_property('_batWingsFreeFights').to_int() < 5)
        equip($slot[back], $item[bat wings]);
    else
        equip($slot[back], $item[buddy bjorn]);

    if(have_effect($effect[everything looks yellow]) == 0)
        equip($slot[shirt], $item[jurassic parka]);
    else
        equip($slot[shirt], $item[hodgman's disgusting technicolor overcoat]);

    if(have_effect($effect[everything looks red]) == 0)
        equip($slot[acc1], $item[everfull dart holster]);
    else 
        equip($slot[acc1], $item[mafia thumb ring]);
}