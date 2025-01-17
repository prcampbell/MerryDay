script md_melf;
import md_outfit;

boolean melf_can()
{
    return get_property('_machineTunnelsAdv') < 5;
}

boolean melf_run()
{
    use_familiar($familiar[Machine Elf]);
    if (get_property('encountersUntilDMTChoice') == 0 && get_property('knownAscensions') > get_property('lastDMTDuplication')) 
    {
        //Karma Schwarma - 7797
        //Warbear Gyro - 7050
        set_property('choiceAdventure1119', '4');
        set_property('choiceAdventure1125', '1&iid=7050');
        adv1($location[The Deep Machine Tunnels], -1, '');
        set_property('choiceAdventure1119', '5');
    }
    return adv1($location[The Deep Machine Tunnels], -1, "");
}

void main()
{
    if(melf_can())
    {
        set_auto_attack('StasisFight');
        construct_free_outfit();
        melf_run();
        set_auto_attack(0);
    }
        
}  


