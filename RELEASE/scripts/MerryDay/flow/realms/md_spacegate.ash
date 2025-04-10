import md_outfit;


void main()
{

    cli_execute('spacegate destination GRIMACE; acquire exo-servo leg braces');
    item[slot] required_equips;
    required_equips[$slot[pants]] = $item[acquire exo-servo leg braces];
    construct_free_outfit(required_equips, ChooseFamiliar());
}

