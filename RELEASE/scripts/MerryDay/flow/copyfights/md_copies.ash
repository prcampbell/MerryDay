$monster target = $monster[witchess knight];


/*
1. Obtuse Angel, Initial Digitize + copiers
2. Backup into Noob Cave, where we can also olfact crates + habitat
3. Habitats



*/

int copyCount()
{
    int count = 0;
    //11 backups
    //18 habitats with orb
    //10 cheats
    //10 macros
    //6 putty
    //11 mimics
    //3 romantic
    //1 chateau painting
    //1 fax
    //1 4-d camera
    //
}

boolean angel_run()
{
    cli_execute('closet take 1 spooky putty sheet');
    use_familiar($familiar[obtuse angel]);
    maximize('meat drop, equip quake of arrows',false);
    set_auto_attack('BackupMeat');
    visit_url('place.php?whichplace=chateau&action=chateau_painting');
    use_familiar($familiar[jill-of-all-trades]);
    maximize('meat drop, equip backup camera, equip Roman Candelabra',false);
    adv1($location[noob cave], -1, '');
    use_familiar($familiar[jill-of-all-trades]);
    maximize('meat drop, equip powerful glove, equip latte lover',false);
}

void main()
{

}


if hasskill 7108 #fire a badly romantic arrow
    skill 7108
endif


if monstername crate
if hasskill transcendent olfaction
skill transcendent olfaction
endif
 if hasskill 7326 # Switch Enemy
  skill 7326
 endif
endif

if monstername crate

 if hasskill macrometeor
  skill macrometeor
 endif
endif



if monstername crate
 if hasskill 7381 # Back-up To your Last Enemy
  skill 7381
 endif
endif

if !monstername tumbleweed
if monstername cockroach

    if hasskill 7526 #Purple Candle
    skill 7526
    endif
if hascombatitem spooky putty sheet && hascombatitem rain-doh black box
        use spooky putty sheet, rain-doh black box
    endif

    if hascombatitem 4-d camera || hascombatitem unfinished ice sculpture
        if hascombatitem print screen button
            use print screen button
        endif
        if hascombatitem 4-d camera && !hascombatitem unfinished ice sculpture
            use 4-d camera
        endif
        if !hascombatitem 4-d camera && hascombatitem unfinished ice sculpture
            use unfinished ice sculpture
        endif
        if hascombatitem 4-d camera && hascombatitem unfinished ice sculpture
            use 4-d camera, unfinished ice sculpture
        endif
        if hascombatitem alpine watercolor set
            use alpine watercolor set
        endif
    endif
if hasskill 7526 #Purple Candle
skill 7526
endif
if match CTRL+V && hasskill digitize
skill digitize
endif
    if hasskill 7485 #habitat
        skill 7485
    endif
endif
if hasskill Micrometeorite
    skill Micrometeorite
endif
if hasskill sing along
    skill sing along
endif
if hasskill summon hobo underling
    skill summon hobo underling
endif
if hasskill Ask the hobo to tell you a joke
    skill Ask the hobo to tell you a joke
endif

if hasskill become a wolf
    skill become a wolf
endif
if hasskill Bowl Straight Up
    skill Bowl Straight Up
endif

if hascombatitem time-spinner
    use time-spinner
endif
if hascombatitem rain-doh indigo cup
    use rain-doh indigo cup
endif
if hasskill pocket crumbs
    skill pocket crumbs
endif
if hasskill furious wallop
    skill furious wallop
endif
while !hppercentbelow 25 && !pastround 27
    attack
endwhile
endif



