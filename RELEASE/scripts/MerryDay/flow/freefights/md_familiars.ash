boolean have(item it) {
	return it.item_amount() > 0;
}

boolean have(familiar fam) {
	return fam.have_familiar();
}

boolean have(skill skl) {
	return skl.have_skill();
}

boolean have(effect eff) {
	return eff.have_effect() > 0;
}

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
    if(!get_property('_eldritchHorrorEvoked').to_boolean())
    {
        use_skill(1, $skill[evoke eldritch horror]);
        if (my_hp() < 100) visit_url("clan_viplounge.php?action=hottub"); //Because the big eye ball beats us up
    }
    if(!get_property("_eldritchTentacleFought").to_boolean())
    {
        print("Preparing to fight the free science tent tentacle.", "purple");
        visit_url("place.php?whichplace=forestvillage&action=fv_scientist");
        run_choice($item[eldritch essence].have() ? 2 : 1);
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
            if(!familiar_adv())
            {
                set_auto_attack(0);
                return false;
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