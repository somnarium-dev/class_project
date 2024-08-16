///@desc Custom Methods

//=======================================================================================
// PATH AUTOMATION METHODS - STATE
//=======================================================================================

///@func consumableHandlePathAcceleration()
consumableHandlePathAcceleration = function()
{	
	// If below top speed, accelerate.
	if (path_speed < current_top_speed) { path_speed = lerp(path_speed, current_top_speed, acceleration); }
	
	// If above top speed, decelerate.
	if (path_speed > current_top_speed) { path_speed = lerp(path_speed, current_top_speed, deceleration); }
}

//=======================================================================================
// PATH AUTOMATION METHODS - BEHAVIOR
//=======================================================================================

///@func consumableMockAiDirectionalMovement()
consumableMockAiDirectionalMovement = function()
{
	// This is only used for demonstrative purposes.
	// In the final object, you should use whatever behavioral logic you need to
	// determine a true intended direction while roaming, etc.
	var adjust = keyboard_check_pressed(vk_right) - keyboard_check_pressed(vk_left);
	intended_direction += adjust * -90;
	
	// This will work for swimming forward, but you could instead find a cell at an
	// arbitrary position. This would be useful when trying to swim to a log, for
	// example.
	consumableRequestNextCellInIntendedDirection();
}

//=======================================================================================
// PATH AUTOMATION METHODS - MECHANICAL
//=======================================================================================

///@func consumableRequestNextCellInIntendedDirection()
consumableRequestNextCellInIntendedDirection = function()
{
	requested_coords._x = x + lengthdir_x(global.game_tile_size, intended_direction);
	requested_coords._y = y + lengthdir_y(global.game_tile_size, intended_direction);
}

///@func consumableUpdateTargetCoords()
consumableUpdateTargetCoords = function()
{
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
			
			consumableAutomateMoveToSpecificCell(target_coords._x, target_coords._y);
		}
	}
}

///@func consumableAutomateMoveToSpecificCell(_x, _y)
consumableAutomateMoveToSpecificCell = function(_x, _y)
{
	// Find the cell that contains the requested coordinates.
	var target_x_cell = floor(_x / global.game_tile_size) * global.game_tile_size;
	var target_y_cell = floor(_y / global.game_tile_size) * global.game_tile_size;
	
	// Then, find the coordinates of the center of that cell.
	var proposed_target_x = target_x_cell + floor(global.game_tile_size / 2);
	var proposed_target_y = target_y_cell + floor(global.game_tile_size / 2);
		
	// Prepare a new path.
	current_path = path_add();
	
	// Calculate the shortest path between the object's current coordinates and the proposed target coordinates.
	var found_path = mp_grid_path(
		global.current_grid_controller.solid_grid,	// This is the grid that is checked for a path.
		current_path,								// This is the path variable within this object.
		x,											// The starting x position.
		y,											// The starting y position.
		proposed_target_x,							// The proposed target x position.
		proposed_target_y,							// The proposed target y position.
		false);										// Whether or not diagonal movement should be allowed (it shouldn't, in your game).
		
	// If a path from A to B is found, then start moving along it.
	if (found_path)
	{ 
		path_start(current_path, path_speed, path_action_stop, true);
		return true;
	}
	// Otherwise, clear the path variable. There's no way to move to the requested position.	
	else
	{
		path_delete(current_path);
		current_path = undefined;
		return false;
	}
}