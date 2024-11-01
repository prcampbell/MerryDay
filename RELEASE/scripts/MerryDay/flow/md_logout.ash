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
		if (it.have()) autosell(it.item_amount(), it);
	}
	
	foreach it in $items[pixellated moneybag, stolen meatpouch, solid gold jewel, ancient vinyl coin purse, duct tape wallet, old coin purse, old leather wallet, pixel coin, shiny stones, Gathered Meat-Clip, black pension check] 
  {
		if (it.have()) it.use_all();
	}

  foreach it, count in get_campground()
	{
		if (it == pokeGarden && thanksGarden.item_amount() > 0)
		{
			if (count == 0 && $item[Pok&eacute;-Gro fertilizer].item_amount() > 0)
			{
				use(1, $item[Pok&eacute;-Gro fertilizer]); // this will get converted to a single cornucopia, but it should grow to 3 tomorrow
			}
			if (count <= 1)
			{
				use(1, thanksGarden);
			}
		}
	}

  cli_execute("keeping-tabs");
}

void main()
{
    endDay();
}