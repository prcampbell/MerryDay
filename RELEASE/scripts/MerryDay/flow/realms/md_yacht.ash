script md_yacht;

import md_library.ash;
import md_mpburn;
import md_outfit.ash;

void yacht_outfit(familiar fam)
{
    use_familiar(fam);
    equip($slot[hat], $item[Apriling band helmet]);

    equip($slot[weapon], $item[angelbone totem]);
    equip($slot[off-hand], $item[latte lovers member's mug]);

    equip($slot[back], $item[elf guard scuba tank]);
    equip($slot[shirt], $item[devilbone corset]);
    equip($slot[pants], $item[devilbone greaves]);

    equip($slot[acc1], $item[angelbone chopsticks]);
    equip($slot[acc2], $item[angelbone dice]);
    equip($slot[acc3], $item[devilbone rosary]);

    equip($slot[familiar], $item[amulet coin]);
    
}

void yacht_outfit()
{
    yacht_outfit($familiar[urchin urchin]);
}

boolean fishy_can()
{
    return !get_property('_fishyPipeUsed').to_boolean();
}

boolean clara_nc_can()
{
    return !get_property('_claraBellUsed').to_boolean();
}

boolean tuba_nc_can()
{
    return get_property('_aprilBandTubaUses').to_int() < 3 
            && item_amount($item[apriling band tuba]) > 0;
}

boolean cinch_nc_can()
{
    return get_property('_cinchUsed') <= 40;
}

boolean nc_can()
{
    return get_property('noncombatForcerActive').to_boolean()
            || clara_nc_can()
            || tuba_nc_can()
            || cinch_nc_can();
}

boolean fishy_get()
{
    print('trying to use the fishy pipe', 'blue');
    if(!get_property('_fishyPipeUsed').to_boolean())
        return use(1, $item[fishy pipe]);
    return have_effect($effect[fishy]) > 0;
}

boolean yacht_can()
{
    return nc_can() && (have_effect($effect[fishy]) > 0 || fishy_get());
}

boolean yacht_double_can()
{
    return nc_can();
}

boolean force_nc()
{
    if(get_property('noncombatForcerActive').to_boolean())
    {
        return true;
    }
    if(cinch_nc_can())
    {
        print('forcing NC with cincho', 'blue');
        equip($slot[acc3], $item[cincho de mayo]);
        use_skill(1, $skill[cincho: fiesta exit]);
        while(total_free_rests() > get_property('timesRested').to_int() && get_property('_cinchUsed').to_int() > 40)
        {
            LibramBurn();
            cli_execute('rest free');
        }
        return true;
    }
    if(clara_nc_can())
    {
        print('forcing NC with clara bell','purple');
        return use(1, $item[clara's bell]);
    }
    if(tuba_nc_can())
    {
        print('forcing NC with tuba','purple');
        return cli_execute('aprilband play tuba');
    }

    return false;
}

boolean yacht_double_run()
{
    if(force_nc())
    {
        use_familiar($familiar[urchin urchin]);
        yacht_outfit();
        return adv1($location[the sunken party yacht], -1, '');
    }
    return false;     
}

boolean yacht_run()
{   
    cli_execute('gain 1000 meat');
    yacht_outfit();
    return adv1($location[the sunken party yacht], -1, '');
}

boolean yacht_seal()
{
    if(my_class() != $class[seal clubber])
    {
        return false;
    }
    if(item_amount($item[spacegate research]) > 50 && my_inebriety() < inebriety_limit() - 2 && have_effect($effect[fishy]) < 8)
    {
        buy($coinmaster[spacegate fabrication facility], 1, $item[Centauri fish wine]);
        ensure_song($effect[ode to booze]);
        drink(1, $item[Centauri fish wine]);
    }
    
    if(item_amount($item[seal-blubber candle]) < 10 - get_property('_sealsSummoned').to_int())
    {
        buy(10 - get_property('_sealsSummoned').to_int(), $item[seal-blubber candle]);
    }
    if(item_amount($item[figurine of a wretched-looking seal]) < 10 - get_property('_sealsSummoned').to_int())
    {
        buy(10 - get_property('_sealsSummoned').to_int(), $item[figurine of a wretched-looking seal]);
    }

    while(get_property('_sealsSummoned').to_int() < 10
            && (get_property('_mcHugeLargeAvalancheUses').to_int() < 3
            || get_property('_spikolodonSpikeUses').to_int() < 5)
            )
    {
        if(get_property('noncombatForcerActive').to_boolean())
        {
            abort('You have a noncombat forcer active and started the loop again');
        }
        set_auto_attack('BasicBarf');
        if(get_property('_mcHugeLargeAvalancheUses').to_int() < 3)
        {
            print('NC Forced with Avalanche', 'blue');
            item[slot] required_equips;
            required_equips[$slot[weapon]] = $item[seal-clubbing club];
            required_equips[$slot[acc3]] = $item[McHugeLarge left ski];
            construct_free_outfit(required_equips, $familiar[chest mimic]);
            use(1, $item[figurine of a wretched-looking seal]);
        }
        else if(get_property('_spikolodonSpikeUses').to_int() < 5)
        {
            print('NC Forced with Spikes', 'blue');
            item[slot] required_equips;
            required_equips[$slot[weapon]] = $item[seal-clubbing club];
            required_equips[$slot[shirt]] = $item[jurassic parka];
            construct_free_outfit(required_equips, $familiar[chest mimic]);
            if(get_property('parkaMode') != 'spikolodon')
                cli_execute('parka spikolodon');
            use(1, $item[figurine of a wretched-looking seal]);
        }
        if(yacht_can())
            yacht_run();
        if(yacht_double_can())
            yacht_double_run();
    }

    return true;
    
}

boolean yacht_stench_can()
{
    return my_spleen_use() < spleen_limit()
        && mall_price($item[stench jelly]) < 2000
        && have_effect($effect[fishy]) > 0;
}

boolean yacht_stench_run()
{
    print('NC Forced with stench jelly from mall', 'blue');
    buy(1, $item[stench jelly]);
    chew(1, $item[stench jelly]);
    return yacht_run();
}

void yachting()
{
    
    while(yacht_can())
        yacht_run();
    yacht_seal();
    while(yacht_stench_can())
        yacht_stench_run();
    while(yacht_double_can())
        yacht_double_run();

    print('You cannot do yacht anymore','red');
}

boolean drunken_yacht()
{
    yacht_outfit();
    if(my_fullness() < fullness_limit())
    {
        eatWithHelper(1, $item[boris's bread]);
    }
    if(my_fullness() < fullness_limit())
    {
        eatWithHelper(1, $item[jumping horseradish]);
    }
    if(item_amount($item[spacegate research]) > 50 && my_inebriety() + 2 <= inebriety_limit())
    {
        buy($coinmaster[spacegate fabrication facility], 1, $item[Centauri fish wine]);
        ensure_song($effect[ode to booze]);
        drink(1, $item[Centauri fish wine]);
    }
    while(yacht_can())
    {
        if(force_nc())
            yacht_run();
        else 
        {
            print('Could not force NC, trying to seal club', 'red');
            break;
        }
    }
    yacht_seal();
    while(yacht_stench_can())
        yacht_stench_run();
}

boolean saber_can()
{
    return get_property('_saberForceUses').to_int() < 5;
}

void saber_run()
{
    set_property('battleAction', 'custom combat script');
    equip($slot[weapon], $item[Fourth of May Cosplay Saber]);
    set_auto_attack('UseTheForce');
    if(get_property('choiceAdventure1387').to_int() != 3)
        set_property('choiceAdventure1387', '3');

    while(get_property('_saberForceUses').to_int() < 5)
    {
        if(!get_property('_perilLocations').contains_text('403'))
        {
            buffer buf;
            print('Using the Force to get peril location 403', 'blue');
            equip($slot[acc1], $item[peridot of peril]);
            buf = visit_url($location[Sloppy Seconds Diner].to_url(),false,true);
            if(buf.contains_text("Nothing Could Be Finer"))
                buf = visit_url($location[Sloppy Seconds Diner].to_url(),false,true);
            
            visit_url("choice.php?pwd&whichchoice=1557&option=1&bandersnatch="+$monster[Sloppy Seconds Sundae].to_int(),true,true);
            
            if(handling_choice())
                run_choice(3);
            if(get_property('_saberForceUses').to_int() >= 5)
                break;
        }
        while(get_property('_monstersMapped').to_int() < 3 && !get_property('mappingMonsters').to_boolean())
        {
            buffer buf;
            use_skill(1,$skill[Map the Monsters]);

            buf = visit_url($location[Sloppy Seconds Diner].to_url(),false,true);
            if(buf.contains_text("Nothing Could Be Finer"))
                buf = visit_url($location[Sloppy Seconds Diner].to_url(),false,true);
            
            visit_url("choice.php?pwd&whichchoice=1435&option=1&heyscriptswhatsupwinkwink="+$monster[Sloppy Seconds Sundae].to_int(),true,true);
            if(handling_choice())
                run_choice(3);

            set_property('mappingMonsters', 'false');
            if(get_property('_saberForceUses').to_int() >= 5)
                break;
        }
        if(get_property('mappingMonsters').to_boolean())
        {
            visit_url("choice.php?pwd&whichchoice=1435&option=1&heyscriptswhatsupwinkwink="+$monster[Sloppy Seconds Sundae].to_int(),true,true);
            if(handling_choice())
                run_choice(3);
        }
        else 
        {
            adv1($location[Sloppy Seconds Diner]  , -1, '');
        }    
    }
    set_auto_attack(0);
    set_property('mappingMonsters', 'false');
}

void main()
{
    yachting();
}

