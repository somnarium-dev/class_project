/// @description Custom Methods

// Inherit the parent event
event_inherited();

//=======================================================================================
// AI FUNCTIONS
//=======================================================================================

///@func aiFindPlayer()
aiFindPlayer = function()
{
	// JSDOC note that _x and _y are to be input for the proposed directions we want to check
	// And nearest_player_distance is the return number from the function to be used afterward.
	
	// Find the ID of the closest instance of obj_parent_player
	if (nearest_player == noone) { nearest_player = instance_nearest(x, y, obj_Parent_Player); }

	// Return the distance of the nearest player in pixels.
	var new_direction = getDirectionToEscapePlayer(nearest_player);

	// Virtualise input to move in new_direction.
	if (direction != new_direction)
	{
		ai_input_lr = dsin(direction - new_direction);
	
		if (ai_input_lr == 0)
		{ ai_input_lr = -1; }
	}
}

///@func getDirectionToEscapePlayer()
// change wording to fit (eg. shortest distance, etc.)
getDirectionToEscapePlayer = function(_nearest_player)
{
	// Get player coordinates.
	var player_x = nearest_player.x;
	var player_y = nearest_player.y;
	
	var longest_distance = point_distance(0, 0, room_width, room_height);
	var starting_direction = direction;
	var chosen_direction = direction;
	
	var check_x = x + lengthdir_x(global.game_tile_size, starting_direction);
	var check_y = y + lengthdir_y(global.game_tile_size, starting_direction);
	
	var shortest_distance = point_distance(check_x, check_y, player_x, player_y);
	
	if (checkForImpassable(check_x, check_y)) { shortest_distance += longest_distance; }
	
	//Test other directions to see if they shorten the distance to the player.
	for (var i = 0; i <= 3; i++)
	{
		var check_this_direction = i * 90;
		
		if (check_this_direction == starting_direction) { continue; }
		
		// Calculate coordinates of next tile in current check direction.
		check_x = x + lengthdir_x(global.game_tile_size, check_this_direction);
		check_y = y + lengthdir_y(global.game_tile_size, check_this_direction);
		
		// Calculate distance between check coordinates and player coordinates.
		var this_distance = point_distance(check_x, check_y, player_x, player_y);
		
		// If the tile being checked is blocked, decrease it's distance by longest_distance.
		if (checkForImpassable(check_x, check_y)) { this_distance -= longest_distance; }
		
		// Check to see if this is our longest distance yet.
		if (this_distance > shortest_distance)
		{
			shortest_distance = this_distance;
			chosen_direction = i * 90;
		}
	}
	
	return chosen_direction;
}