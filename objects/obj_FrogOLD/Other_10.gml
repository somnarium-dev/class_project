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
			image_index = 0;
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

///@func removeGrassFromCollisionIgnoreArrayWhenReady()
removeGrassFromCollisionIgnoreArrayWhenReady = function()
{
	var _index = array_get_index(collision_ignore_array, obj_Barrier_Grass);
	
	if (_index == -1) { return; }
	
	array_delete(collision_ignore_array, _index, 1);
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
	if (nearest_log == noone) { nearest_log = instance_nearest(x, y, obj_Parent_Log); }

	// Return the distance of the nearest log in pixels.
	var new_direction = getDirectionToNearestLog(nearest_log);

	// Virtualise input to move in new_direction.
	if (direction != new_direction)
	{
		ai_input_lr = dsin(direction - new_direction);
	
		if (ai_input_lr == 0)
		{ ai_input_lr = -1; }
	}
}

///@func getDirectionToNearestLog()
getDirectionToNearestLog = function(_nearest_log)
{
	// Get log coordinates.
	var log_x = nearest_log.x;
	var log_y = nearest_log.y;
	
	var longest_distance = point_distance(0, 0, room_width, room_height);
	var starting_direction = direction;
	var chosen_direction = direction;
	
	var check_x = x + lengthdir_x(global.game_tile_size, starting_direction);
	var check_y = y + lengthdir_y(global.game_tile_size, starting_direction);
	
	var shortest_distance = point_distance(check_x, check_y, log_x, log_y);
	
	if (checkForImpassable(check_x, check_y)) { shortest_distance += longest_distance; }
	
	//Test other directions to see if they shorten the distance to the log.
	for (var i = 0; i <= 3; i++)
	{
		var check_this_direction = i * 90;
		
		if (check_this_direction == starting_direction) { continue; }
		
		// Calculate coordinates of next tile in current check direction.
		check_x = x + lengthdir_x(global.game_tile_size, check_this_direction);
		check_y = y + lengthdir_y(global.game_tile_size, check_this_direction);
		
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