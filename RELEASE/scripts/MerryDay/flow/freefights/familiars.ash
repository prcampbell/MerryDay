boolean familiarToFatten()
{
    if($familiar[pocket professor].experience < 400)
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
    if(get_property('_speakeasyFreeFights').to_int() < 3)
    {
        return adv1($location[an unusually quiet barroom brawl], -1, '');
    }
    return false;
}

boolean familiars_run()
{
    while(familiars_should())
    {
        if(familiarToFatten())
        {
            maximize('familiar exp', false);
            if(item_amount($item[pulled blue taffy]) > 4 && have_effect($effect[blue swayed]) < 50)
            {
                while(have_effect($effect[blue swayed]) < 50)
                {
                    use(1, $item[pulled blue taffy]);
                }
            }
            set_auto_attack('StasisFight');
            familiar_adv();
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