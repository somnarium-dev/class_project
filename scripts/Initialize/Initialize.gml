function initialize()
{	
	//Meta
	global.game_tile_size = 32;
	
	global.current_player_instance = noone;
	global.all_current_fish = [];
	
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
	
	//Create persistent game objects
	global.debug_manager = instance_create_layer(0,0,"System",obj_Debug);

	//Debug.
	global.debug_data_enabled = false;

	//Load in-development scripts.
	LightsenInitialize();
	LunaInitialize();
	MiguelInitialize();
	
	room_goto(fish_test);
}