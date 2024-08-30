///@desc Custom methods.

// Inherit the parent event
event_inherited();

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

//=======================================================================================
// PATH AUTOMATION METHODS - MECHANICAL
//=======================================================================================
///@func consumableUpdateTargetCoords()
consumableUpdateTargetCoords = function()
{
	// If on extended path, return.
	if (moving_towards_log) { return; }
	
	// In unset, return.
	if (requested_coords._x == -1) || (requested_coords._y == -1) { return; }
	
	// If there's a discrepancy, update when aligned with grid.
	if (alignedWithGrid())
	{
		if (target_coords._x != requested_coords._x)
		|| (target_coords._y != requested_coords._y)
		{
			target_coords._x = requested_coords._x;
			target_coords._y = requested_coords._y;
			
			//Convert coordinates to the center of a cell on the grid.
			var cell_destination = consumableFindCellDestination(target_coords._x, target_coords._y);
			
			//See if a path exists to the cell destination.
			var potential_path = consumableTestPath(cell_destination._x, cell_destination._y);
			
			//If a path did exist, set the current path to that path and start.
			if (potential_path != undefined)
			{
				current_path = potential_path;
				consumableStartPath();
			}
		}
	}
}

///@func consumableTestPath(_x, _y)
consumableTestPath = function(_x, _y)
{
	// Prepare a new path.
	var potential_path = path_add();
	
	// Calculate the shortest path between the object's current coordinates and the proposed target coordinates.
	var found_path = mp_grid_path(
		current_pathfinding_grid,	// This is the grid that is checked for a path.
		potential_path,								// This is the path variable within this object.
		x,											// The starting x position.
		y,											// The starting y position.
		_x,											// The proposed target x position.
		_y,											// The proposed target y position.
		false);										// Whether or not diagonal movement should be allowed (it shouldn't, in your game).
		
	// If there is no way to move to requested position, clear the path variable and return undefined.
	// Otherwise return the path.
	if (!found_path)
	{
		path_delete(potential_path);
		potential_path = undefined;
	}
	
	return potential_path;
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

	// Return the coordinates of the nearest log.
	var nearest_log_x = nearest_log.x;
	var nearest_log_y = nearest_log.y;
	
	// Set requested coordinates to log coordinates.
	requested_coords._x = nearest_log_y;
	requested_coords._y = nearest_log_y;
	
	consumableUpdateTargetCoords();
	
	moving_towards_log = true;
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