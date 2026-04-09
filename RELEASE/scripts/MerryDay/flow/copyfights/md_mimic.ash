script md_mimic;
import md_outfit;
import ff_witchess;

boolean mimic_can()
{
    return get_property('_mimicEggsObtained').to_int() < 11 && witchess_can();
}

void mimic_run()
{
    item[slot] required_equips;
    if(have_effect($effect[Everything Looks Purple]) == 0)
    {
        required_equips[$slot[off-hand]] = $item[roman candelabra];
    }
    
    if(get_property('_sourceTerminalDigitizeUses').to_int() < 3)
    {
        if(get_property('sourceTerminalEducate1') != 'digitize.edu'
            && get_property('sourceTerminalEducate2') != 'digitize.edu')
        {
            cli_execute('terminal educate digitize.edu');
        }        
    }

    construct_free_outfit(required_equips, $familiar[chest mimic]);
    set_auto_attack('MimicEggs');
    witchess_run();
    set_auto_attack(0);
}

boolean mimic_can(monster it)
{
    return false;
}

boolean mimic_run(monster it)
{

}

void main()
{
    if(mimic_can())
    {
        mimic_run();
    }
}