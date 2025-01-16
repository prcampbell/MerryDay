void endDay()
{
  set_property('autoBuyPriceLimit', 150000);
  cli_execute("familiar stooper;drink stillsuit distillate;CONSUME NIGHTCAP;");
  set_property('autoBuyPriceLimit', 100000);
  
  if(have_skill($skill[Aug. 13th: Left/Off Hander's Day!]))
  {
    use_skill($skill[Aug. 13th: Left/Off Hander's Day!]);
  }

  cli_execute("familiar left-hand man;maximize adv; fold tinsel tights");

  foreach it in $items[pile of gold coins, meat stack, massive gemstone, dollar-sign bag, half of a gold tooth, decomposed boot, leather bookmark, huge gold coin, moxie weed] 
  {
		if (it.item_amount() > 0) autosell(it.item_amount(), it);
	}
	
	foreach it in $items[pixellated moneybag, stolen meatpouch, solid gold jewel, ancient vinyl coin purse, duct tape wallet, old coin purse, old leather wallet, pixel coin, shiny stones, Gathered Meat-Clip, black pension check] 
  {
		if (it.item_amount() > 0) use(it.item_amount(), it);
	}
/*
  foreach it, count in get_campground()
	{
		while (it == $item[packet of tall grass seeds] &&  $item[packet of thanksgarden seeds].item_amount() > 0)
		{
			if (count == 0 && $item[Pok&eacute;-Gro fertilizer].item_amount() > 0)
			{
				use(1, $item[Pok&eacute;-Gro fertilizer]); 
			}
			if (count <= 1)
			{
				use(1, $item[packet of thanksgarden seeds]);
			}
      if (count > 1)
      {
        cli_execute('garden pick');
      }
		}
	}
*/
  if (item_amount($item[earthenware muffin tin]) > 0 ||
	    (!get_property("_muffinOrderedToday").to_boolean() && 
			$items[blueberry muffin, bran muffin, chocolate chip muffin, earthenware muffin tin] contains get_property("muffinOnOrder").to_item())) 
	{
		visit_url("place.php?whichplace=monorail&action=monorail_downtown");
		run_choice(7); 
		if (get_property("muffinOnOrder") != "")
		{
			cli_execute("refresh inv");
			if (item_amount(get_property("muffinOnOrder").to_item()) > 0)
			{
				
				set_property("muffinOnOrder", "");
			}
		}
		if (!get_property("_muffinOrderedToday").to_boolean() && item_amount($item[earthenware muffin tin]) > 0) {
			run_choice(1);
		}
		run_choice(1); 
		run_choice(8); 
	}

  cli_execute("keeping-tabs; keeping-tabs smash;");
}

void main()
{
    endDay();
}