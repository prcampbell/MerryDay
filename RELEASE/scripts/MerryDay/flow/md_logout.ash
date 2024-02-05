void endDay()
{
  cli_execute("familiar stooper;drink stillsuit distillate;CONSUME NIGHTCAP;");


  if(have_skill($skill[Aug. 13th: Left/Off Hander's Day!]))
  {
    use_skill($skill[Aug. 13th: Left/Off Hander's Day!]);
  }

  cli_execute("familiar left-hand man;maximize adv;");

  cli_execute("keeping-tabs");
}

void main()
{
    endDay();
}