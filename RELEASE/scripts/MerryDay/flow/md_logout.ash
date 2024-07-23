void endDay()
{
  set_property('autoBuyPriceLimit', 150000);
  if(mall_price($item[vintage smart drink]) < mall_price($item[emergency margarita]))
    acquire(1, $item[vintage smart drink]));
  else
    acquire(1, $item[emergency margarita]));

  if(available_amount($item[vintage smart drink]) > 0)
    cli_execute("familiar stooper;drink stillsuit distillate;drinksilent vintage smart drink;");
  else
    cli_execute("familiar stooper;drink stillsuit distillate;drinksilent emergency margarita;");
  set_property('autoBuyPriceLimit', 100000);


  if(have_skill($skill[Aug. 13th: Left/Off Hander's Day!]))
  {
    use_skill($skill[Aug. 13th: Left/Off Hander's Day!]);
  }

  cli_execute("familiar left-hand man;maximize adv; fold tinsel tights");

  cli_execute("keeping-tabs");
}

void main()
{
    endDay();
}