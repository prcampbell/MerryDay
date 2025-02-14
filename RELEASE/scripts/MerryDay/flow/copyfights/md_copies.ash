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
    use_familiar($familiar[obtuse angel]);
    maximize('meat drop, equip quake of arrows',false);
    set_auto_attack('CopyCrates');
    visit_url('place.php?whichplace=chateau&action=chateau_painting');
    use_familiar($familiar[jill-of-all-trades]);
    maximize('meat drop, equip backup camera',false);
    adv1($location[noob cave], -1, '');
}

void main()
{

}




