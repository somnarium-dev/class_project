function initialize()
{	
	//Meta
	global.game_fps = 60;
	global.game_tile_size = 32;

	global.all_current_consumables = [];
	
	//Game definitions.
	global.current_level = 1;
	
	global.standard_time_limit_in_seconds = 60;
	global.standard_time_limit = global.game_fps * global.standard_time_limit_in_seconds; //One minute.
	global.time_remaining = 0;
	
	global.consumable_default = 
	{	
		danger_range: 64,
	}

	//Load game data.
	loadAllLevelData();
	
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
	global.level_manager = instance_create_layer(0, 0, "System", obj_Level_Manager);
	global.debug_manager = instance_create_layer(0, 0, "System", obj_Debug_Manager);

	//Debug.
	global.debug_data_enabled = false;

	//Load in-development scripts.
	LightsenInitialize();
	LunaInitialize();
	MiguelInitialize();
	
	room_goto(croc_test);
}