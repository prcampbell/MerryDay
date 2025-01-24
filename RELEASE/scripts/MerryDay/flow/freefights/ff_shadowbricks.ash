script ff_bricks;

boolean eaglebrick_can()
{
    return get_property('_shadowBricksUsed') < 13 
            && have_effect($effect[citizen of a zone]) == 0 
            && can_adventure($location[lair of the ninja snowmen]);
}

boolean eaglebrick_run()
{
    use_familiar($familiar[patriotic eagle]);
    return adv1($location[lair of the ninja snowmen], -1, 'skill 7449; use shadow brick;');
}