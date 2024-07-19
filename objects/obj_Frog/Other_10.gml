///@desc Custom Methods
event_inherited();

//Handle Sprites
///@func handleSprite()
handleSprite = function()
{
	switch (state)
	{
		case consumable_state.still:
			sprite_index = frog_sprites.land;
			image_speed = 0;
			break;
	 
		case consumable_state.swim:
			if (instance_place(x, y, obj_Parent_Barrier))
			{	
				sprite_index = frog_sprites.land;
				image_speed = 1;
			}
			else
			{	
				sprite_index = frog_sprites.swim;
				image_speed = 1;
			}
			break;
		
		default:
			sprite_index = frog_sprites.land;
			image_speed = 1;
			break;
	}
}

///@func enableCollisionDetectionIfRequested()
enableCollisionDetectionIfRequested = function()
{
	if (request_enable_collision_detection)
	{
		process_collision_detection = true;
		if (checkForImpassable(x, y))
		{ process_collision_detection = false; }
		
		else
		{ request_enable_collision_detection = false; }
	}
}

//=======================================================================================
// AI FUNCTIONS
//=======================================================================================

///@func aiSeekLog()
aiSeekLog = function()
{
	// JSDOC note that _x and _y are to be input for the proposed directions we want to check
	// And nearest_log_distance is the return number from the function to be used afterward.
	
	// Find the ID of the closest instance of obj_parent_log
	var nearest_log = instance_nearest(x, y, obj_Parent_Log);

	// Return the distance of the nearest log in pixels.
	var new_direction = getDirectionToNearestLog(nearest_log);

	// Virtualise input to move in new_direction.
	ai_input_lr = lengthdir_x(1, new_direction);
	ai_input_ud = lengthdir_y(1, new_direction);
}

///@func getDirectionToNearestLog()
getDirectionToNearestLog = function(_nearest_log)
{
	// Get log coordinates.
	var log_x = _nearest_log.x;
	var log_y = _nearest_log.y;
	
	var longest_distance = point_distance(0, 0, room_width, room_height);
	var starting_direction = direction;
	var chosen_direction = direction;
	
	var check_x = x + lengthdir_x(global.game_tile_size, check_direction);
	var check_y = y + lengthdir_y(global.game_tile_size, check_direction);
	
	var shortest_distance = point_distance(check_x, check_y, log_x, log_y);
	
	if (checkForImpassable(check_x, check_y)) { shortest_distance += longest_distance; }
	
	//Create array of possible directions to travel.
	for (var i = 0; i <= 3; i += 1)
	{
		var check_direction = i * 90;
		
		if (check_direction == starting_direction) { continue; }
		
		// Calculate coordinates of next tile in current check direction.
		check_x = x + lengthdir_x(global.game_tile_size, check_direction);
		check_y = y + lengthdir_y(global.game_tile_size, check_direction);
		
		// Calculate distance between check coordinates and log coordinates.
		var this_distance = point_distance(check_x, check_y, log_x, log_y);
		
		// If the tile being checked is blocked, increase it's distance by longest_distance.
		if (checkForImpassable(check_x, check_y)) { this_distance += longest_distance; }
		
		// Check to see if this is our shortest distance yet.
		if (this_distance < shortest_distance)
		{
			shortest_distance = this_distance;
			chosen_direction = i * 90;
		}
	}
	
	return chosen_direction;
}
	
// UNDERNEATH TO BE CLEANED UP OR DELETED
/*	
	//Determine which of these directions is towards a log.
		var want_to_turn_left = 
		var want_to_turn_right = 
		var want_to_go_forward =
}



{
	var new_direction = proposed_direction;
	
	if (new_direction < 0) { new_direction += 360; }
	if (new_direction > 360) { new_direction -= 360; }
	
	var proposed_next_x = x + lengthdir_x(1, new_direction);
	var proposed_next_y = y + lengthdir_y(1, new_direction);
	
	//Moving into a collision parent is never an option.
	if checkForImpassable(proposed_next_x, proposed_next_y)
	{ return true; }
	
	//Return the proposed next space distance from the nearest log.
	aiLookForLog(proposed_next_x, proposed_next_y, nearest_log_distance)
	{ return nearest_log_distance; }
	
	return false;
}
///@func aiTurnTowardLog()
aiTurnTowardLog = function()
{
	if (!random_turn_available) { return; }
	
	var rolled_random_turn = (irandom_range(1, random_turn_range) <= random_turn_chance);
		
	if (rolled_random_turn)
	{
		//Create array of possible directions to travel.
		var possible_directions = [];
		
		//Determine which of these directions is towards a log.
		var want_to_turn_left = 
		var want_to_turn_right = 
		var want_to_go_forward =
		
		//Determine which of these directions is unblocked.
		var can_turn_left = !testDirectionBlocked(direction + 90);
		var can_turn_right = !testDirectionBlocked(direction - 90);
			
		if (can_turn_left) {array_push(possible_directions, -1);}
		if (can_turn_right) {array_push(possible_directions, 1);}
		
		var available_options = array_length(possible_directions);
		
		//Select a random unblocked direction to turn, if there are any.
		if (available_options > 0)
		{
			var random_integer = irandom(available_options - 1);
			ai_input_lr = possible_directions[random_integer]; 
			alarm[1] = random_turn_cooldown;
			random_turn_available = false;
		}
	}
}
/*