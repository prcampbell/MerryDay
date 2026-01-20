boolean safe_pull(item it)
{
  if(item_amount(it) == 0 && storage_amount(it) > 0)
    return take_storage(1, it);
  else 
    return false;
}



void main()
{
  cli_execute('pull * meat');
  safe_pull($item[mayflower bouquet]);
  safe_pull($item[mayfly bait necklace]);
  safe_pull($item[haiku katana]);
  safe_pull($item[tiny costume wardrobe]);
  safe_pull($item[bag o' Tricks]);
  safe_pull($item[moveable feast]);
  safe_pull($item[stinky cheese eye]);
  safe_pull($item[stinky cheese diaper]);
  safe_pull($item[crown of thrones]);
  safe_pull($item[juju mojo mask]);
  safe_pull($item[greatest american pants]);
  safe_pull($item[loathing legion knife]);
  safe_pull($item[operation patriot shield]);
  safe_pull($item[box of bear arms]);
  safe_pull($item[snow suit]);
  safe_pull($item[pantsgiving]);
  safe_pull($item[buddy bjorn]);
  safe_pull($item[thor's pliers]);
  safe_pull($item[protonic accelerator pack]);
  safe_pull($item[kremlin's greatest briefcase]);
  safe_pull($item[latte lovers member's mug]);
  safe_pull($item[Kramco Sausage-o-Matic&trade;]);
  safe_pull($item[Lil' Doctor&trade; bag]);
  safe_pull($item[vampyric cloake]);
  safe_pull($item[fourth of may cosplay saber]);
  safe_pull($item[hewn moon-rune spoon]);
  safe_pull($item[beach comb]);
  safe_pull($item[eight days a week pill keeper]);
  safe_pull($item[powerful glove]);
  safe_pull($item[Guzzlr tablet]);
  safe_pull($item[bag of iunion stones]);
  safe_pull($item[cargo cultist shorts]);
  safe_pull($item[unwrapped knock-off retro superhero cape]);
  safe_pull($item[miniature crystal ball]);
  safe_pull($item[power seed]);
  safe_pull($item[backup camera]);
  safe_pull($item[familiar scrapbook]);
  safe_pull($item[industrial fire extinguisher]);
  safe_pull($item[daylight shavings helmet]);
  safe_pull($item[combat lover's locket ]);
  safe_pull($item[unbreakable umbrella]);
  safe_pull($item[june cleaver]);
  safe_pull($item[designer sweatpants]);
  safe_pull($item[tiny stillsuit]);
  safe_pull($item[jurassic parka]);
  safe_pull($item[cursed monkey's paw ]);
  safe_pull($item[cincho de mayo ]);
  safe_pull($item[august scepter]);
  safe_pull($item[candy cane sword cane]);

  //Misc

  safe_pull($item[deck of every card]);
  safe_pull($item[mumming trunk]);
  safe_pull($item[pantogram]);
  safe_pull($item[genie bottle]);
  safe_pull($item[can of rain-doh]);
  use(1, $item[can of rain-doh]);
  safe_pull($item[spooky putty sheet]);
  safe_pull($item[January's garbage tote]);
  safe_pull($item[SongBoom&trade; BoomBox]);
  safe_pull($item[Bastille battalion control rig ]);
  safe_pull($item[bird-a-day calendar]);
  safe_pull($item[SpinMaster&trade; lathe]);
  safe_pull($item[closed-circuit pay phone]);
  safe_pull($item[2002 MR. Store Catalog]);
  safe_pull($item[bittycar meatcar]);
  take_storage(storage_amount($item[source essence]), $item[source essence]);


  //Gardens
  safe_pull(1, $item[packet of mushroom spores]);
  safe_pull(1, $item[packet of rock seeds]);
  safe_pull(1, $item[packet of pumpkin seeds]);
  safe_pull(1, $item[packet of tall grass seeds]);
  safe_pull(1, $item[packet of thanksgarden seeds]);
  safe_pull(1, $item[Peppermint Pip Packet]);
  //Sheds
  safe_pull(1, $item[diabolic pizza cube]);
  safe_pull(1, $item[cold medicine cabinet]);
  safe_pull(1, $item[model train set]);
  safe_pull(1, $item[Asdon Martin keyfob (on ring)]);
  safe_pull(1, $item[cold medicine cabinet]);
  safe_pull(1, $item[little geneticist DNA-Splicing Lab]);
  safe_pull(1, $item[portable mayo clinic]);
}