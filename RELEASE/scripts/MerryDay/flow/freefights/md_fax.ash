script md_fax;

import md_outfit;

boolean fax_can()
{
    return !get_property('_photocopyUsed').to_boolean() && get_property('camelSpit').to_int() >= 100;
}

boolean fax_run()
{
    cli_execute('chat; faxbot blur');
    item[slot] required_equips;
    required_equips[$slot[off-hand]] = $item[april shower thoughts shield];
    construct_free_outfit(required_equips, $familiar[melodramedary]);
    set_auto_attack('DramaticShower');
    use(1, $item[photocopied monster]);
    set_auto_attack(0);
}

void main()
{
    if(fax_can())
        fax_run();
}