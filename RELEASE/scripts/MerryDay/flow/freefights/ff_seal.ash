void acquire_seal_items()
{
    if(item_amount($item[seal-blubber candle]) < 10 - get_property('_sealsSummoned').to_int())
    {
        buy(10 - get_property('_sealsSummoned').to_int(), $item[seal-blubber candle]);
    }
    if(item_amount($item[figurine of a wretched-looking seal]) < 10 - get_property('_sealsSummoned').to_int())
    {
        buy(10 - get_property('_sealsSummoned').to_int(), $item[figurine of a wretched-looking seal]);
    }
}

boolean seal_can()
{
    return get_property('_sealsSummoned').to_int() < 10 
        && my_class() == $class[seal clubber];
}

boolean seal_run()
{
    acquire_seal_items();
    return use(1, $item[figurine of a wretched-looking seal]);
}