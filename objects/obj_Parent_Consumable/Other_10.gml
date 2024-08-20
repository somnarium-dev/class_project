///@desc Custom Methods

//=======================================================================================
// PATH AUTOMATION METHODS - STATE
//=======================================================================================

///@func determineTopSpeed()
determineTopSpeed = function()
{
	if (behavior == consumable_behavior.panic) {current_top_speed = max_panic_speed;}
	else {current_top_speed = max_move_speed;}
}

///@func consumableHandlePathAcceleration()
consumableHandlePathAcceleration = function()
{	
	determineTopSpeed();
	
	// If below top speed, accelerate.
	if (path_speed < current_top_speed) { path_speed = lerp(path_speed, current_top_speed, accel_rate); }
	
	// If above top speed, decelerate.
	if (path_speed > current_top_speed) { path_speed = lerp(path_speed, current_top_speed, decel_rate); }
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


///@func testDirectionBlocked(proposed_direction)
testDirectionBlocked = function(proposed_direction)
{
	var new_direction = proposed_direction;
	
	if (new_direction < 0) { new_direction += 360; }
	if (new_direction > 360) { new_direction -= 360; }
	
	var proposed_next_x = x + lengthdir_x(global.game_tile_size, new_direction);
	var proposed_next_y = y + lengthdir_y(global.game_tile_size, new_direction);
	
	return consumableTestPath(proposed_next_x, proposed_next_y);
}

//=======================================================================================
// AI FUNCTIONS
//=======================================================================================

///@func aiTurnWhenBlocked()
aiTurnWhenBlocked = function()
{
	//Are we actually blocked?
	var is_blocked = testDirectionBlocked(intended_direction) == undefined;
	if (!is_blocked) { return; }
	
	var initial_direction = intended_direction;
	
	//Create array of possible directions to travel.
	var possible_directions = [];
		
	//Determine which of these directions is unblocked.
	var path_to_left = testDirectionBlocked(intended_direction + 90);
	var path_to_right = testDirectionBlocked(intended_direction - 90);
	
	if (path_to_left != undefined)	{ array_push(possible_directions, intended_direction + 90); }
	if (path_to_right != undefined) { array_push(possible_directions, intended_direction - 90); }
		
	var available_options = array_length(possible_directions);
		
	//If all directions are blocked, turn around.
	if (available_options == 0) { intended_direction += 180; }
	
	//If there is only one unblocked direction, take it.
	else if (available_options == 1) { intended_direction = possible_directions[0]; }
		
	//Otherwise, select a random unblocked direction.
	else
	{
		var random_selection = choose(0, 1);
		intended_direction = possible_directions[random_selection];
	}
	
	intended_direction = (intended_direction mod 360);

	return intended_direction != initial_direction;
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
		var path_to_left = testDirectionBlocked(intended_direction + 90);
		var path_to_right = testDirectionBlocked(intended_direction - 90);
	
		if (path_to_left != undefined)	{ array_push(possible_directions, intended_direction + 90); }
		if (path_to_right != undefined) { array_push(possible_directions, intended_direction - 90); }
		
		var available_options = array_length(possible_directions);
		
		//Select a random unblocked direction to turn, if there are any.
		if (available_options > 0)
		{
			var random_integer = irandom_range(1, available_options) - 1;
			intended_direction = possible_directions[random_integer]; 
			alarm[0] = random_turn_cooldown;
			random_turn_available = false;
		}
	}
}