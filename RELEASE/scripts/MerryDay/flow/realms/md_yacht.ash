script md_yacht;

boolean yacht_can()
{

}

boolean yacht_run()
{   
    if(have_effect($effect[fishy]) == 0 && !get_property('_fishyPipeUsed').to_boolean())
        use(1, $item[fishy pipe]);
    use_familiar($familiar[urchin urchin]);
    maximize('meat drop, equip elf guard scuba tank, -equip hodgman''s imaginary hamster, -equip hodgman''s garbage sticker', false);
    
    
    use(1, $item[clara's bell]);
    cli_execute('aprilband play tuba');
    

}

