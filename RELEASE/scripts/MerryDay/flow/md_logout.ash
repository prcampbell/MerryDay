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

  cli_execute("keeping-tabs");
}

void main()
{
    endDay();
}