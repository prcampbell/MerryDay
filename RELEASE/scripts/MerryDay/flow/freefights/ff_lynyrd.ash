script ff_lynyrd;

boolean lynyrd_can()
{
    return get_property('_lynyrdSnareUses').to_int() < 3;
}

boolean lynyrd_run()
{
    return use(1, $item[lynyrd snare]);
}