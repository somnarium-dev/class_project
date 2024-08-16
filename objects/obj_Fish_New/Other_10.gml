///@desc Custom Methods

//=======================================================================================
// PATH AUTOMATION METHODS - STATE
//=======================================================================================

///@func consumableHandlePathAcceleration()
consumableHandlePathAcceleration = function()
{	
	// If below top speed, accelerate.
	if (path_speed < current_top_speed) { path_speed = lerp(path_speed, current_top_speed, accel_rate); }
	
	// If above top speed, decelerate.
	if (path_speed > current_top_speed) { path_speed = lerp(path_speed, current_top_speed, decel_rate); }
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

///@func consumableFindCellDestination(_x, _y)
consumableFindCellDestination = function(_x, _y)
{
	// Find the cell that contains the requested coordinates.
	var target_x_cell = floor(_x / global.game_tile_size) * global.game_tile_size;
	var target_y_cell = floor(_y / global.game_tile_size) * global.game_tile_size;
	
	// Then, find the coordinates of the center of that cell.
	var proposed_target_x = target_x_cell + floor(global.game_tile_size / 2);
	var proposed_target_y = target_y_cell + floor(global.game_tile_size / 2);
	
	//Return a struct
	return {_x : proposed_target_x, _y : proposed_target_y};
}

///@func consumableTestPath(_x, _y)
consumableTestPath = function(_x, _y)
{
	// Prepare a new path.
	var potential_path = path_add();
	
	// Calculate the shortest path between the object's current coordinates and the proposed target coordinates.
	var found_path = mp_grid_path(
		global.current_grid_controller.solid_grid,	// This is the grid that is checked for a path.
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

///@func consumableStartPath()
consumableStartPath = function()
{
	path_start(current_path, path_speed, path_action_stop, true);
}

/*
///@func testDirectionBlocked(proposed_direction)
testDirectionBlocked = function(proposed_direction)
{
	var new_direction = proposed_direction;
	
	if (new_direction < 0) { new_direction += 360; }
	if (new_direction > 360) { new_direction -= 360; }
	
	var proposed_next_x = x + lengthdir_x(1, new_direction);
	var proposed_next_y = y + lengthdir_y(1, new_direction);
	
	//Moving into an impassable tile is never an option.
	if (checkForImpassable(proposed_next_x, proposed_next_y))
	{ return true; }
	
	//Moving outside of the room is never a valid option.
	if (proposed_next_x < 0)
	|| (proposed_next_x > room_width)
	|| (proposed_next_y < 0)
	|| (proposed_next_y > room_height)
	{ return true;}
	
	return false;
}


//=======================================================================================
// AI FUNCTIONS
//=======================================================================================

///@func aiTurnWhenBlocked()
aiTurnWhenBlocked = function()
{
	//Create array of possible directions to travel.
	var possible_directions = [];
		
	//Determine which of these directions is unblocked.
	var can_turn_left = !testDirectionBlocked(direction + 90);
	var can_turn_right = !testDirectionBlocked(direction - 90);
			
	if (can_turn_left)	{ array_push(possible_directions, -1); }
	if (can_turn_right) { array_push(possible_directions, 1);  }
		
	var available_options = array_length(possible_directions);
		
	//If all directions are blocked, turn left.
	if (available_options == 0) { ai_input_lr = -1; }
	
	//If there is only one unblocked direction, take it.
	else if (available_options == 1) { ai_input_lr = possible_directions[0]; }
		
	//Otherwise, select a random unblocked direction.
	else
	{
		var random_selection = choose(0, 1);
		ai_input_lr = possible_directions[random_selection];
	}
}

///@func aiTurnAtRandom()
aiTurnAtRandom = function()
{
	if (!random_turn_available) { return; }
	
	var rolled_random_turn = (irandom_range(1, random_turn_range) <= random_turn_chance);
		
	if (rolled_random_turn)
	{
		//Create array of possible directions to travel.
		var possible_directions = [];
		
		//Determine which of these directions is unblocked.
		var can_turn_left = !testDirectionBlocked(direction + 90);
		var can_turn_right = !testDirectionBlocked(direction - 90);
			
		if (can_turn_left) {array_push(possible_directions, -1);}
		if (can_turn_right) {array_push(possible_directions, 1);}
		
		var available_options = array_length(possible_directions);
		
		//Select a random unblocked direction to turn, if there are any.
		if (available_options > 0)
		{
			var random_integer = irandom_range(1, available_options) - 1;
			ai_input_lr = possible_directions[random_integer]; 
			alarm[1] = random_turn_cooldown;
			random_turn_available = false;
		}
	}
}
*/