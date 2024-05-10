function initialize()
{	
	//Define player defaults
	global.player_1 = 
	{	
		current_id: noone,
		character_index: 0,
		accel_rate: 0.05,
		decel_rate: 0.1,
		eat_speed: 3,
		max_speed: 3.5,
		max_eat_speed: 5,
		lives_remaining: 0,
		point_total: 0,
	}
	
	room_goto(Room2);
	
}