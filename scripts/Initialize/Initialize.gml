function initialize()
{	
	//Meta
	global.game_tile_size = 32;
	
	//Define player defaults
	global.player_1 = 
	{	
		current_id: noone,
		character_index: 0,
		accel_rate: 0.025,
		decel_rate: 0.05,
		max_speed: 2.5,
		max_open_speed: 5,
		max_reverse_speed: 1,
		lives_remaining: 0,
		point_total: 0,
	}

	LightsenInitialize();
	LunaInitialize();
	MiguelInitialize();
	
	room_goto(fish_test);
}