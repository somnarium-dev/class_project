///@desc Custom Methods

//=======================================================================================
// PATH AUTOMATION METHODS
//=======================================================================================

///@func updateTargetCoords()
updateTargetCoords = function()
{
	// In unset, return.
	if (requested_coords._x == -1) || (requested_coords._y == -1) { return; }
	
	// Else, if there's a discrepancy, update when aligned with grid.
	if (alignedWithGrid())
	{
		if (target_coords._x != requested_coords._x)
		|| (target_coords._y != requested_coords._y)
		{
			target_coords._x = requested_coords._x;
			target_coords._y = requested_coords._y;
			
			automateMoveToSpecificCell(target_coords._x, target_coords._y);
		}
	}
}

///@func automateMoveToSpecificCell(_x, _y)
automateMoveToSpecificCell = function(_x, _y)
{
	var target_x_cell = floor(_x / global.game_tile_size) * global.game_tile_size;
	var target_y_cell = floor(_y / global.game_tile_size) * global.game_tile_size;
	
	var proposed_target_x = target_x_cell + floor(global.game_tile_size / 2);
	var proposed_target_y = target_y_cell + floor(global.game_tile_size / 2);
		
	current_path = path_add();
	
	var found_path = mp_grid_path(
		global.current_grid_controller.solid_grid,
		current_path,
		x,
		y,
		proposed_target_x,
		proposed_target_y,
		false);
		
	if (found_path)
	{ 
		path_start(current_path, path_speed, path_action_stop, true);
		return true;
	}
		
	else
	{
		path_delete(current_path);
		current_path = undefined;
		return false;
	}
}

///@func handlePathAcceleration()
handlePathAcceleration = function()
{
	// This function serves no purpose if there's no path defined.
	if (current_path == undefined) { return; }
	
	else
	{
		// Get data.
		var current_acceleration = acceleration;
		var current_deceleration = deceleration;
		
		path_distance_remaining = path_get_length(current_path) * (1 - path_position);
		path_max_distance = path_get_length(current_path);

		// If the remaining path distance exceeds path_run_threshold,
		// Then run to cover the distance more quickly (if enabled).

		// Accelerate per current_top_speed.
		if (path_speed < current_top_speed) { path_speed = lerp(path_speed, current_top_speed, current_acceleration); }
		else { path_speed = lerp(path_speed, current_top_speed, current_deceleration); }
	}
}

///@func pathDestinationReached()
pathDestinationReached = function()
{ 
	if (current_path = undefined) { return false; }
	
	return path_position == 1;
}