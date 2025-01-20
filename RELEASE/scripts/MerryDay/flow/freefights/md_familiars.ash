script md_familiars;

import md_library;
import ff_glitch;
import ff_lov;
import ff_tentacle;
import ff_leaves;
import ff_lynyrd;

boolean familiarDrops()
{
    foreach f in $familiars[Li'l Xenomorph, Baby Sandworm, Rogue Program,  Astral Badger, Green Pixie, Llama lama, Blavious Kloop]
    if ( have_familiar(f) && f.drops_today < 1 )
        return use_familiar(f);
    if ( have_familiar(f) && f.drops_today < f.drops_limit )
        return use_familiar(f);
    if(get_property(' _catBurglarCharge').to_int() < 10)
        return use_familiar($familiar[cat burglar]) && equip($item[burglar sleep mask]);
    if(get_property('camelSpit').to_int() < 100)
        return use_familiar($familiar[Melodramedary]) && equip($item[dromedary drinking helmet]);
    return use_familiar($familiar[Obtuse Angel]);
}

boolean familiarToFatten()
{
    if($familiar[frumious bandersnatch].experience < 400)
    {
        return use_familiar($familiar[frumious bandersnatch]);
    }
    else if($familiar[pocket professor].experience < 400)
    {
        return use_familiar($familiar[pocket professor]);
    }
    else if($familiar[chest mimic].experience < 400)
    {
        return use_familiar($familiar[chest mimic]);
    }
    else if($familiar[grey goose].experience < 400)
    {
        return use_familiar($familiar[grey goose]);
    }
    return false;
} 

boolean familiars_should()
{
    return $familiar[pocket professor].experience < 400 || $familiar[chest mimic].experience < 400 || $familiar[grey goose].experience < 400;
}

boolean familiar_adv()
{
    if(LOV_can())
    {
        return LOV_run();
    } 
    if(glitch_reward_fight_can())
    {
        return glitch_reward_fight_run();
    }
    if(get_property('_speakeasyFreeFights').to_int() < 3)
    {
        return adv1($location[an unusually quiet barroom brawl], -1, '');
    }
    if(tentacle_skill_fight_can())
    {
        return tentacle_skill_fight_run();
    }
    if(tentacle_fight_can())
    {
        return tentacle_fight_run();
    }
    if(leaves_can())
    {
        return leaves_run();
    }
    if(lynyrd_can())
    {
        return lynyrd_run();
    }
    return false;
}

boolean familiars_run()
{
    while(familiars_should())
    {
        if(familiarToFatten())
        {
            if(!get_property('_madTeaParty').to_boolean() )
            {
                cli_execute('hatter 6');
            }
            if(!get_property('friarsBlessingReceived').to_boolean())
            {
                cli_execute('friars blessing familiar');
            }
            if(!get_property('_defectiveTokenUsed').to_boolean() && $item[defective game grid token].item_amount() > 0)
            {
                use(1, $item[defective game grid token]);
            }
            if(!get_property('_clanFortuneBuffUsed').to_boolean())
            {
                cli_execute('fortune buff familiar');
            }
            maximize('familiar exp', false);
            if(item_amount($item[deviled candy egg]) > 0 && have_effect($effect[candied devil]) == 0)
            {
                use(1, $item[deviled candy egg]);
            }
            if(item_amount($item[pulled blue taffy]) > 4 && have_effect($effect[blue swayed]) < 50)
            {
                while(have_effect($effect[blue swayed]) < 50)
                {
                    use(1, $item[pulled blue taffy]);
                }
            }
            set_auto_attack('StasisFight');
            if(!familiar_adv())
            {
                set_auto_attack(0);
                return false; // ran out of fights before fattening everyone
            }
        }
    }
    set_auto_attack(0);
    return true;
}


void main()
{
    if(familiars_should())
        familiars_run();
}