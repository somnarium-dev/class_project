function initialize()
{	
	//Define player defaults
	global.player_1 = 
	{	
		current_id: noone,
		character_index: 0,
		accel_rate: 0.025,
		decel_rate: 0.05,
		max_speed: 2.5,
		max_open_speed: 5,
		lives_remaining: 0,
		point_total: 0,
	}
	
	
	room_goto(fish_test);
	
}