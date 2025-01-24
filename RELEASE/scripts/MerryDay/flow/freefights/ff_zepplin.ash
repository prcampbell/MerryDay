script ff_zeppelin;

boolean zeppelin_can()
{
    return get_property('_glarkCableUses').to_int() < 5 && item_amount($item[glark cable]) > 0;
}

boolean zeppelin_run()
{
    return adv1($location[the red zeppelin], -1, 'use glark cable;');
}