void main()
{
    if(have_effect($effect[everything looks yellow]) == 0 && !have_equipped($item[jurassic parka]))
        equip($slot[shirt], $item[jurassic parka]);
    else if(!have_equipped($item[hodgman's disgusting technicolor overcoat]))
        equip($slot[shirt], $item[hodgman's disgusting technicolor overcoat]);

    if(have_effect($effect[everything looks red]) == 0 && !have_equipped($item[everfull dart holster]))
        equip($slot[acc1], $item[everfull dart holster]);
    else if(!have_equipped($item[mafia thumb ring]))
        equip($slot[acc1], $item[mafia thumb ring]);
}