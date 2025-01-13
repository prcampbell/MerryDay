script "ff_glitch";

boolean glitch_reward_have() {
	return item_amount($item[[glitch season reward name]]) > 0;
}

int glitch_reward_fights() {
	return get_property("_glitchMonsterFights").to_int();
}

boolean glitch_reward_fight_can() {
	return glitch_reward_have() && glitch_reward_fights() < 1;
}

boolean glitch_reward_fight_run() {
	int fights = glitch_reward_fights();
	$item[[glitch season reward name]].use();
	print("Fighting a %monster%.", "purple");
	visit_url("inv_eat.php?&which=1&whichitem=10207&pwd=" + my_hash());
	run_combat();
	return fights +1 == glitch_reward_fights();
}

void main()
{
	if(glitch_reward_fight_can())
		glitch_reward_fight_run();
}